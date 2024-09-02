-- 1. CREATE DATA BASE global_store_db

CREATE DATABASE global_store_db;
USE global_store_db;

-- CREATE TABLE

CREATE TABLE products (
  product_id INT AUTO_INCREMENT,
  name VARCHAR(100),
  price DECIMAL(10, 2),
  quantity INT,
  PRIMARY KEY (product_id)
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT,
  product_id INT,
  quantity_ordered INT,
  order_date DATE,
  PRIMARY KEY (order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2. Alter products table

ALTER TABLE products
ADD COLUMN category VARCHAR(50) AFTER price;

-- 3. Rename products table

RENAME TABLE products TO inventory;

-- 4. Insert records and display tables

INSERT INTO inventory (name, price,  category , quantity )
VALUES
  ('Mobile', 25999.99, 'Electronics', 3),
  ('Shirt', 499.99,  'Clothing' , 15),
  ('Fridge', 16789.45, 'Home Goods' , 2),
  ('TV', 39999.99, 'Electronics' , 3),
  ('Jeans', 444.44, 'Clothing' , 12),
  ('Air Cooler', 69999.55,  'Home Goods' , 7),
  ('Laptop', 58999.99, 'Electronics' , 8),
  ('Skirt', 998.99, 'Clothing' , 25),
  ('Washing Machine', 23999.99, 'Home Goods' , 4),
  ('Tablet', 25999.00, 'Electronics' , 5);

INSERT INTO orders (product_id, quantity_ordered, order_date)
VALUES
  (1, 2, '2024-01-25'),
  (2, 3, '2023-12-15'),
  (3, 1, '2024-02-01'),
  (4, 4, '2024-02-15'),
  (5, 2, '2024-03-01');

SELECT * FROM inventory;
SELECT * FROM orders;

-- 5. Write queries

-- a) Distinct categories

SELECT DISTINCT category FROM inventory;

-- b) Top 5 products by price

SELECT * FROM inventory
ORDER BY price DESC
LIMIT 5;

-- c) Products with quantity greater than 10

SELECT * FROM inventory
WHERE quantity > 10;

-- d) Total price of all products

SELECT SUM(price * quantity) AS total_price FROM inventory;

-- e) Group products by category

SELECT category, COUNT(*) AS count
FROM inventory
GROUP BY category;

-- f) Out of stock products

SELECT * FROM inventory
WHERE quantity = 0;


-- 6. Create view

CREATE VIEW expensive_products AS
SELECT * FROM inventory
WHERE price > (SELECT AVG(price) FROM inventory);

-- 7. Join query

SELECT i.name, o.quantity_ordered
FROM inventory i
JOIN orders o ON i.product_id = o.product_id;