ALTER TABLE [dbo].[TakePart]
    ADD CONSTRAINT [FK_TakePart_Project]
    FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Project] ([ProjectId])
    ON DELETE CASCADE 
    ON UPDATE NO ACTION
