USE ShopHere
GO

--CONSTRAINTS
ALTER TABLE Items.ItemDetails
ADD CONSTRAINT PK_EmployeeID PRIMARY KEY (ItemID)
ALTER TABLE Items.ItemDetails
ADD CONSTRAINT CK_QtyInHand CHECK (QuantityInHand > 0)
ALTER TABLE Items.ItemDetails
ADD CONSTRAINT CK_UnitPrice CHECK (UnitPrice > 0)
ALTER TABLE Items.ItemDetails
ADD CONSTRAINT CK_ReorderLevel CHECK (ReorderLevel > 0)
ALTER TABLE Items.ItemDetails
ADD CONSTRAINT CK_ReorderQuantity CHECK (ReorderQuantity > 0)
ALTER TABLE Item.ItemDetails
ADD CONSTRAINT FK_CategoryID FOREIGN KEY (CategoryID) REFERENCES Items.ProductCategory(CategoryID)
ALTER TABLE Item.ItemDetails
ADD CONSTRAINT FK_SupplierID FOREIGN KEY (SupplierID) REFERENCES Supplier.SupplierDetails(SupplierID)
GO

ALTER TABLE Supplier.SupplierDetails
ADD CONSTRAINT PK_SupplierID PRIMARY KEY (SupplierID)
ALTER TABLE Supplier.SupplierDetails
ADD CONSTRAINT CK_Phone
CHECK (PHONE LIKE '[0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]')
GO

ALTER TABLE Items.ProductCategory
ADD CONSTRAINT PK_CategoryID PRIMARY KEY (CategoryID)
ALTER TABLE Items.ProductCategory
ADD CONSTRAINT CK_CategoryDesc
CHECK (CategoryDescription IN ('Household', 'Sports', 'Accessories', 'Clothing'))
GO

ALTER TABLE HumanResources.Employee
ADD CONSTRAINT PK_EmployeeID PRIMARY KEY (EmployeeID)
ALTER TABLE HumanResources.Employee
ADD CONSTRAINT CK_Phone 
CHECK (Phone LIKE '[0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]')
GO

ALTER TABLE Transactions.OrderDetails
ADD CONSTRAINT PK_PurchaseOrderID PRIMARY KEY (PurchaseOrderID)
ALTER TABLE Transactions.OrderDetails
ADD CONSTRAINT CK_QtyOrdered CHECK (QuantityOrdered > 0)
ALTER TABLE Transactions.OrderDetails
ADD CONSTRAINT CK_QtyReceived CHECK (QuantityReceived > 0)
ALTER TABLE Transactions.OrderDetails
ADD CONSTRAINT CK_UnitPrice CHECK (UnitPrice > 0)
ALTER TABLE Transactions.OrderDetails
ADD CONSTRAINT CK_OrderDate CHECK (OrderDate <= GETDATE())
ALTER TABLE Transactions.OrderDetals
ADD CONSTRAINT DF_OrderDate DEFAULT GETDATE()
ALTER TABLE Transactions.OrderDetails
ADD CONSTRAINT CK_OrderStatus CHECK (OrderStatus IN ('InTransit', 'Received', 'Cancelled'))
ALTER TABLE Transactions.OrderDetails
ADD CONSTRAINT CK_AmountCheck CHECK (QuantityReceived <= QuantityOrdered)
ALTER TABLE Transactions.OrderDetails
ADD CONSTRAINT FK_EmployeeID FOREIGN KEY REFERENCES HumanResources.Employee(EmployeeID)
ALTER TABLE Transactions.OrderDetails
ADD CONSTRAINT FK_ItemID FOREIGN KEY (ItemID) REFERENCES Items.ItemDetails(ItemID)
GO
