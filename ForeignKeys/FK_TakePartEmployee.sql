ALTER TABLE [dbo].[TakePart]
    ADD CONSTRAINT [FK_TakePart_Employee]
    FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
    ON DELETE CASCADE 
    ON UPDATE NO ACTION