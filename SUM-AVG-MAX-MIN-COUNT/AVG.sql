
USE SalesDB

-- Find the average sales across all orders
-- and the average sales for each product

SELECT * FROM Sales.Orders

SELECT 
	OrderID,
	ProductID,
	AVG(Sales) OVER() AS [AvgSale],
	AVG(Sales) OVER(PARTITION BY ProductID) AS [AvgSalesEachProduct]
FROM Sales.Orders 

-- Find the average scores of customers
-- Additionally, provide details such as Customer ID and full name

SELECT * FROM Sales.Customers

SELECT 
	CustomerID,
	CONCAT(FirstName, ' ', LastName) AS [FullName],
	Score,
	COALESCE(Score, 0) AS [NonNullScore],
	AVG(Score) OVER() AS [AvgScoreWithNull],
	AVG(COALESCE(Score, 0)) OVER() AS [AvgScoreWithOutNull]
FROM Sales.Customers

-- Find all orders where sales
-- are higher than the average sales across all orders

SELECT * FROM Sales.Orders

SELECT * FROM (
	SELECT 
		OrderID,
		Sales,
		AVG(Sales) OVER() AS [AvgSales]
	FROM Sales.Orders
)t WHERE Sales > AvgSales