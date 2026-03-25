ALTER TABLE [dbo].[Write]
    ADD CONSTRAINT [FK_Write_Post]
    FOREIGN KEY ([PostId]) REFERENCES [dbo].[Post] ([PostId])
    ON DELETE CASCADE 
    ON UPDATE NO ACTION