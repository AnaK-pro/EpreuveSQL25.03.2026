ALTER TABLE [dbo].[Concern]
    ADD CONSTRAINT [FK_Concern_Post]
    FOREIGN KEY ([PostId]) REFERENCES [dbo].[Post] ([PostId])
    ON DELETE CASCADE ON UPDATE NO ACTION