IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [Movie] (
    [ID] int NOT NULL IDENTITY,
    [Genre] nvarchar(max) NULL,
    [Price] decimal(18, 2) NOT NULL,
    [ReleaseDate] datetime2 NOT NULL,
    [Title] nvarchar(max) NULL,
    CONSTRAINT [PK_Movie] PRIMARY KEY ([ID])
);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171101002639_Initial', N'2.0.0-rtm-26452');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171101004935_InitialCreate', N'2.0.0-rtm-26452');

GO

ALTER TABLE [Movie] ADD [Rating] nvarchar(max) NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171101013559_Rating', N'2.0.0-rtm-26452');

GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'Movie') AND [c].[name] = N'Title');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Movie] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Movie] ALTER COLUMN [Title] nvarchar(60) NOT NULL;

GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'Movie') AND [c].[name] = N'Rating');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Movie] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [Movie] ALTER COLUMN [Rating] nvarchar(5) NOT NULL;

GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'Movie') AND [c].[name] = N'Genre');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Movie] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [Movie] ALTER COLUMN [Genre] nvarchar(30) NOT NULL;

GO

CREATE TABLE [Review] (
    [ReviewID] int NOT NULL IDENTITY,
    [Comment] nvarchar(max) NOT NULL,
    [MovieID] int NOT NULL,
    [Reviewer] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Review] PRIMARY KEY ([ReviewID]),
    CONSTRAINT [FK_Review_Movie_MovieID] FOREIGN KEY ([MovieID]) REFERENCES [Movie] ([ID]) ON DELETE CASCADE
);

GO

CREATE INDEX [IX_Review_MovieID] ON [Review] ([MovieID]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171111053018_Reviews', N'2.0.0-rtm-26452');

GO

ALTER TABLE [Review] DROP CONSTRAINT [FK_Review_Movie_MovieID];

GO

ALTER TABLE [Review] DROP CONSTRAINT [PK_Review];

GO

DROP INDEX [IX_Review_MovieID] ON [Review];

GO

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'Review') AND [c].[name] = N'ReviewID');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Review] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [Review] DROP COLUMN [ReviewID];

GO

ALTER TABLE [Review] ADD [ID] int NOT NULL IDENTITY;

GO

ALTER TABLE [Review] ADD CONSTRAINT [PK_Review] PRIMARY KEY ([ID]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171117230351_newtest', N'2.0.0-rtm-26452');

GO

