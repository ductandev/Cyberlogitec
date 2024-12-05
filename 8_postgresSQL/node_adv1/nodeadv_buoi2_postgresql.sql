CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	price NUMERIC,
	manufacturer VARCHAR(100),
	attributes JSON
)

-- { "id":1, "name":"abc" }

CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	email VARCHAR(100),
	phone VARCHAR(100)
)


CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
	customer_id INT,
	product_id INT,
	order_date TIMESTAMP, -- YYYY-MM-DD hh:mm:ss
	quantity NUMERIC,
	
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (product_id) REFERENCES products(id)
)

INSERT INTO products (name, price, manufacturer, attributes) VALUES
('Laptop A', 1200.00, 'Company A', '{"color": "silver", "memory": "16GB", "storage": "512GB SSD", "category": "Electronics"}'),
('Smartphone B', 800.00, 'Company B', '{"color": "black", "memory": "8GB", "storage": "256GB", "category": "Electronics"}'),
('Tablet C', 500.00, 'Company C', '{"color": "white", "memory": "4GB", "storage": "128GB", "category": "Electronics"}'),
('Smartwatch D', 300.00, 'Company D', '{"color": "blue", "battery_life": "24 hours", "category": "Wearables"}'),
('Headphones E', 150.00, 'Company E', '{"color": "black", "wireless": true, "noise_cancelling": true, "category": "Audio"}'),
('Gaming Console F', 400.00, 'Company F', '{"color": "red", "storage": "1TB", "category": "Gaming"}'),
('Camera G', 700.00, 'Company G', '{"megapixels": "24MP", "zoom": "10x", "color": "black", "category": "Photography"}'),
('Printer H', 200.00, 'Company H', '{"type": "laser", "color": "white", "wireless": true, "category": "Office Equipment"}'),
('Monitor I', 250.00, 'Company I', '{"size": "27 inches", "resolution": "4K", "color": "black", "category": "Electronics"}'),
('Keyboard J', 50.00, 'Company J', '{"type": "mechanical", "color": "white", "category": "Computer Accessories","size":100}');


SELECT *
FROM products
WHERE  (attributes->>'size')::NUMERIC = 10


