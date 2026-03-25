ALTER TABLE [dbo].[Concern]
    ADD CONSTRAINT [FK_Concern_Project]
    FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Project] ([ProjectId])
    ON DELETE CASCADE 
    ON UPDATE NO ACTION