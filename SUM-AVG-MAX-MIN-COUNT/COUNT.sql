
USE SalesDB

--                        COUNT() 
----------------------------------------------------------------
-- Returns the number of rows within a window
-- count Non-null only

SELECT * FROM Sales.Orders

-- Find total number of Orders

SELECT COUNT(*) FROM Sales.Orders

-- Find total number of Orders
-- additionally provide details such as OrderID, OrderDate

SELECT
	OrderID,
	OrderDate,
	COUNT(*) OVER() AS [TotalOrders]
FROM Sales.Orders

-- Find the total orders for each customer 

SELECT 
	CustomerID, 
	COUNT(*) AS [TotalOrderPerCustomer] 
FROM Sales.Orders 
GROUP BY CustomerID

-- Find the total orders for each customer 
-- additionally provide details such as OrderID, OrderDate

SELECT 
	CustomerID, 
	OrderID,
	OrderDate,
	COUNT(*) OVER(PARTITION BY CustomerID) AS [TotalOrderPerCustomer] 
FROM Sales.Orders

-- Find the total no of customers

SELECT COUNT(DISTINCT CustomerID) FROM Sales.Orders

-- Find the total no of customers from Sales.Customers
-- additionally provide all customer's details 

SELECT * FROM Sales.Customers

SELECT *,
	COUNT(*) OVER()
FROM Sales.Customers

-- Find the total number of scores for the customers
-- from Sales.Customers

SELECT *,
	COUNT(Score) OVER()
FROM Sales.Customers

-- Check whether the table 'Orders'
-- contains any duplicate rows

SELECT 
	OrderID, 
	COUNT(*) OVER(PARTITION BY OrderId) 
FROM Sales.Orders
-- or
SELECT OrderID, COUNT(*) FROM Sales.Orders GROUP BY OrderID

---------------------------------------------------------------------------------

SELECT * FROM Sales.OrdersArchive

SELECT * FROM (
	SELECT 
		OrderID, 
		COUNT(*) AS [Count]
	FROM Sales.OrdersArchive GROUP BY OrderID
)t WHERE Count >1

-- or
SELECT * FROM (
	SELECT 
		OrderID, 
		COUNT(*) OVER(PARTITION BY OrderId) AS [Count]
	FROM Sales.OrdersArchive
)t WHERE Count > 1