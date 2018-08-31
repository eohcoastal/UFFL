/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
SET IDENTITY_INSERT [uffl].[FileSchema] ON 
GO
INSERT [uffl].[FileSchema] ([FileSchemaID], [FileName], [RowsToSkipFromTop], [RowsToSkipFromBottom], [RowIndexesToIgnore], [ColumnDelim], [FileSchema], [FileDescription]) VALUES (3, N'People.csv', 0, 0, N'1', N',', N'[{"FieldOrdinalPosition":1,"FieldName":"PersonID","FieldType":"int"},{"FieldOrdinalPosition":2,"FieldName":"FullName","FieldType":"nvarchar(50)"},{"FieldOrdinalPosition":3,"FieldName":"PreferredName","FieldType":"nvarchar(50)"},{"FieldOrdinalPosition":4,"FieldName":"SearchName","FieldType":"nvarchar(101)"},{"FieldOrdinalPosition":5,"FieldName":"IsPermittedToLogon","FieldType":"bit"},{"FieldOrdinalPosition":6,"FieldName":"LogonName","FieldType":"nvarchar(50)"},{"FieldOrdinalPosition":7,"FieldName":"IsExternalLogonProvider","FieldType":"bit"},{"FieldOrdinalPosition":8,"FieldName":"IsSystemUser","FieldType":"bit"},{"FieldOrdinalPosition":9,"FieldName":"IsEmployee","FieldType":"bit"},{"FieldOrdinalPosition":10,"FieldName":"IsSalesperson","FieldType":"bit"},{"FieldOrdinalPosition":11,"FieldName":"PhoneNumber","FieldType":"nvarchar(20)"},{"FieldOrdinalPosition":12,"FieldName":"FaxNumber","FieldType":"nvarchar(20)"},{"FieldOrdinalPosition":13,"FieldName":"EmailAddress","FieldType":"nvarchar(256)"},{"FieldOrdinalPosition":14,"FieldName":"LastEditedBy","FieldType":"int"},{"FieldOrdinalPosition":15,"FieldName":"ValidFrom","FieldType":"datetime2(7)"},{"FieldOrdinalPosition":16,"FieldName":"ValidTo","FieldType":"datetime2(7)"}]', N'CSV based on Application.People in WideWorldImporters database')
GO
SET IDENTITY_INSERT [uffl].[FileSchema] OFF