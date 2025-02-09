use vintage_vinyl;

-- Find the customer who has spent the most on orders overall and their total spending:

SELECT CONCAT(first_name, ' ', last_name) AS customer_name, SUM(total_amount) AS total_spending
FROM customers c
JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY customer_name
ORDER BY total_spending DESC
LIMIT 1;

-- List albums that have been sold at least twice by distinct customers:

SELECT Al.album_title, COUNT(DISTINCT O.customer_id) AS distinct_customers
FROM Albums Al
JOIN Order_Details OD ON Al.album_id = OD.album_id
JOIN Orders O ON OD.order_id = O.order_id
GROUP BY Al.album_id
HAVING distinct_customers >= 2; 

-- Get the average album price for each genre, but only include genres with an average price over $15:
SELECT g.genre_name, ROUND(AVG(a.price),2) AS Avg_Price
FROM genres g
JOIN albums a 
ON g.genre_id = a.genre_id
GROUP BY g.genre_name
HAVING AVG(a.price) > 15;

-- Find the top 3 customers who have placed the most orders and list the total count of their orders:
SELECT CONCAT( first_name, ' ', last_name) AS Customer, COUNT(order_id) AS num_orders
FROM customers c 
JOIN orders o 
ON c.customer_id = o.order_id
GROUP BY customer
ORDER BY num_orders DESC
LIMIT 3;

-- Retrieve the record label with the highest average album price among albums in 'Excellent' condition:
    
    SELECT RL.label_name, AVG(A.price) AS avg_price
FROM Record_Labels RL
JOIN Albums A ON RL.label_id = A.label_id
WHERE conditions = 'Excellent'
GROUP BY RL.label_name
ORDER BY avg_price DESC
LIMIT 1;

-- Identify the artist with the highest revenue generated from album sales, based on order details:

SELECT a.artist_name, SUM(od.price_at_time * od.quantity) AS revenue_generated
FROM artists a 
JOIN albums al 
ON a.artist_id = al.artist_id
JOIN order_details od
ON 
al.album_id = od.album_id
GROUP BY artist_name
ORDER BY revenue_generated DESC
LIMIT 1;

-- List suppliers who have provided at least 5 different albums:
SELECT supplier_name, COUNT(DISTINCT album_id) AS num_albums
FROM suppliers s 
JOIN inventory i 
ON
s.supplier_id = i.supplier_id
GROUP BY supplier_name
HAVING num_albums >= 5; 

-- Find the album with the largest gap between its stock quantity and the total quantity ordered:

SELECT Al.album_title, Al.stock_quantity - COALESCE(SUM(OD.quantity), 0) AS quantity_gap
FROM Albums Al
LEFT JOIN Order_Details OD ON Al.album_id = OD.album_id
GROUP BY Al.album_id
ORDER BY quantity_gap DESC
LIMIT 1; 
/*the coalesce will take care of any null values in the quantity section 
            and replace them with 0 so the math will work correctly*/
            

-- List all artists with albums priced above the average price of all albums in the database:

SELECT DISTINCT artist_name, price
FROM artists a 
JOIN albums al 
ON 
a.artist_id = al.artist_id
WHERE price >
	(SELECT AVG(price) FROM albums);
    
    
-- Find the record label with the most genres represented in its album catalog

SELECT rl.label_name, COUNT(DISTINCT a.genre_id) AS num_genres
FROM record_labels rl 
JOIN albums a 
ON
rl.label_id = a.label_id
GROUP BY rl.label_name
ORDER BY num_genres DESC
LIMIT 1;

-- Get the customer who placed the earliest order, including their order date and total amount

SELECT first_name, last_name, total_amount, MIN(order_date) AS earliest_order
FROM customers c 
JOIN orders o 
ON
c.customer_id = o.customer_id
GROUP BY first_name, last_name, total_amount
ORDER BY earliest_order DESC
LIMIT 1;

-- List the top 3 albums with the most inventory supplied, along with the total quantity supplied for each:

SELECT Al.album_title, SUM(I.quantity) AS total_supplied
FROM Albums Al
JOIN Inventory I ON Al.album_id = I.album_id
GROUP BY Al.album_id
ORDER BY total_supplied DESC
LIMIT 3;

-- OR AS A SUBQUERY

SELECT a.album_title,
		(SELECT SUM(I.quantity) FROM inventory i  WHERE i.album_id = a.album_id) AS total_supplied
FROM albums a 
ORDER BY total_supplied DESC
LIMIT 3;

-- Find the most recent album purchased by each customer:
SELECT od.order_id, c.first_name, c.last_name, al.album_title,  MAX(o.order_date) AS most_recent_purchase
FROM albums al
JOIN order_details od 
ON 
al.album_id = od.album_id
JOIN orders o 
ON od.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY od.order_id, c.first_name, c.last_name, al.album_title
ORDER BY most_recent_purchase DESC;

-- Identify the artist with the most albums under a specific genre, like 'Rock':

SELECT a.artist_name, COUNT(g.genre_id) AS num_rock_albums
FROM artists a 
JOIN albums al 
ON a.artist_id = al.artist_id
JOIN genres g 
ON al.genre_id = g.genre_id
WHERE genre_name = 'rock'
GROUP BY a.artist_name
ORDER BY num_rock_albums DESC
LIMIT 1;

-- Get all albums that have never been ordered, including their title, price, and stock quantity:

SELECT Al.album_title, Al.price, Al.stock_quantity
FROM Albums Al
LEFT JOIN Order_Details OD ON Al.album_id = OD.album_id
WHERE OD.album_id IS NULL;

-- List all suppliers who have supplied albums with an average price above $25:

SELECT supplier_name, ROUND(AVG(price),2) AS avg_price
FROM suppliers s 
JOIN inventory i 
ON 
s.supplier_id = i.supplier_id
JOIN albums a 
ON 
i.album_id = a.album_id
GROUP BY supplier_name
HAVING avg_price > 25;

-- Find all genres for which no albums have been supplied in the last year

SELECT G.genre_name
FROM Genres G
LEFT JOIN Albums Al ON G.genre_id = Al.genre_id
LEFT JOIN Inventory I ON Al.album_id = I.album_id AND I.purchase_date > CURDATE() - INTERVAL 1 YEAR
WHERE I.inventory_id IS NULL;

-- Get the record label with the oldest album stock based on release year

SELECT label_name, stock_quantity, MIN(release_year) AS release_year
FROM record_labels rl 
JOIN albums a 
ON rl.label_id = a.label_id
GROUP BY label_name, stock_quantity
ORDER BY release_year ASC
LIMIT 1;

-- List customers who have ordered albums from at least 3 distinct genres:

SELECT C.customer_id, C.first_name, C.last_name, COUNT(DISTINCT G.genre_id) AS genre_count
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Albums Al ON OD.album_id = Al.album_id
JOIN Genres G ON Al.genre_id = G.genre_id
GROUP BY C.customer_id
HAVING genre_count >= 3;  -- no customers bought more than one genre 






















    
 








