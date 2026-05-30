
USE SalesdB

-- Find the highest & lowest sales across all orders
-- and the highest & lowest sales for each product
-- Additionally, provide details such as order ID and order date

SELECT * FROM Sales.Orders

SELECT MAX(Sales) FROM Sales.Orders
SELECT MIN(Sales) FROM Sales.Orders

SELECT ProductID, MAX(Sales) FROM Sales.Orders GROUP BY ProductID
SELECT ProductID, MIN(Sales) FROM Sales.Orders GROUP BY ProductID

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	MAX(Sales) OVER() AS [MaxSale],
	MIN(Sales) OVER() AS [MinSale],
	MAX(Sales) OVER(PARTITION BY ProductID) AS [MaxSalePerProduct],
	MIN(Sales) OVER(PARTITION BY ProductID) AS [MinSalePerProduct]
FROM Sales.Orders
 
-- Show the employees with the highest salaries

SELECT * FROM Sales.Employees

-- without window
SELECT * FROM Sales.Employees WHERE Salary = (
	SELECT MAX(Salary) FROM Sales.Employees
)

-- with window
SELECT * FROM (
	SELECT *,
		MAX(Salary) OVER() AS [MaxSalry]
	FROM Sales.Employees
)t WHERE Salary = MaxSalry

-- Calculate the deviation of each sales from both
-- the minimum and maximum sales amounts

SELECT * FROM Sales.Orders

SELECT 
	OrderID,
	MAX(Sales) OVER() AS [MaxSale],
	Sales,
	(MAX(Sales) OVER() - Sales) AS [DevFromMaxSale],
	Sales,
	MIN(Sales) OVER() AS [MinSale],
	(Sales - MIN(Sales) OVER()) AS [DevFromMinSale]
FROM Sales.Orders


-- Calculate the moving average of sales
-- for each product over time

SELECT * FROM Sales.Orders

SELECT 
	ProductID,
	Sales,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) AS [MovingAvg]
FROM Sales.Orders 

-- Calculate the moving average of sales for each
-- product over time, including only the next order

SELECT * FROM Sales.Orders

SELECT 
	ProductID,
	Sales,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS [MovingAvgNxtOrder]
FROM Sales.Orders 

