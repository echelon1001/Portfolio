CREATE DATABASE Kylee_Cookies;
USE Kylee_Cookies;

CREATE TABLE Cookies (
	Cookie_Name VARCHAR(100) NOT NULL,
	Cost_per_cookie DECIMAL (5,2),
	price_per_cookie DECIMAL (5,2),
	CustomerID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Orders_ID INT NOT NULL UNIQUE);

INSERT INTO cookies (Cookie_Name, Cost_per_cookie, price_per_cookie, Orders_ID)
VALUES ('Mickey Macaroon', .16, .30, 474264),
       ('Chocolate Wave', .27, .40, 478235),
       ('Peanut Butter Crisp', .18, .35, 641929),
       ('Nutter Butter', .22, .35, 684340),
       ('Tag-a-Longs', .32, .55, 278043),
       ('Butter Cream', .21, .65, 786770),
       ('Vanilla Swirl', .25, .55, 589574),
       ('Chocolate Flood', .38, .70, 487021),
       ('Strawberry Shortcake', .27, .45, 397607),
       ('Banana Cream', .12, .35, 219369),
       ('Boston Cream', .29, .55, 602410),
       ('Peanut Blast', .30, .65, 422605);
       
CREATE TABLE orders (
    OrderID INT NOT NULL PRIMARY KEY,
    cookies_ordered INT,
    order_date DATE,
    Customer_ID INT,  
    FOREIGN KEY (Customer_ID) REFERENCES cookies(CustomerID)
);


INSERT INTO Orders(OrderID, cookies_ordered, Order_date, Customer_ID)
VALUES(266268, 23, '2023-10-23', 4),
      (140794, 45, '2023-4-13', 8),
      (684759, 53, '2023-4-13', 6),
      (640447, 22,'2022-3-18',2),
      (986373, 11, '2024-4-11',5),
      (895713, 22, '2024-4-11', 9),
      (333352, 7,'2024-4-11',1),
      (333453, 10, '2024-9-23', 3),
      (703997, 7,'2023-5-18', 7),
      (308620, 5, '2024-5-18', 10),
      (986371 ,12, '2024-3-12',2),
      (222234, 22, '2024-4-11', 9),
      (457231 ,7,'2024-4-11',1),
      (333455 ,10, '2024-9-23', 3),
      (703992 ,7,'2023-5-18', 7),
      (308629, 5, '2024-5-18', 10); 

INSERT INTO orders values (266404, 11, '2023-10-23', 4);

CREATE TABLE customers (
    Customer_Name VARCHAR(100),
    ADDRESS VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(2),
    Zip INT,
    Country VARCHAR(50),
    Order_ID INT,  
    Customer_ID INT,
    FOREIGN KEY (Order_ID) REFERENCES orders(OrderID),
    FOREIGN KEY (Customer_ID) REFERENCES cookies(CustomerID)
    
);


 INSERT INTO customers( Customer_Name, Address, City, State, Zip, Country, Order_ID, Customer_ID)                  
VALUES  ('Cindy Lou', '1017 Nutcracker Rd.', 'Whoville', 'ME', 37256, 'United States',  266268, 4),
      	('Roy Taylor', '465 Thomas Lane', 'Rochester', 'NY', 25467,'United States', 140794, 8),
        ('Billy Sweeney', '987 Pottersville', 'Bristol', 'TN', 23676,'United States', 684759, 6),
        ('Kylee Brooks', '404 Eisenhower Dr', 'Ashland City', 'TN',76548, 'United States', 640447, 2),
        ('Thomas Too', '34 West Howser St', 'Lickety Split', 'ON', 12345,'Canada', 986373, 5),
        ('Susan March', '1818 Queens Blvd', 'London', 'EN', 23478,'England', 895713, 9),
        ('Melanie Brooks', '4567 Outback Way', 'Sydney', 'AU',46764, 'Australia', 333352, 1),
        ('Barney Fife', '1111 Mendlebright St', 'Mayberry', 'NC', 35642, 'United States', 333453,3),
        ('Roscoe Coltrane', '7435 Mothers House', 'Hazzard County', 'GA', 97457, 'United States', 703997,7),
        ('Herman Munster', '1313 Mockingbird Lane', 'Creepy City', 'NY', 64890, 'United States', 308620, 10),
	      ('Harry Stone', '124 South St', 'New York', 'NY',64890, 'United States', 986371, 2),
	      ('Christine Sullivan', '128 South St', 'New York', 'NY' ,64890, 'United States', 222234, 9),
        ('Charlie Brown', '124 South St', 'Boston', 'MA', 68890, 'United States' ,457231, 1),
        ('Dan Fielding', '125 South St', 'New York', 'NY', 64890, 'United States', 333455, 3),
        ('Bull Shannon', '454 Main St', 'New York', 'NY', 64890, 'United States', 703992, 7),
        ('Mac Robinson', '999 South St' ,'New York', 'NY' ,64890, 'United States', 308629, 10),
        ('Herman Munster', '1313 Mockingbird Lane', 'Creepy City', 'NY', 64890, 'United States', 308630, 10);



SELECT cookie_name, orders_id, cost_per_cookie, cookies_ordered, customerid FROM cookies
JOIN orders ON cookies.customerid = orders.customer_id;


ALTER TABLE customers
RENAME COLUMN customer_id TO customerid;
                 
    SELECT orderid, customer_name, city FROM customers
JOIN orders ON orders.orderid = customers.order_id
   WHERE city = 'creepy city';

         
      

    SELECT * FROM orders;
    
SELECT cookie_name, cookies_ordered, customerid, customer_name, state FROM cookies
    JOIN orders ON cookies.customerid = orders.customer_id
    JOIN customers ON cookies.customerid = customers.customer_id
GROUP BY cookie_name, cost_per_cookie, cookies_ordered, customerid, customer_name, state;

       
SELECT * FROM cookies
    JOIN orders ON cookies.customerid = orders.customer_id
    JOIN customers ON cookies.customerid = customers.customer_id;

SELECT * FROM orders;




SELECT 
    cookie_name,
    cost_per_cookie,
    price_per_cookie,
    SUM(cookies_ordered),
    cost_per_cookie * SUM(cookies_ordered) AS total_sales,
    customerid,
    customer_name,
    state,
    country
FROM
    cookies
        JOIN orders 
ON cookies.customerid = orders.customer_id
        JOIN
    customers
ON cookies.customerid = customers.customer_id
GROUP BY cookie_name , cost_per_cookie , customerid , customer_name , state , country;

create view cookie_view AS
SELECT 
    cookie_name,
    cost_per_cookie,
    price_per_cookie,
    SUM(cookies_ordered),
    cost_per_cookie * SUM(cookies_ordered) AS total_sales,
    customerid,
    customer_name,
    state,
    country
FROM
    cookies
        JOIN
    orders ON cookies.customerid = orders.customer_id
        JOIN
    customers ON cookies.customerid = customers.customer_id
GROUP BY cookie_name , cost_per_cookie , customerid , customer_name , state , country;

SELECT * from cookie_view;

SELECT * FROM customers WHERE customer_name != 'Brooks';

SELECT MAX(price_per_cookie) AS Max_Price, cookie_name, customer_name
FROM cookies
JOIN customers ON cookies.customerid = customers.customer_id
GROUP BY cookie_name, customer_name;




SELECT cookie_name, price_per_cookie, cookies_ordered, customer_name FROM cookies
JOIN orders ON cookies.customerid = orders.customer_id
JOIN customers ON cookies.customerid = customers.customer_id;

SELECT cookie_name, customerid, cookies_ordered, customer_name FROM cookies
JOIN orders ON cookies.customerid = orders.customer_id
JOIN customers ON cookies.customerid = customers.customer_id;



SELECT 
    cookie_name,
    cookies_ordered,
    cost_per_cookie,
    price_per_cookie,
    (price_per_cookie - cost_per_cookie) AS Profit,
    customer_name,
    city,
    state,
    country,
    cost_per_cookie * SUM(cookies_ordered) AS total_sales,
    CASE
        WHEN (cost_per_cookie * SUM(cookies_ordered)) > 5.00 THEN 'Yes'
        ELSE 'No'
    END AS Free_cookie
FROM
    cookies
        JOIN
    customers ON cookies.customerid = customers.customer_id
        JOIN
    orders ON cookies.customerid = orders.customer_id
GROUP BY cookie_name , cookies_ordered, cost_per_cookie , price_per_cookie , customer_name, city, state, country;

SELECT 
    cookie_name,
    (cost_per_cookie * cookies_ordered) AS Total_Cookies_Bought,
    customer_name,
    orderdate,
    CASE
        WHEN (cost_per_cookie * cookies_ordered) > 5 THEN 'YES'
        ELSE 'NO'
    END AS Gold_Customer
FROM
    cookies
        JOIN
    orders ON cookies.customerid = orders.customer_id
        JOIN
    customers ON cookies.customerid = customers.customer_id
GROUP BY cookie_name , cost_per_cookie , cookies_ordered , customer_name , orderdate;


 SELECT cost_per_cookie, price_per_cookie, customerid 
    FROM cookies
    UNION
 SELECT cookies_ordered, order_date, customer_id FROM orders;
 
 
 SELECT customer_name FROM customers WHERE customer_name LIKE '%man%';
 
 SELECT customer_name FROM customers WHERE customer_name != 'Kylee Brooks';
 

 SELECT cookie_name, customer_name, customerid, orderid, orderdate,
 (price_per_cookie*cookies_ordered) AS Total_Sales,
     CASE
     WHEN (price_per_cookie*cookies_ordered) > 8 THEN 'Yes'
    ELSE 'No'
 END AS 'Free_Cookie?'
 FROM cookies
      JOIN orders 
   ON cookies.customerid = orders.customer_id
     JOIN customers 
   ON cookies.customerid = customers.customer_id
 GROUP BY customer_name, cookie_name, customerid, orderid, orderdate
 ORDER BY cookie_name;
 
 
     SELECT price_per_cookie, sum(cookies_ordered) AS Total_ordered, customerid, customer_name, state
     FROM cookies
        JOIN orders
       ON cookies.customerid = orders.customer_id
        JOIN customers 
       ON cookies.customerid = customers.customer_id
     GROUP BY price_per_cookie, customerid, customer_name, state;
     
  -- Queries 

-- Retrieve all orders with their corresponding customer names and states.
SELECT orderid, customer_name, state FROM orders
JOIN customers ON customers.order_id = orders.orderid;

-- Calculate the total revenue generated from each cookie order.
SELECT cookie_name, orderid, (price_per_cookie * cookies_ordered) AS Total_Revenue FROM cookies
JOIN orders ON cookies.customerid = orders.customer_id
GROUP BY orderid;

-- List the top 5 customers who have ordered the most cookies.

SELECT customer_name, cookies_ordered
FROM customers
JOIN orders ON customers.order_id = orders.orderid
GROUP BY  customer_name, cookies_ordered
ORDER BY cookies_ordered DESC
LIMIT 5;


-- Find the average cost per cookie across all orders.


SELECT AVG(price_per_cookie) AS avg_price_per_cookie
FROM cookies; 

UPDATE customers
SET customer_name = 'Cindy Lou Who'
WHERE customer_name = 'cindy Lou';

-- Identify customers who have ordered cookies but have not provided their state information.
SELECT * FROM customers WHERE state IS NULL;

-- Find the total number of orders placed for each type of cookie.

SELECT cookie_name, customer_name, state ,cookies_ordered AS total_orders FROM cookies
 JOIN customers ON cookies.customerid = customers.customer_id
JOIN orders ON cookies.customerid = orders.customer_id;

SELECT Cookie_name,  COUNT(cookies_ordered) AS TotalOrders
FROM cookies JOIN orders ON cookies.customerid = orders.customer_id
-- JOIN customers ON cookies.customerid = customers.customer_id
GROUP BY Cookie_name;

SELECT * FROM ORDERS;

-- Determine the average price per cookie across all orders for customers in each state.

SELECT AVG(price_per_cookie) AS average_price_per_cookie, state FROM cookies JOIN customers ON cookies.customerid = customers.customer_id
GROUP BY state;

-- Identify the customer(s) who spent the most on cookie orders.

SELECT customer_name, SUM(cookies_ordered) AS TotalSpending
FROM customers
JOIN orders ON orders.orderid = customers.order_id 
GROUP BY customer_name
ORDER BY TotalSpending DESC
LIMIT 1;

-- Calculate the total revenue generated from orders placed in each month of the year.

SELECT SUM(cookies_ordered), order_date FROM orders
GROUP BY order_date; -- this will give you month day and year

SELECT 
    monthname(Order_Date) AS Month,
   cookie_name, order_date,
   SUM(cookies_ordered) AS TotalRevenue
FROM 
    Orders
    JOIN cookies ON cookies.customerid = orders.customer_id
GROUP BY cookie_name, order_date,
  monthname(Order_Date)
  ORDER BY ORDER_DATE DESC;

SELECT MONTHNAME("2023-04-13");

SELECT * FROM COOKIES LIMIT 5;

ALTER TABLE customers RENAME customer;

ALTER TABLE orders RENAME COLUMN  order_date TO OrderDate;

-- Select all cookies ordered by a specific customer: 

SELECT Cookie_Name, cookies_ordered, customer_name
FROM Cookies
JOIN orders ON cookies.CustomerID = orders.Customer_ID
JOIN customer ON customer.order_id = orders.orderid
WHERE customer_name LIKE 'Kylee%';


-- Calculate total cost of cookies ordered by a specific customer:

SELECT SUM(cost_per_cookie*cookies_ordered) AS 'Total Cost', customer_name FROM cookies
JOIN orders ON cookies.customerid = orders.customer_id
JOIN customers ON customers.order_id = orders.orderid
GROUP BY customer_name;

-- List all orders made by customers from a specific city: 

SELECT orderid, customer_name, city FROM orders
JOIN customer ON customer.order_id = orders.orderid
WHERE city = 'Creepy City';


INSERT INTO orders
VALUES (308630, 13, '2024-7-18', 10);

INSERT INTO customer VALUES  ('Herman Munster', '1313 Mockingbird Lane', 'Creepy City', 'NY', 64890, 'United States', 308630, 10);


INSERT INTO orders
VALUES (308630, 13, '2024-7-18', 10);

INSERT INTO customer VALUES  ('Herman Munster', '1313 Mockingbird Lane', 'Creepy City', 'NY', 64890, 'United States', 308630, 10);


INSERT INTO Orders(OrderID, cookies_ordered, Orderdate, Customer_ID)
VALUES(54678, 23, '2023-10-23', 4),
      (45634, 45, '2023-4-13', 8),
      (87329, 53, '2023-4-13', 6),
      (78695, 22,'2022-3-18',2),
      (31763, 11, '2024-4-11',5);








INSERT INTO customer ( Customer_Name, Address, City, State, Zip, Country, Order_ID, Customer_ID)                  
VALUES ('Cindy Lou', '1017 Nutcracker Rd.', 'Whoville', 'ME', 37256, 'United States',  54678, 4),
	('Roy Taylor', '465 Thomas Lane', 'Rochester', 'NY', 25467,'United States', 45634, 8),
    ('Billy Sweeney', '987 Pottersville', 'Bristol', 'TN', 23676,'United States', 87329, 6),
    ('Kylee Brooks', '404 Eisenhower Dr', 'Ashland City', 'TN',76548, 'United States', 78695, 2),
    ('Thomas Too', '34 West Howser St', 'Lickety Split', 'ON', 12345,'Canada', 31763, 5);



SELECT * FROM customer where customer_name = 'Cindy Lou';

/* i changed the named of the customers table to customer, but mysql will only retrieve orders from the customer table.
if i also want orders from the old table name as well as the new one, I have to UNION the two together. */

SELECT customer_name, order_id
FROM customers
WHERE customer_name = 'herman munster'
UNION
SELECT customer_name, order_id
FROM customer
WHERE customer_name = 'herman munster';

  SELECT Cookie_Name, price_per_cookie, Round(Avg(Cost_per_cookie),2) AS avg_cookie_cost
  FROM cookies
  GROUP BY Cookie_Name, price_per_cookie;
     
CREATE VIEW view_example AS
    SELECT 
    cookie_name,
    cost_per_cookie,
    price_per_cookie,
    SUM(cookies_ordered),
    cost_per_cookie * SUM(cookies_ordered) AS total_sales,
    c.customerid,
    customer_name,
    state,
    country
FROM
    cookies c
        JOIN
    orders ON c.customerid = orders.customer_id
        JOIN
    customers ON c.customerid = customers.customer_id
GROUP BY cookie_name , cost_per_cookie , c.customerid , customer_name , state , country;

select * from view_example;


SELECT CUSTOMERID, PRICE_per_cookie, cost_per_cookie, avg(cost_per_cookie)
 over(partition by customerid) as avg_cost_per_cookie from cookies;

-- IF statement:
 
 Select customerid, price_per_cookie, customer_name, state,
 IF(price_per_cookie < .65, "Let's get one", 'Nah, Too expensive') AS 'Get one?'
FROM cookies 
JOIN customers
USING (customerid);


-- Case:
Select customerid, price_per_cookie, customer_name, state,
CASE
 WHEN
 price_per_cookie  = .50 THEN "I will think about it"
 WHEN price_per_cookie < .40 THEN "What a deal"
  ELSE 'Nah, Too expensive'
 END
 AS 'Get one?'
FROM cookies 
JOIN customers
USING (customerid);






DROP VIEW IF EXISTS cookie_view;
-- i dropped all the views because i had renamed the customers table to customer. i will need to recreate
-- the views with the customer table name.

drop table if exists customers;
select * from customer; -- new table name

show tables;
describe cookies;
describe orders;
describe customer;
ALTER TABLE cookies
RENAME COLUMN CustomerID TO Customer_ID;

   SELECT cookie_name, cookies_ordered, c.customer_id, customer_name, state FROM cookies c 
JOIN orders o ON c.customer_id = o.customer_id
JOIN customer cu ON c.customer_id = cu.customer_id
GROUP BY cookie_name, cost_per_cookie, cookies_ordered, c.customer_id, customer_name, state;

select * from customer;










