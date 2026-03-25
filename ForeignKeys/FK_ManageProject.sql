ALTER TABLE [dbo].[Manage]
    ADD CONSTRAINT [FK_Manage_Project]
    FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Project] ([ProjectId])
    ON DELETE CASCADE 
    ON UPDATE NO ACTION