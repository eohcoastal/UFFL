CREATE TABLE [uffl].[FileSchema] (
    [FileSchemaID]         INT            IDENTITY (1, 1) NOT NULL,
    [FileName]             VARCHAR (150)  NOT NULL,
    [RowsToSkipFromTop]    INT            NOT NULL,
    [RowsToSkipFromBottom] INT            NOT NULL,
    [RowIndexesToIgnore]   VARCHAR (50)   NULL,
    [ColumnDelim]          CHAR (1)       NULL,
    [FileSchema]           VARCHAR (2000) NOT NULL,
    [FileDescription]      VARCHAR (MAX)  NULL,
    CONSTRAINT [PK_FileSchema] PRIMARY KEY CLUSTERED ([FileSchemaID] ASC)
);

