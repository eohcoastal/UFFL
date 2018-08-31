/************************************************************************************
	To do:
	10	Build @RowIndexesToIgnore logic in to CTE ExcusedRows
	20	TRY_CAST looking for casting faults?
************************************************************************************/

DROP TABLE IF EXISTS #UniversalMorphic
/************************************************************************************
	Parameters
************************************************************************************/
DECLARE	 @FileSchemaID		INT	= 3

/************************************************************************************
	Variables
************************************************************************************/
DECLARE	 @RowsToSkipFromTop		INT
		,@RowsToSkipFromBottom	INT
		,@RowIndexesToIgnore	VARCHAR(50)
		,@ColumnDelim			CHAR(1)
		,@FileSchema			VARCHAR(2000)
		,@NumberOfFields		INT
		,@SQL					VARCHAR(1000)	= ''

DECLARE @FileSchemaTable TABLE
(
	 FieldOrdinalPosition	INT
	,FieldName				SYSNAME
	,FieldType				VARCHAR(100)
)

SELECT	 @RowsToSkipFromTop		= RowsToSkipFromTop
		,@RowsToSkipFromBottom	= RowsToSkipFromBottom
		,@RowIndexesToIgnore	= RowIndexesToIgnore	--	Unhandled
		,@ColumnDelim			= ColumnDelim			--	Unhandled
		,@FileSchema			= FileSchema			--	Unhandled
FROM uffl.FileSchema
WHERE FileSchemaID = @FileSchemaID

INSERT INTO @FileSchemaTable
SELECT	 FieldOrdinalPosition
		,FieldName
		,FieldType
FROM OPENJSON(@FileSchema)
WITH
(
	 FieldOrdinalPosition	INT
	,FieldName				SYSNAME
	,FieldType				VARCHAR(100)
)

SELECT @NumberOfFields = MAX(FieldOrdinalPosition)
FROM @FileSchemaTable

/************************************************************************************
	Basis Logique 
************************************************************************************/
;WITH ExcusedRows AS
(
	SELECT	 FileRowID
			,FileRowContent
	FROM
	(
		SELECT	 FileRowID
				,FileRowContent
				,Idx		= ROW_NUMBER() OVER (ORDER BY FileRowID ASC)
				,Rev_Idx	= ROW_NUMBER() OVER (ORDER BY FileRowID DESC)
		FROM uffl.UniversalReceiver	URC	
		WHERE FileSchemaID = @FileSchemaID
	)DT
	WHERE Idx > @RowsToSkipFromTop
	AND Rev_Idx > @RowsToSkipFromBottom
)
,FixedWidthHandling AS
(
	SELECT	 FileRowID
			,FileRowContent	= IIF	(
										 @ColumnDelim = '' 
										 --	Normalise spaces to one space in the case of fixed width shit thats not tab seperated
										,REPLACE(REPLACE(REPLACE(FileRowContent, ' ', '~^'), '^~', ''), '~^', ' ')
										,FileRowContent
									)
	FROM ExcusedRows
)
SELECT	 FWH.FileRowID
		,GSC.*
INTO #UniversalMorphic
FROM FixedWidthHandling			FWH
CROSS 
APPLY uffl.tvf_DelimStrToColumn(FileRowContent, @ColumnDelim) 
								GSC
ORDER BY FileRowID

SELECT * FROM #UniversalMorphic ORDER BY FileRowID

/************************************************************************************
	Polymorphic Logique 
************************************************************************************/

SELECT @SQL = @SQL + CONCAT	(
								 IIF(FieldOrdinalPosition = 1, '', ',')
								,QUOTENAME(FieldName)
								,' = CAST('
								,QUOTENAME(FieldOrdinalPosition)
								,' AS '
								,FieldType
								,')'
								, CHAR(10) + CHAR(13)
							)
FROM @FileSchemaTable

SET @SQL = 'SELECT ' + @SQL + CHAR(10) + CHAR(13) + ' FROM #UniversalMorphic ORDER BY FileRowID' 

PRINT @SQL
EXECUTE (@SQL)


