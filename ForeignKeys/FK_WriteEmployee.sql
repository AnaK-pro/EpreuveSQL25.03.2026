ALTER TABLE [dbo].[Write]
    ADD CONSTRAINT [FK_Write_Employee]
    FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
    ON DELETE CASCADE 
    ON UPDATE NO ACTION