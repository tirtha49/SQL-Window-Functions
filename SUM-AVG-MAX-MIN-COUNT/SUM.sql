
USE SalesDB

-- Find the total sales across all orders
-- and the total sales for each product
-- Additionally, provide details such as order ID and order date

SELECT * FROM Sales.Orders

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER() AS [TotalSalesAcrossAllOrders],
	SUM(Sales) OVER(PARTITION BY ProductID) AS [TotalSalesForEachProduct]
FROM Sales.Orders

-- Find the percentage contribution of
-- each product's sales to the total sales

SELECT 
	OrderID,
	ProductID,
	Sales,
	SUM(Sales) OVER() AS [TotalSales],
	ROUND(CAST(Sales AS Float) / SUM(Sales) OVER() * 100,2) 
FROM Sales.Orders


-- Percentage contribution of each product in the total sales 

SELECT 
	OrderID,
	ProductID,
	Sales,
	SUM(Sales) OVER() AS [TotalSales],
	SUM(Sales) OVER(PARTITION BY ProductID) AS [EachProductSale],
	ROUND(CAST(SUM(Sales) OVER(PARTITION BY ProductID) AS FLOAT) / CAST(SUM(Sales) OVER() AS FLOAT) * 100 , 2)
FROM Sales.Orders

SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='Sales' AND TABLE_NAME='Orders'

SELECT * FROM Sales.Orders

SELECT 
	ProductID,
	SUM(Sales)
FROM Sales.Orders
GROUP BY ProductID
