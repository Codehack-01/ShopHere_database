USE ShopHere
GO

--TRIGGERS
CREATE TRIGGER UpdateQty
ON Transactions.OrderDetails FOR INSERT
AS
BEGIN
	DECLARE @QtyRec int, @QtyInHand int, @ItemID int
	SELECT @QtyRec = QuantityReceived FROM inserted
	SELECT @ItemID = ItemID FROM inserted
	IF EXISTS (SELECT * FROM Items.ItemDetails WHERE ItemID = @ItemID)
	BEGIN
		SELECT @QtyInHand = QuantityInHand FROM Items.ItemDetails WHERE ItemID = @ItemID
		UPDATE Items.ItemDetails
		SET QuantityInHand = @QtyInHand + @QtyRec WHERE ItemID = @ItemID
	END
END
GO

CREATE TRIGGER ModificationLock
ON Items.ItemDetails INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @QtyInHand int, @ItemID int, @NewQty int
	SELECT @ItemID = ItemID FROM inserted
	SELECT @NewQty = QuantityInHand FROM inserted
	SELECT @QtyInHand = QuantityInHand FROM Items.ItemDetails WHERE ItemID = @ItemID
	IF @@NESTLEVEL = 1 AND @QtyInHand = 0
		BEGIN
		PRINT 'Manual Modification not allowed When Quantity in Hand is 0'
		END
	ELSE
		BEGIN
		UPDATE Items.ItemDetails
		SET QuantityInHand = @NewQty WHERE ItemID = @ItemID
		END
END
GO


--STORED PROCEDURES
CREATE PROC TotalCostOfOrder @POrderID int
AS
BEGIN
	DECLARE @TotalCost int, @UnitPrice int, @QtyRec int
	SELECT @QtyRec = QuantityReceived FROM Transactions.OrderDetails WHERE PurchaseOrderID = @POrderID
	SELECT @UnitPrice = UnitPrice FROM Transactions.OrderDetails WHERE PurchaseOrderID = @POrderID
	SET @TotalCost = @QtyRec * @UnitPrice
	PRINT 'Total cost of the order with Purchase ID ' + convert(varchar(3), @POrderID) + ' is ' + convert(varchar(25), @TotalCost)
END
GO

--FUNCTIONS
CREATE FUNCTION TotalOrderByEmployee(@EmpID int, @Month int)
RETURNS @Res TABLE (PurchaseOrderID int, EmployeeID int, ItemID int,
QuantityOrdered int, QuantityReceived int, UnitPrice int, TotalCost int, CumulativeTotalCost int, Orderdate date) 
AS
BEGIN
	INSERT @Res
	SELECT PurchaseOrderID, EmployeeID, ItemID, QuantityOrdered,
	QuantityReceived, UnitPrice, TotalCost = QuantityReceived * UnitPrice,
	CumulativeTotalCost = SUM((QuantityReceived * UnitPrice)) OVER (ORDER BY PurchaseOrderID), Orderdate
	FROM Transactions.OrderDetails WHERE (EmployeeID = @EmpID AND  DATEPART(month, Orderdate) = @Month)
	RETURN
END
GO
