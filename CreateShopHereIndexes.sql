USE ShopHere
GO

--INDEXES
CREATE NONCLUSTERED INDEX IX_OrderDetails_Date ON
Transactions.OrderDetails(OrderDate)
GO

CREATE NONCLUSTERED INDEX IX_ItemDetails_Supplier ON
Items.ItemDetails(SupplierID)
GO