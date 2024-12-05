-- =========================================================
-- Bài 2: analytis create table
-- =========================================================
DROP DATABASE IF EXISTS mysql_relationship;
CREATE DATABASE mysql_relationship;
\c mysql_relationship;

-- Tạo bảng customer - tạo bảng 1 ( trong mối quan hệ 1 - n)
CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(150) NOT NULL,
    last_name VARCHAR(150) NOT NULL,
    email VARCHAR(200) NOT NULL,
    birthday DATE NOT NULL
);

-- Thêm data vào table customers
INSERT INTO customers(first_name, last_name, email, birthday) VALUES
('Hào', 'Nguyễn', 'hao@gmail.com', '1997-05-11'),
('Thảo', 'Trương', 'thaotruong@gmail.com', '1999-11-12'),
('Hường', 'Lê', 'huong@gmail.com', '2000-03-15');

--	Tạo bảng order - tạo bảng nhiều ( trong mối quan hệ 1 - n)
CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    price REAL NOT NULL,
    amount DOUBLE PRECISION NOT NULL,
    customer_id INT,
	
-- Ngoặc đầu tiên chèn vô khóa ngoại muốn liên kết đến bảng khác
-- ngoặc thứ 2 chèn tên bảng và tên khóa chính của bảng đó
-- Khóa chính và khóa ngoại thường đặt trùng tên để dễ nhận biết
-- Nguyên tắc bảng nào ko có khóa ngoại thì tạo trước => và thêm dữ liệu trước
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
)

-- Thêm data vào table customers
INSERT INTO orders(order_date,price,amount,customer_id) VALUES
('2021-02-17', 1000, 80, 1),
('2021-02-13', 1500, 50, 2),
('2021-01-17', 500, 10, 1);

INSERT INTO orders(order_date,price,amount) VALUES
('2021-03-17', 700, 80),
('2021-02-13', 900, 50),
('2021-01-17', 1600, 10);

-- =========================================================
-- Bài 3: cross join
-- =========================================================
-- Tìm ra đơn đặt hàng mà hào đã đặt
-- Các bước thực hiện: 
	-- b1: Tìm customer_id của hào
	-- b2: Dùng where để tìm ra các order của customer_id
SELECT customer_id FROM customers
WHERE first_name = 'Hào'


-- Cross join -> cách 2
SELECT * FROM orders WHERE customer_id = (
	SELECT customer_id FROM customers
	WHERE first_name = 'Hào'
);


-- =========================================================
-- Bài 4: inner join
-- =========================================================
-- Inner join -> Cách 1
SELECT * FROM customers, orders
WHERE customers.customer_id = orders.customer_id && first_name = 'Hào';
	
	
-- Inner join -> Cách 2 ⭐🚀 cách này hay dùng đi làm ở cty
SELECT * FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE first_name = 'Hào';

-- Những khách hàng nào có đơn đặt hàng lớn hơn hoặc bằng 1000
SELECT * FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
where price >= 1000;

SELECT concat(first_name,' ',last_name) as ho_va_ten FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
where price >= 1000;


-- =========================================================
-- Bài 6: left join
-- =========================================================
-- Lấy ra những khách hàng chưa có đơn đặt hàng
-- nguyên tắc: from tay trái join tay phải
SELECT * FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.customer_id is NULL;

SELECT * FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.customer_id is NOT NULL;


-- Nhớ tắt mở lại để reset : MySQL - How to turn off ONLY_FULL_GROUP_BY?
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY','')); 


-- Left join
-- Tìm tổng số lượng sản phẩm mà khách hàng đã mua
SELECT *, ifnull(sum(amount), 0) FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id;


SELECT 
	concat(first_name,' ',last_name),
	ifnull(sum(amount), 0) 
	as tong_sp
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id
ORDER BY tong_sp DESC;


-- =========================================================
-- Bài 7: right join
-- =========================================================
-- Right join
-- Tìm các khách hàng đã mua sản phẩm vào tháng 2
select * from customers
RIGHT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE order_date like '%-02-%';


select ifnull(concat(first_name,' ',last_name),'MISSING') as ho_ten from customers
RIGHT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE order_date like '%-02-%';


-- =========================================================
-- Bài 8: full join
-- =========================================================
-- Full join ( kết hợp giữa left join và right join) lệnh để kết hợp là : union
SELECT * FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.order_id
UNION -- Lệnh kết hợp để dùng full join
SELECT * FROM customers
RIGHT JOIN orders
ON customers.customer_id = orders.order_id


-- =========================================================
-- Bài 9: many to many
-- =========================================================
CREATE TABLE laptops (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(150) NOT NULL,
	description VARCHAR (1000) not NULL,
	price DOUBLE NOT NULL
);

INSERT INTO laptops(name,description,price) VALUES
('Macbook M1', 'Laptop xịn nhất hiện nay', 4000),
('Acer Nitro 5', 'Laptop gaming đỉnh cao', 1500),
('Dell Gaming G3', 'Laptop gamming mỏng nhẹ', 1600),
('Razer Blaze 15', 'Laptop đồ họa đỉnh cao', 5000);

CREATE TABLE stores(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(150) NOT NULL,
	address VARCHAR(250) NOT NULL
);

INSERT INTO stores(name, address) VALUES
('FPT shop', '150 Cao Thắng Quận 3 Thành Phố Hồ Chí Minh'),
('Điện máy xanh', '203 Điện Biên Phủ Quận 3 Thành Phố Hồ Chí Minh'),
('Thế Giới Di Động', '105 3/2 Quận 10 Thành Phố Hồ Chí Minh');


CREATE TABLE laptops_stores(
	id INT PRIMARY KEY AUTO_INCREMENT, 
	laptop_id INT,
	store_id INT,
	
	FOREIGN KEY (laptop_id) REFERENCES laptops(id),
	FOREIGN KEY (store_id) REFERENCES stores(id)
);

INSERT INTO laptops_stores(laptop_id,store_id) VALUES
(1, 1), (1, 2),
(2, 2), (1, 3),
(3, 1), (3, 2), (3, 3);



-- =========================================================
-- Bài 10: many to many inner join
-- =========================================================
-- Tìm xem điện máy xanh đang bán những mẫu laptop nào
	-- B1: Join những bảng table lại với nhau
	-- B2: Tìm tên điện máy xanh
	-- B3: Lấy ra tên laptop và giá của nó
	
SELECT * FROM stores
-- SELECT laptops.name, laptops.price  FROM stores
INNER JOIN laptops_stores
ON stores.id = laptops_stores.store_id
INNER JOIN laptops 
ON laptops.id  = laptops_stores.laptop_id
WHERE stores.name = 'Điện máy xanh';


-- =========================================================
-- Bài 11: many to many inner join part 2
-- =========================================================
-- Tìm xem macbook M1 đang được bán tại cửa hàng nào
	-- B1: Join những bảng table lại với nhau
	-- B2: Tìm tên macbook M1 trên bảng laptops
	-- B3: tìm cửa hàng đang bán M1
	
SELECT * FROM laptops
-- SELECT stores.name as cua_hang FROM laptops 
INNER JOIN laptops_stores
ON laptops.id = laptops_stores.laptop_id
INNER JOIN stores
ON stores.id = laptops_stores.store_id
WHERE laptops.name like '%Macbook M1%';


-- =========================================================
-- Bài 12: many to many - left join
-- =========================================================
-- Tìm xem các laptop chưa được bán tại bất kỳ cửa hàng nào.
	-- Các bước thực hiện
		-- B1: join các table lại với nhau
		-- B2: tìm xem laptops nào chưa bán
		-- B3: lấy tên laptop, giá

SELECT * FROM laptops
-- SELECT laptops.name, laptops.price FROM laptops
LEFT JOIN laptops_stores
ON laptops.id = laptops_stores.laptop_id
LEFT JOIN stores 
ON stores.id = laptops_stores.store_id
where store_id is NULL;



-- =========================================================
-- Bài 13: many to many - right join
-- =========================================================
-- Tìm xem các Macbook M1 có được bán tại thế giới di động hay không ?
	-- Các bước thực hiện
		-- B1: join các table lại với nhau
		-- B2: setup điều kiện
		-- B3: lấy ra tên
-- Select from tới bảng nào thì bảng đó nằm bên tay trái
SELECT * FROM laptops
RIGHT JOIN  laptops_stores
ON laptops.id = laptops_stores.laptop_id 
RIGHT JOIN stores 
ON stores.id = laptops_stores.store_id
WHERE laptops.name = 'Macbook M1' && stores.name = 'Thế Giới Di Động'; 


-- =========================================================
-- Bài 14: instagram phan tic
-- =========================================================


-- =========================================================
-- Bài 15: instagram
-- =========================================================


-- =========================================================
-- Bài 16: instagram query part 1
-- =========================================================
-- Tìm 5 người sử dụng ứng dụng lâu nhất.
USE ig_clone;

SELECT * FROM users
ORDER BY created_at ASC
LIMIT 5  ;

-- =========================================================
-- Bài 17: instagram query part 2
-- =========================================================
-- tìm 2 ngày trong tuần (thứ mấy) có lượt đăng ký nhiều nhất.
-- dayname: lệnh dùng để hiển thị thứ của cột created_at
SELECT *, dayname(created_at) as day, count(*) as total_register FROM users
GROUP BY DAY
ORDER BY total_register DESC
LIMIT 2;

-- =========================================================
-- Bài 18: instagram query part 3
-- =========================================================
-- Xác định người dùng không hoạt động ( người dùng ko đăng ảnh)
SELECT * FROM users
LEFT JOIN photos
ON users.id = photos.user_id
where user_id is NULL;


-- =========================================================
-- Bài 20: instagram query part 5
-- =========================================================
-- Xác định ảnh có nhiều like nhất và người dùng tạo ra nó
SELECT username, photos.image_url, count(*) as total FROM users
INNER JOIN likes
on users.id = likes.user_id
INNER JOIN photos
on photos.id = likes.photo_id
GROUP BY photos.id
ORDER BY total DESC
limit 1;

-- =========================================================
-- Bài 21: instagram query part 6
-- =========================================================
-- Tìm số lượng ảnh trung bình cho mỗi người dùng
-- Câu lệnh truy vấn phụ
SELECT count(*) FROM users;
SELECT count(*) FROM photos;
SELECT ( SELECT count(*) FROM photos ) / 
	   (SELECT count(*) FROM users) as avg_user_photos;









DROP DATABASE if EXISTS README_PLEASEEEEE;
CREATE DATABASE README_PLEASEEEEE;
USE README_PLEASEEEEE;


CREATE TABLE read_me(
	id INT PRIMARY KEY AUTO_INCREMENT,
	messagee VARCHAR(255)
);

INSERT INTO read_me(messagee) VALUES
	('THIS PROJECT IS ONLY FOR PURPOSE LEARNING AND DATA FAKE BY CHAT GPT. IF YOU CAN ACCESS PLEASE DON'T BREAK IT. THASK YOU VERY MUCH !!!');






















