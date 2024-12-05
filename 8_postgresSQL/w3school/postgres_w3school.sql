-- Create Table --
CREATE TABLE cars (
  id SERIAL PRIMARY KEY,
  brand VARCHAR(255),
  model VARCHAR(255),
  year INT
);

SELECT * FROM cars
ORDER BY year;

-- Insert Into --
INSERT INTO cars (brand, model, year)
VALUES 
  ('Ford', 'Mustang', 1964),
  ('Volvo', 'p1800', 1968),
  ('BMW', 'M1', 1978),
  ('Toyota', 'Celica', 1975);


-- Select Data --
SELECT * FROM cars;
-- Specify Columns--
SELECT brand, year FROM cars;


-- ADD COLUMN --
ALTER TABLE cars
ADD color VARCHAR(255);


-- UPDATE --
UPDATE cars
SET color = 'red'
WHERE brand = 'Volvo';


-- ALTER COLUMN --
ALTER TABLE cars
ALTER COLUMN year TYPE VARCHAR(4);
ALTER TABLE cars
ALTER COLUMN color TYPE VARCHAR(30);


-- DROP COLUMN -- => Dùng để xóa cột hoặc xóa bảng (Không xóa hàng)
ALTER TABLE cars
DROP COLUMN color;


-- DELETE Statement -- => Xóa Record (xóa hàng)
DELETE FROM cars
WHERE brand = 'Volvo';
-- Delete all records in the cars table:
TRUNCATE TABLE cars;


-- DROP TABLE Statement --
DROP TABLE cars;


-- ==============================
--      PostgreSQL Syntax
-- ==============================

-- Operators --
SELECT * FROM cars
WHERE brand = 'Volvo';
WHERE year < 1975;
WHERE year > 1975;
WHERE year <= 1975;
WHERE year >= 1975;
WHERE brand <> 'Volvo';
WHERE brand != 'Volvo';
WHERE model LIKE 'M%';
WHERE model ILIKE 'm%';
WHERE brand = 'Volvo' AND year = 1968;
WHERE brand = 'Volvo' OR year = 1975;
WHERE brand IN ('Volvo', 'Mercedes', 'Ford');
WHERE year BETWEEN 1970 AND 1980;
WHERE model IS NULL;
WHERE brand NOT LIKE 'B%';
WHERE brand NOT ILIKE 'b%';
WHERE brand NOT IN ('Volvo', 'Mercedes', 'Ford');
WHERE year NOT BETWEEN 1970 AND 1980;
WHERE model IS NOT NULL;

-- Specify Columns --
SELECT customer_name, country FROM customers;

-- SELECT DISTINCT -- chỉ trả về các giá trị riêng biệt (khác nhau).
SELECT DISTINCT country FROM customers;

-- SELECT COUNT(DISTINCT) --
SELECT COUNT(DISTINCT country) FROM customers;

-- Filter Records--
SELECT * FROM customers
WHERE city = 'London';
WHERE customer_id = 19;
WHERE customer_id > 80;

-- Sort Data --
SELECT * FROM products
ORDER BY price;
ORDER BY price DESC;
ORDER BY product_name;
ORDER BY product_name DESC;

-- The LIMIT Clause --
SELECT * FROM customers
LIMIT 20;
LIMIT 20 OFFSET 40;  -- If you want to return 20 records, but start at number 40, you can use both LIMIT and OFFSET.

-- MIN and MAX Functions --
SELECT MIN(price)
FROM products;
SELECT MAX(price)
FROM products;

SELECT MIN(price) AS lowest_price
FROM products;

-- COUNT Function --
SELECT COUNT(customer_id)
FROM customers;

SELECT COUNT(customer_id)
FROM customers
WHERE city = 'London';

-- SUM Function --
SELECT SUM(quantity)
FROM order_details;

-- AVG Function --
SELECT AVG(price)
FROM products;

-- With 2 Decimals --
-- the result was 28.8663636363636364. => ⭐KQ: 28.87
SELECT AVG(price)::NUMERIC(10,2)
FROM products;

-- LIKE Operator --
SELECT * FROM customers
WHERE customer_name LIKE 'A%';
SELECT * FROM customers
WHERE customer_name LIKE '%A%';

-- IN Operator --
-- The IN operator is a shorthand for multiple OR conditions.
SELECT * FROM customers
WHERE country IN ('Germany', 'France', 'UK');
SELECT * FROM customers
WHERE country NOT IN ('Germany', 'France', 'UK');
-- IN (SELECT) --
SELECT * FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);
-- NOT IN (SELECT) --
SELECT * FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

-- BETWEEN Operator -- 
SELECT * FROM Products
WHERE Price BETWEEN 10 AND 15;
-- BETWEEN Text Values --
SELECT * FROM Products
WHERE product_name BETWEEN 'Pavlova' AND 'Tofu';

SELECT * FROM Products
WHERE product_name BETWEEN 'Pavlova' AND 'Tofu'
ORDER BY product_name;
-- BETWEEN Date Values--
SELECT * FROM orders
WHERE order_date BETWEEN '2023-04-12' AND '2023-05-05';


-- AS (Aliases) --
SELECT customer_id AS id
FROM customers;
-- AS is Optional --
SELECT customer_id id
FROM customers;
-- Concatenate Columns --
SELECT product_name || unit AS product
FROM products;

SELECT product_name || ' ' || unit AS product
FROM products;

-- Using Aliases With a Space Character --
SELECT product_name AS "My Great Products"
FROM products;

-- JOINS --
SELECT product_id, product_name, category_name
FROM products
INNER JOIN categories ON products.category_id = categories.category_id;

-- Different Types of Joins
-- Here are the different types of the Joins in PostgreSQL:

-- INNER JOIN: Returns records that have matching values in both tables
-- LEFT JOIN: Returns all records from the left table, and the matched records from the right table
-- RIGHT JOIN: Returns all records from the right table, and the matched records from the left table
-- FULL JOIN: Returns all records when there is a match in either left or right table


-- INNER JOIN --
SELECT testproduct_id, product_name, category_name
FROM testproducts
INNER JOIN categories ON testproducts.category_id = categories.category_id;


-- LEFT JOIN --
SELECT testproduct_id, product_name, category_name
FROM testproducts
LEFT JOIN categories ON testproducts.category_id = categories.category_id;

-- RIGHT JOIN --
SELECT testproduct_id, product_name, category_name
FROM testproducts
RIGHT JOIN categories ON testproducts.category_id = categories.category_id;

-- FULL JOIN --
SELECT testproduct_id, product_name, category_name
FROM testproducts
FULL JOIN categories ON testproducts.category_id = categories.category_id;

-- CROSS JOIN --
SELECT testproduct_id, product_name, category_name
FROM testproducts
CROSS JOIN categories;

-- UNION Operator --
SELECT product_id, product_name
FROM products
UNION
SELECT testproduct_id, product_name
FROM testproducts
ORDER BY product_id;

-- UNION vs UNION ALL --
-- Example - UNION
SELECT product_id
FROM products
UNION
SELECT testproduct_id
FROM testproducts
ORDER BY product_id;

-- Example - UNION ALL
SELECT product_id
FROM products
UNION ALL
SELECT testproduct_id
FROM testproducts
ORDER BY product_id;

SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

-- GROUP BY --
SELECT COUNT(customer_id), country
FROM customers
GROUP BY country;

-- LEN --
SELECT patient_id, first_name FROM patients
WHERE
  first_name LIKE 's%s'
  AND LEN(first_name) >= 6;

-- GROUP BY With JOIN --
SELECT customers.customer_name, COUNT(orders.order_id)
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customer_name;

-- HAVING --
SELECT COUNT(customer_id), country
FROM customers
GROUP BY country
HAVING COUNT(customer_id) > 5;

-- More HAVING Examples --
SELECT order_details.order_id, SUM(products.price)
FROM order_details
LEFT JOIN products ON order_details.product_id = products.product_id
GROUP BY order_id
HAVING SUM(products.price) > 400.00;


SELECT customers.customer_name, SUM(products.price)
FROM order_details
LEFT JOIN products ON order_details.product_id = products.product_id
LEFT JOIN orders ON order_details.order_id = orders.order_id
LEFT JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customer_name
HAVING SUM(products.price) > 1000.00;


-- EXISTS Operator --
SELECT customers.customer_name
FROM customers
WHERE EXISTS (
  SELECT order_id
  FROM orders
  WHERE customer_id = customers.customer_id
);

-- NOT EXISTS --
SELECT customers.customer_name
FROM customers
WHERE NOT EXISTS (
  SELECT order_id
  FROM orders
  WHERE customer_id = customers.customer_id
);

-- ANY Operator --
SELECT product_name
FROM products
WHERE product_id = ANY (
  SELECT product_id
  FROM order_details
  WHERE quantity > 120
);

-- ALL Operator --
SELECT product_name
FROM products
WHERE product_id = ALL (
  SELECT product_id
  FROM order_details
  WHERE quantity > 10
);

-- CASE Expression --
SELECT product_name,
CASE
  WHEN price < 10 THEN 'Low price product'
  WHEN price > 50 THEN 'High price product'
ELSE
  'Normal product'
END
FROM products;

-- With an Alias
SELECT product_name,
CASE
  WHEN price < 10 THEN 'Low price product'
  WHEN price > 50 THEN 'High price product'
ELSE
  'Normal product'
END AS "price category"
FROM products;

