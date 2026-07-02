DROP DATABASE datadigger;
-- Project 1

CREATE DATABASE datadigger;
use datadigger;


-- 1  customer table

CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(200)
);



-- 2 Order table

CREATE TABLE orders (
	OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID)
);
    
    
    
-- 3 product table 

CREATE TABLE Products (
	ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT 
);


--  4 Orderdetails table

CREATE TABLE OrderDetails (
	OrderDetailsID INT PRIMARY KEY AUTO_INCREMENT,
    OrderId INT,
    ProductID INT,
    Quantity INT,
    Subtotal DECIMAL(10,2),
    
    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),
    
    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);



-- STEP 3: INSERT SAMPLE DATA


INSERT INTO Customers (Name, Email, Address)
VALUES  ('Alice', 'alice@gmail.com', 'Delhi'),
('Bob', 'bob@gmail.com', 'Mumbai'),
('Charlie', 'charlie@gmail.com', 'Jaipur'),
('David', 'david@gmail.com', 'Udaipur'),
('Emma', 'emma@gmail.com', 'Pune');

-- Orders Data


INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, '2026-05-01', 2500.00),
(2, '2026-05-05', 1500.00),
(3, '2026-05-10', 3000.00),
(1, '2026-05-15', 4500.00),
(4, '2026-05-20', 1200.00);


-- Product data

INSERT INTO Products (ProductName, Price, stock)
values ('Laptop', 55000, 10),
('Mobile', 20000, 15),
('Keyboard', 1000, 30),
('Mouse', 500, 50),
('Headphones', 2500, 20);


--  orderdetails data
INSERT INTO Orderdetails (OrderID , ProductID, Quantity, Subtotal)
values
(1, 1, 1, 55000),
(2, 2, 1, 20000),
(3, 5, 2, 5000),
(4, 3, 3, 3000),
(5, 4, 2, 1000);


-- STEP 4: CUSTOMERS TABLE QUERIES

--  retrieves all customer details
select * from Customers;


-- Update customer address
UPDATE Customers
SET Address = "banglore"
WHERE CustomerID = 5;


--  delete customer using customerid
DELETE FROM Customers
WHERE CustomerID = 4;
    
-- Display customers whose name is alice
select * from Customers
WHERE Name ="ALice" ;

-- order table queries

--  retrieve all orders made by a specific customer
select * from Orders  
WHERE CustomerID = 1;

-- update an order total amount

UPDATE Orders
set TotalAmount = 5000
WHERE OrderID = 2;

--  delete customer using OrderID
DELETE FROM Orders
WHERE OrderID = 4;



--  retrieve orders placed in the last 30 days 
SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;


-- Retrieve highest, lowest, and average order amount
SELECT
MAX(TotalAmount) AS HighestOrder,
MIN(TotalAmount) AS LowestOrder,
AVG(TotalAmount) AS AverageOrder
FROM Orders;


-- product table queries


-- Retrieve all products sorted by price descending
SELECT * FROM Products
ORDER BY Price DESC ;

--  update the price of a specific product

UPDATE products
SET	 price = 22000
WHERE ProductID = 2;

--  delete a product if it is out of stock

DELETE FROM Products
WHERE stock = 1;

 -- retrieve products whose price is between 500 to 2000
 
 SELECT * FROM Products 
 WHERE Price BETWEEN 500 AND 2000;
 
 -- RETRIVE THE MOST EXEPENSIVE AND CHEAPEST PRODUCT
 
 SELECT 
 MAX(Price) AS MostExpensive,
 min(Price) AS Cheapest
 from products;
 
--  order details table queries

-- retrieve all order details for specific orders
select * from OrderDetails
WHERE OrderID = 1;

-- calculate total revenue  generated from all orders
SELECT SUM(Subtotal) AS TotalRevenue
from Orderdetails;


-- retrieve top 3 most ordered products

select ProductID,
sum(Quantity) AS TotalOrdered
FROM Orderdetails
GROUP BY ProductID
ORDER BY TotalOrdered desc
limit 3;


-- count how many times each product has beeen sold
select ProductID,
count(*) as TimesSold
from Orderdetails
group by ProductID;

 -- join queries 
 --  customer order details
 
 SELECT
 Customers.Name,
 Orders.OrderID,
 Orders.TotalAmount
 from Customers
 INNER JOIN Orders
 ON Customers.CustomerID = Orders.CustomerID;
 
 
 --  product order details
 SELECT
 Products.ProductName,
 Orderdetails.Quantity
 FROM Products
 INNER JOIN OrderDetails
 ON Products.ProductID = OrderDetails.ProductID;


-- complete order report

select
Customers.Name,
Orders.OrderID,
Products.ProductName,
OrderDetails.Quantity,
Orderdetails.SubTotal
FROM Customers
JOIN Orders 
on Customers.CustomerID = Orders.CustomerID
JOIN Orderdetails
ON Orders.OrderID = OrderDetails.OrderID
JOIN Products
ON Products.ProductID = OrderDetails.ProductID;


-- display all table
DROP TABLE OrderDetails;

DROP TABLE Orders;

DROP TABLE Products;

DROP TABLE Customers;



drop table Orders;

drop table Products;

drop table OrderDetails;
drop table Customers;