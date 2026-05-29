
USE SalesDB

-- Which Tables are present in this DB

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'

-- Checking out the table

SELECT * FROM Sales.Orders
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='Sales' AND TABLE_NAME='Orders'

-- Find the total Sales across all orders 

SELECT SUM(sales) AS [TotalSales]
FROM Sales.Orders

-- Find the total Sales for each product

SELECT  ProductID, SUM(sales) AS [TotalSalesForEachProd]
FROM Sales.Orders
GROUP BY ProductID

-- Find the total Sales for each product 
-- additionally provide details such order ID & order date

SELECT 
	ProductID,
	OrderId,
	OrderDate,
	SUM(sales) OVER(PARTITION BY ProductID)
FROM Sales.Orders

-- Find the total Sales for all orders 
-- additionally provide details such order ID & order date

SELECT * FROM Sales.Orders

SELECT 
	OrderID,
	OrderDate,
	SUM(Sales) OVER() AS [TotalSales]
FROM Sales.Orders

-- Find the total sales for each
-- combination of product and order status

SELECT * FROM Sales.Orders

SELECT 
	ProductID,
	OrderStatus,
	SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) AS [TotalSales]
FROM Sales.Orders

-- Rank each order based on their sales from highest to lowest
-- Additionally provide details such order Id, order date

SELECT * FROM Sales.Orders

SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus 
	ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS [TotalSales]
FROM Sales.Orders

-- Find the total sales for each order status
-- only for two products 101 and 102

SELECT * FROM Sales.Orders

SELECT 
	OrderStatus,
	ProductID,
	SUM(Sales) OVER(PARTITION BY OrderStatus) AS [TotalSales]
FROM Sales.Orders
WHERE ProductID IN (101,102)

-- Rank customers based on their total sales

SELECT * FROM Sales.Orders

SELECT 
	CustomerID,
	SUM(Sales) [TotalSales],
	RANK() OVER(ORDER BY SUM(Sales) DESC)
FROM Sales.Orders
GROUP BY CustomerID

