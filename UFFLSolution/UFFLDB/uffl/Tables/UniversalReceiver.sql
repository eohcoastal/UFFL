CREATE TABLE [uffl].[UniversalReceiver] (
    [FileRowID]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [FileSchemaID]   INT            NOT NULL,
    [FileRowContent] VARCHAR (4000) NOT NULL,
    CONSTRAINT [PK_UniversalReceiver] PRIMARY KEY CLUSTERED ([FileRowID] ASC),
    CONSTRAINT [FK_UniversalReceiver_FileSchema] FOREIGN KEY ([FileSchemaID]) REFERENCES [uffl].[FileSchema] ([FileSchemaID])
);

