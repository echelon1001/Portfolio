DROP DATABASE IF EXISTS Vintage_Vinyl;
CREATE DATABASE Vintage_Vinyl;
USE vintage_vinyl;

-- ARTISTS TABLE

CREATE TABLE Artists (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    artist_name VARCHAR(255),
    country VARCHAR(100)
);

INSERT INTO Artists ( artist_name, country) VALUES
('Pink Floyd', 'UK'),
('AC/DC', 'Australia'),
('The Beatles', 'UK'),
('Nirvana', 'USA'),
('Michael Jackson', 'USA'),
('Fleetwood Mac', 'UK'),
('Led Zeppelin', 'UK'),
('Guns N\' Roses', 'USA'),
('Eagles', 'USA'),
('U2', 'Ireland'),
('Bruce Springsteen', 'USA'),
('Prince', 'USA'),
('Radiohead', 'UK'),
('The Rolling Stones', 'UK'),
('Adele', 'UK'),
('Metallica', 'USA'),
('David Bowie', 'UK'),
('Queen', 'UK'),
('Taylor Swift', 'USA');

-- GENRES TABLE
CREATE TABLE genres 
	(genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(200)
    );
    

INSERT INTO Genres (genre_name) VALUES
('Rock'),
('Metal'),
('Pop'),
('Hip Hop'),
('Jazz'),
('Classical'),
('Country'),
('Reggae'),
('Blues'),
('Electronic');

-- LABELS TABLE

CREATE TABLE record_labels (
	label_id INT PRIMARY KEY AUTO_INCREMENT,
    label_name VARCHAR(255),
    founded_year INT,
    location VARCHAR(200)
    );
    
    INSERT INTO Record_Labels (label_name, founded_year, location) VALUES
('Columbia Records', 1887, 'New York, USA'),
('Capitol Records', 1942, 'Los Angeles, USA'),
('Island Records', 1959, 'London, UK'),
('Atlantic Records', 1947, 'New York, USA'),
('Def Jam Recordings', 1984, 'New York, USA'),
('Virgin Records', 1972, 'London, UK'),
('Sony Music', 1929, 'Tokyo, Japan'),
('Warner Bros. Records', 1958, 'Los Angeles, USA'),
('Motown', 1959, 'Detroit, USA'),
('Interscope Records', 1990, 'Santa Monica, USA');

-- ALBUMS TABLE
CREATE TABLE Albums
	(album_id INT PRIMARY KEY AUTO_INCREMENT,
	album_title VARCHAR(50),                        
    artist_id INT NOT NULL,     
    release_year INT,           
    genre_id INT,
    label_id INT,
    conditions VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity int,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
    FOREIGN KEY (label_id) REFERENCES record_labels(label_id)
    );

INSERT INTO Albums (album_title, artist_id, release_year, genre_id, label_id, conditions, price, stock_quantity) VALUES
('The Wall', 1, 1979, 1, 2, 'Mint', 29.99, 150),
('Back in Black', 2, 1980, 2, 1, 'Near Mint', 25.00, 100),
('Abbey Road', 3, 1969, 1, 3, 'Good', 20.50, 75),
('Nevermind', 4, 1991, 1, 2, 'Excellent', 22.75, 120),
('Thriller', 5, 1982, 3, 7, 'Mint', 35.00, 200),
('Rumours', 6, 1977, 1, 7, 'Very Good', 18.50, 90),
('The Dark Side of the Moon', 1, 1973, 1, 6, 'Excellent', 30.00, 130),
('Led Zeppelin IV', 7, 1971, 1, 8, 'Mint', 28.50, 100),
('Appetite for Destruction', 8, 1987, 2, 10, 'Very Good', 24.99, 60),
('Hotel California', 9, 1976, 1, 4, 'Near Mint', 27.99, 80),
('The Joshua Tree', 10, 1987, 1, 6, 'Excellent', 23.50, 110),
('Born to Run', 11, 1975, 1, 5, 'Mint', 26.50, 85),
('Purple Rain', 12, 1984, 3, 8, 'Very Good', 21.75, 70),
('OK Computer', 13, 1997, 1, 3, 'Good', 19.50, 90),
('Sticky Fingers', 14, 1971, 1, 9, 'Mint', 32.00, 65),
('21', 15, 2011, 3, 6, 'Near Mint', 30.50, 140),
('Master of Puppets', 16, 1986, 2, 2, 'Excellent', 22.50, 95),
('The Rise and Fall of Ziggy Stardust', 17, 1972, 1, 1, 'Mint', 33.50, 75),
('A Night at the Opera', 18, 1975, 1, 4, 'Very Good', 25.00, 60),
('1989', 19, 2014, 3, 3, 'Excellent', 29.99, 100);


SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE artists;
SET FOREIGN_KEY_CHECKS = 1;
-- CUSTOMERS TABLE    
CREATE TABLE customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    email VARCHAR(255),
    phone_number VARCHAR(15),
    address VARCHAR(200),
    city VARCHAR(150)
    );
   
    
    
    INSERT INTO Customers (first_name, last_name, email, phone_number, address, city) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '123 Maple St', 'New York'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '456 Oak St', 'Los Angeles'),
('Michael', 'Johnson', 'michael.johnson@example.com', '555-9012', '789 Pine St', 'Chicago'),
('Emily', 'Davis', 'emily.davis@example.com', '555-3456', '321 Birch St', 'Houston'),
('Chris', 'Brown', 'chris.brown@example.com', '555-7890', '654 Cedar St', 'Phoenix'),
('Sarah', 'Wilson', 'sarah.wilson@example.com', '555-2345', '987 Walnut St', 'Philadelphia'),
('David', 'Miller', 'david.miller@example.com', '555-6789', '147 Spruce St', 'San Antonio'),
('Laura', 'Taylor', 'laura.taylor@example.com', '555-4321', '258 Fir St', 'San Diego'),
('James', 'Anderson', 'james.anderson@example.com', '555-8765', '369 Chestnut St', 'Dallas'),
('Lisa', 'Martinez', 'lisa.martinez@example.com', '555-0987', '159 Poplar St', 'San Jose');

-- ORDERS TABLE    
CREATE TABLE orders
	(order_id INT PRIMARY KEY AUTO_INCREMENT,
	customer_id INT,
    order_date DATE,
    shipping_address VARCHAR(255),
    total_amount DECIMAL(10,2),
	status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled'),
    payment_method VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    );
    
    INSERT INTO Orders (customer_id, order_date, shipping_address, total_amount, status, payment_method) VALUES
(8, '2023-10-01', '123 Maple St, New York', 59.99, 'Shipped', 'credit card'),
(2, '2023-10-03', '456 Oak St, Los Angeles', 89.99, 'Pending', 'cash'),
(5, '2023-10-05', '789 Pine St, Chicago', 120.50, 'Shipped', 'credit card'),
(4, '2023-10-07', '321 Birch St, Houston', 75.00, 'Delivered', 'credit card'),
(6, '2023-10-09', '654 Cedar St, Phoenix', 49.99, 'Cancelled', 'credit card'),
(9, '2023-10-10', '987 Walnut St, Philadelphia', 110.99, 'Pending', null),
(7, '2023-10-12', '147 Spruce St, San Antonio', 60.25, 'Shipped','cash'),
(1, '2023-10-13', '258 Fir St, San Diego', 135.75, 'Delivered', 'gift card'),
(3, '2023-10-14', '369 Chestnut St, Dallas', 89.50, 'Pending', null),
(10, '2023-10-15', '159 Poplar St, San Jose', 200.00, 'Shipped', 'gift card');  -- in a real table, when entering customer_id,
-- you would use a query to look up the customer name and retrieve their customer_id to put into the orders table.
/*If you are adding a new customer and placing their order at the same time, you would first need to insert
 the customer into the Customers table to generate the customer_id (which will be auto-incremented).
 Once that is done, you can retrieve this newly generated customer_id and use it in the Orders table.
You do not use the DEFAULT keyword for customer_id in the Orders table**—because** the customer_id 
is a foreign key and needs to reference an existing value from the Customers table.*/

UPDATE orders
SET payment_method = 'Debit Card'
WHERE customer_id = 9;

UPDATE orders
SET payment_method = 'Cash'
WHERE customer_id = 3;


INSERT INTO orders (customer_id, order_date, shipping_address, total_amount, status, payment_method)
VALUES (8, '2024-10-24', '123 Maple St, New York', 39.99, 'Shipped', 'credit card');
    
CREATE TABLE order_details
	(order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    album_id INT,
    quantity INT,
    price_at_time DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (album_id) REFERENCES albums(album_id)
    );
    
    INSERT INTO Order_Details (order_id, album_id, quantity, price_at_time) VALUES
(6, 15, 2, 29.99), 
(3, 12, 1, 19.99),    
(5, 1, 1, 29.99),  
(7, 4, 2, 37.50),  
(9, 17, 1, 49.99),  
(1, 5, 4, 22.99),  
(4, 8, 1, 30.00),  
(9, 9, 2, 67.88),  
(10, 2, 3, 29.83),
(2, 18, 1, 49.99);

    
CREATE TABLE suppliers
	(supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(250),
    contact_person VARCHAR(250),
    phone_number VARCHAR(15),
    email VARCHAR(50),
    address VARCHAR(250),
    city VARCHAR(50)
    );
    
    

    INSERT INTO Suppliers (supplier_name, contact_person, phone_number, email, address, city) VALUES
('Vintage Sounds Inc.', 'Robert Johnson', '555-1234', 'robert.j@vintagesounds.com', '101 Music Ave', 'New York'),
('Classic Vinyl Distributors', 'Amanda Parker', '555-5678', 'amanda.p@classicvinyl.com', '202 Record Rd', 'Los Angeles'),
('Retro Grooves LLC', 'James Wilson', '555-9012', 'james.w@retrogrooves.com', '303 Melody St', 'Chicago'),
('Old School Records', 'Emily Smith', '555-3456', 'emily.s@oldschoolrecords.com', '404 Vinyl Ln', 'Houston'),
('Spin City Vinyl', 'Chris Brown', '555-7890', 'chris.b@spincityvinyl.com', '505 Disc Blvd', 'Phoenix'),
('The Vinyl Vault', 'Sarah Miller', '555-2345', 'sarah.m@vinylvault.com', '606 Album Ave', 'Philadelphia'),
('Rewind Records', 'David Taylor', '555-6789', 'david.t@rewindrecords.com', '707 Tune Dr', 'San Antonio'),
('Analog Records Co.', 'Laura Anderson', '555-4321', 'laura.a@analogrecords.com', '808 Record Circle', 'San Diego'),
('Wax Classics', 'Michael Martinez', '555-8765', 'michael.m@waxclassics.com', '909 Soundwave St', 'Dallas'),
('Groove Merchants', 'Lisa Davis', '555-0987', 'lisa.d@groovemerchants.com', '1010 Track Way', 'San Jose');

    
CREATE TABLE inventory
	(inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    album_id INT,
    supplier_id INT,
    purchase_date DATE,
    quantity INT,
    FOREIGN KEY (album_id) REFERENCES albums(album_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
    );
    
    
	INSERT INTO Inventory (inventory_id, album_id, supplier_id, purchase_date, quantity) VALUES
(DEFAULT, 8, 3, '2023-09-15', 150), 
(DEFAULT, 3, 1, '2023-09-18', 75),   
(DEFAULT, 5, 10, '2023-09-20', 200),  
(DEFAULT, 4, 7, '2023-09-22', 120),  
(DEFAULT, 10, 8, '2023-09-25', 180), 
(DEFAULT, 9, 4, '2023-09-28', 60),   
(DEFAULT, 15, 2, '2023-10-01', 90),  
(DEFAULT, 3, 5, '2023-10-03', 140), 
(DEFAULT, 18, 6, '2023-10-05', 110), 
(DEFAULT, 7, 9, '2023-10-07', 200);



 
    
    
    
    
    
    
    






