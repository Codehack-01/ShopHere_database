USE ShopHere
GO

--SCHEMAS
CREATE SCHEMA Items
GO
CREATE SCHEMA Supplier
GO
CREATE SCHEMA HumanResources
GO
CREATE SCHEMA Transactions
GO

--TABLES
CREATE TABLE Items.ItemDetails (
ItemID int identity(1,1),
ItemName varchar(25) NOT NULL,
ItemDescription varchar(40) NOT NULL,
UnitPrice money,
QuantityInHand int,
ReorderLevel int,
ReorderQuantity int,
CategoryID int,
SupplierID int,
)
GO

CREATE TABLE Items.ProductCategory (
CategoryID int identity(1,1),
CategoryName varchar(20) NOT NULL,
CategoryDescription varchar(11) NOT NULL,
)
GO

CREATE TABLE Supplier.SupplierDetails (
SupplierID int identity(1,1),
FirstName varchar(10) NOT NULL,
LastName varchar(10) NOT NULL,
Address varchar(40) NOT NULL,
Phone varchar(19) NOT NULL,
Country varchar(10) NOT NULL,
)
GO

CREATE TABLE HumanResources.Employee (
EmployeeID int identity(1,1),
FirstName varchar(10) NOT NULL,
LastName varchar(12) NOT NULL,
City varchar(10) NOT NULL,
Phone varchar(19) NOT NULL
)
GO

CREATE TABLE Transactions.OrderDetails (
PurchaseOrderID int identity(1,1),
EmployeeID int,
OrderDate date NOT NULL,
ReceivingDate date,
ItemID int,
QuantityOrdered int NOT NULL,
QuantityReceived int,
UnitPrice int NOT NULL,
ShipMethod varchar(5),
OrderStatus varchar(9) NOT NULL,
)
GO
