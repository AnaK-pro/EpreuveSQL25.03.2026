ALTER TABLE [dbo].[Link]
    ADD CONSTRAINT [FK_Link_Employee]
    FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
    ON DELETE CASCADE 
    ON UPDATE NO ACTION