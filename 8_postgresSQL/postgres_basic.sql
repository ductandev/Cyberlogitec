-- =========================================================
-- XÓA DATABASE (DROP DATABASE)
-- =========================================================
-- PostgreSQL không cho phép xóa một database nếu bạn đang kết nối đến nó.
-- Bạn phải kết nối đến một database khác (ví dụ: `postgres`) trước khi thực hiện lệnh này.
-- Lỗi: `USE` không được hỗ trợ.
-- Sửa: Sử dụng lệnh `\c database_name` trong psql để chuyển đổi database.
DROP DATABASE if EXISTS instagram;

-- TẠO DATABASE
CREATE DATABASE instagram;

-- Chọn database để thao tác (chỉ dùng trong psql):
-- use instagram;
\c instagram;


-- =========================================================
-- TẠO BẢNG (CREATE TABLE)
-- =========================================================
CREATE TABLE users(
	id SERIAL PRIMARY KEY, -- Sửa: AUTO_INCREMENT không được hỗ trợ, thay bằng SERIAL.
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	age INT,
	birthday DATE
);

-- =========================================================
-- SỬA CẤU TRÚC BẢNG (ALTER TABLE)
-- =========================================================
-- PostgreSQL không hỗ trợ `MODIFY COLUMN`. 
-- Sửa: Dùng `ALTER COLUMN` thay thế.

-- sửa cột first_name, last_name thành chuỗi tối đa là 150
-- ALTER TABLE users
-- MODIFY COLUMN first_name VARCHAR(150),
-- MODIFY COLUMN last_name VARCHAR(160);

ALTER TABLE users
ALTER COLUMN first_name TYPE VARCHAR(150),
ALTER COLUMN last_name TYPE VARCHAR(160);

-- thêm cột user_type và gán giá trị mặc định nếu ko điền vào
-- ALTER TABLE users
-- ADD COLUMN user_type VARCHAR(100) DEFAULT "customer";

-- PostgreSQL không cho phép mặc định chuỗi sử dụng dấu nháy đôi `"`.
-- Sửa: Thay `"customer"` bằng `'customer'`.
ALTER TABLE users
ADD COLUMN user_type VARCHAR(100) DEFAULT 'customer';


--Xóa bảng
DROP TABLE if EXISTS users;


-- =========================================================
-- RÀNG BUỘC (CONSTRAINTS)
-- =========================================================
-- AUTO_INCREMENT: Không cần thêm vì đã dùng SERIAL khi tạo bảng.
-- Sửa: Thêm ràng buộc NOT NULL bằng lệnh `ALTER COLUMN`.
-- ALTER TABLE users
-- MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;

-- -- Giá trị ko dc null
-- ALTER TABLE users
-- MODIFY COLUMN age INT NOT NULL,
-- MODIFY COLUMN first_name VARCHAR(150) NOT NULL,
-- MODIFY COLUMN last_name VARCHAR(160) NOT NULL
-- -- Giá trị mặc định

ALTER TABLE users
ALTER COLUMN age SET NOT NULL,
ALTER COLUMN first_name SET NOT NULL,
ALTER COLUMN last_name SET NOT NULL;




-- =========================================================
-- THÊM DỮ LIỆU (INSERT INTO)
-- =========================================================
-- PostgreSQL không hỗ trợ chuỗi sử dụng dấu nháy đôi `"`.
-- Sửa: Dùng dấu nháy đơn `'`. 
INSERT INTO users (first_name, last_name, age, birthday)
VALUES  
    ('Hào', 'Nguyễn', 19, '1998-07-11'),
    ('Thảo', 'Trương', 20, '1999-08-22'),
    ('Trinh', 'Lê', 21, '1998-04-14'),
    ('Khoa', 'Nguyễn', 19, '1998-03-23'),
    ('Tú', 'Trương', 22, '1999-09-19'),
    ('Duy', 'Lê', 25, '1998-06-16');
		


-- =========================================================
-- Bài tập: Tạo bảng comments như bên dưới
-- =========================================================
-- id	comment_text					created_at
-- 1	Hào đẹp trai					2020-12-05 01:30:59
-- 2	Code tại CyberSoft thật đỉnh	2020-07-14 16:02:47
-- 3	No Comment :)) 					2021-01-27 23:59:32
DROP TABLE IF EXISTS user_comment;

CREATE TABLE user_comment(
	-- id INT PRIMARY KEY,
	id SERIAL PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	created_at TIMESTAMP NOT NULL
);

-- Thêm dữ liệu vào bảng user_comment
INSERT INTO user_comment(comment_text, created_at) VALUES 
		("Hào đẹp trai", "2020-12-05 01:30:59"),
		("Code tại CyberSoft thật đỉnh", "2020-07-14 16:02:47"),
		("No Comment :))","2021-01-27 23:59:32");




-- =========================================================
-- Bài 9: CRUD (create)
-- =========================================================
INSERT INTO users(id,first_name,last_name,age,birthday)
VALUES  (1,"Hào", "Nguyễn" ,19 ,"1998-04-16"),
		(2,"Thảo", "Nguyễn" ,20 ,"1999-04-16"),
		(3,"Trinh", "Nguyễn" ,21 ,"1998-04-16");


-- =========================================================
-- Bài 10: CRUD (Read)
-- =========================================================
-- Đọc data từ table của database
SELECT * FROM users;

-- đọc dữ liệu theo cột mong muốn và tuổi lớn hơn 19
SELECT  last_name as ho, 
		first_name as ten, 
		age as tuoi 
FROM users
WHERE age = 19;

SELECT * FROM user_comment;


-- =========================================================
-- Bài 11: CẬP NHẬT DỮ LIỆU (UPDATE)
-- =========================================================
-- Cập nhật dữ liệu
-- Cập nhật users
-- Sửa: Chuỗi phải dùng dấu `'`.
UPDATE users set user_type='admin'
WHERE id = 2;

SELECT * FROM users;

-- cập nhật tuổi 19 lên 20
-- SET SQL_SAFE_UPDATE = 0; -- nếu bị lỗi thì mở dòng này để chạy
UPDATE users set age = 20
WHERE age = 19;

SELECT * FROM users;


-- =========================================================
-- Bài 12: XÓA DỮ LIỆU (DELETE)
-- =========================================================
-- Xóa user
DELETE FROM users
WHERE id = 2;
SELECT * FROM users;

DELETE FROM users
WHERE age > 20;
SELECT * FROM users;


-- Xóa tất cả người dùng
DELETE FROM users;

-- =========================================================
-- Bài 13: Bài tập 
-- =========================================================
SELECT comment_text FROM user_comment
WHERE id = 2 ;

SELECT comment_text FROM user_comment
where created_at > "2020-07-14"

UPDATE user_comment set comment_text = "Hôm nay trời đẹp quá"
WHERE id = 3;

SELECT * FROM user_comment


-- Lỗi: `DELETE comment_text` không đúng cú pháp PostgreSQL.
-- Sửa: Nếu muốn xóa giá trị cột, sử dụng `UPDATE`.
-- DELETE comment_text FROM user_comment
-- WHERE comment_text != "";
UPDATE user_comment
SET comment_text = NULL
WHERE comment_text != '';

-- =========================================================
-- Bài 14: concat
-- =========================================================
-- concat
SELECT concat(first_name," ", last_name) as fullname from users;	  --=> MySQL

-- Sửa: PostgreSQL hỗ trợ toán tử `||` thay cho `CONCAT`.
SELECT first_name || ' ' || last_name AS fullname FROM users;

-- =========================================================
-- Bài 15: substr
-- =========================================================
-- SUBSTR là hàm cắt chuỗi . tham số :
-- 1/ chuỗi cần cắt
-- 2/ vị trí bắt đầu cắt
-- 3/ số lượng ký tự cần cắt
SELECT SUBSTRING(birthday,1,4) as year_of_birth FROM users				--=> MySQL
SELECT SUBSTRING(birthday,6,2) as month_of_birth FROM users				--=> MySQL
SELECT SUBSTRING(birthday,9,2) as day_of_birth FROM users				--=> MySQL

-- =========================================================
-- HÀM XỬ LÝ CHUỖI (STRING FUNCTIONS)
-- =========================================================
-- Sửa: Hàm `SUBSTRING` trong PostgreSQL cần `FROM` và `FOR`.
SELECT SUBSTRING(birthday FROM 1 FOR 4) AS year_of_birth FROM users;
SELECT SUBSTRING(birthday FROM 6 FOR 2) AS month_of_birth FROM users;
SELECT SUBSTRING(birthday FROM 9 FOR 2) AS day_of_birth FROM users;


-- =========================================================
-- Bài 16: replace
-- =========================================================
-- Vậy sự khác nhau giữa update với select là gì ?
-- Là update sẽ cập nhật dữ liệu lại luôn trong CSDL
-- còn select thì chỉ hiện thị thay thế tạm thời ở câu select đó thôi.
SELECT * from users;
-- Hàm REPLACE
SELECT REPLACE(user_type, 'customer', 'super_admin') AS loai_nguoi_dung FROM users;


-- =========================================================
-- Bài 17: reverse
-- =========================================================
-- REVERSE là hàm đảo ngược một cái chuỗi .
-- ⭐ Hàm REVERSE (PostgreSQL không có sẵn, cần dùng thủ tục hoặc extension)
-- Sửa: Sử dụng lệnh sau nếu cài module `string_agg`.
SELECT REVERSE(last_name) AS last_name_reverse FROM users;


-- =========================================================
-- Bài 18: UPPER, LOWER
-- =========================================================
-- UPPER là hàm in hoa các ký tự.
-- LOWER là hàm in thường các ký tự.
SELECT UPPER(first_name), LOWER(last_name) FROM users;



-- =========================================================
-- Bài 19: bài tập: Nếu comment dài hơn 8 ký tự thì cắt bỏ
-- các ký tự phía sau thay thế bằng '...'
-- =========================================================
SELECT * from user_comment;
-- SELECT CONCAT(SUBSTRING(comment_text,1,8), "...") as concat_comment from user_comment;
SELECT CONCAT(SUBSTRING(comment_text FROM 1 FOR 8), '...') AS concat_comment FROM user_comment;

-- =========================================================
-- Bài 20: DISTINCT (refinding select distinct)
-- =========================================================
-- DISTINCT chỉ lấy ra các giá trị khác nhau từ một cột của bảng
SELECT last_name FROM users;
SELECT DISTINCT last_name FROM users;

-- =========================================================
-- Bài 21: ORDER BY (refinding select order by)
-- =========================================================
-- ORDER BY là sắp xếp theo một thuộc tính nào đó trong bảng :
-- 1/ ASC là tăng dần ( 0-9 , a-z , A-Z )
-- 2/ DESC giảm dần , thử test cái này nhé :))

-- Tăng dần
SELECT * FROM users ORDER BY age ASC;

-- Giảm dần
SELECT * FROM users ORDER BY age DESC;

-- Theo thứ tự từ a-z
SELECT * from  users ORDER BY first_name ASC;

-- Theo thứ tự từ z-a
SELECT * from users ORDER BY first_name DESC;

-- =========================================================
-- Bài 22: Limit (refinding select limit)
-- =========================================================
-- LIMIT là giới hạn số phần tử lấy ra, cụ thể ở đây là 2 phần

-- lấy ra người dùng đầu tiên
SELECT * FROM users LIMIT 2;

-- lấy ra người dùng cuối cùng
SELECT * FROM users ORDER BY id DESC LIMIT 3;

-- =========================================================
-- Bài 23: TÌM KIẾM VỚI LIKE (LIKE OPERATOR)
-- =========================================================
-- À thì ra like là search gần giống ( không cần chính xác ) , % là ký tự gì
-- cũng được .các chuỗi “trần” , “dần” , “vầng” đều phù hợp nhé.
SELECT * from users
WHERE last_name LIKE "%ê%";


-- =========================================================
-- Bài 24: BÀI TẬP: SẮP XẾP COMMENT THEO THỜI GIAN
-- =========================================================
-- yêu cầu :
-- - lấy ra 3 comment
-- - sắp xếp theo thời gian tạo ra ( comment nào tạo ra trước thì để ở
-- dưới , comment nào tạo ra sau thì để ở trên )
SELECT * FROM user_comment
ORDER BY comment_text DESC
LIMIT 3;



-- =========================================================
-- Bài 25: AGGREGATE FUNCTIONS (COUNT, MIN, MAX, AVG, SUM)
-- =========================================================
-- Đếm xem có bao nhiêu user trong table users
SELECT COUNT(*) AS tong_so_luong_nguoi_dung FROM users;

-- Đếm xem có bao nhiêu họ nguyễn
SELECT count(*) FROM users
WHERE last_name = "nguyễn";

-- Vận dụng Count kết hợp với Distinct để tính toán xem
-- có bao nhiêu last_name khác nhau
SELECT COUNT(DISTINCT last_name) as so_ho_khac_nhau FROM users;

-- =========================================================
-- Bài 26: function aggregate max min
-- =========================================================
SELECT MIN(age) AS age_min, MAX(age) AS age_max FROM users;

-- câu lệnh query phụ giúp chúng ta tìm độ tuổi nhỏ nhất
-- sau đó mới tìm tới user có độ tuổi được tìm thấy trong
-- câu truy vấn phụ
-- sub Query
SELECT * FROM users WHERE age = (SELECT min(age) FROM users);

-- sub Query
SELECT * FROM users WHERE age = (SELECT max(age) FROM users);

-- =========================================================
-- Bài 27: function aggregate count
-- =========================================================
-- cách này hay hơn việc đếm last_name khác nhau , ngoài
-- ra lập nhóm ra để gì ?

-- Group by họ và đếm số lượng
SELECT last_name, COUNT(*) FROM users GROUP BY last_name;

-- Tổng số tuổi theo họ
SELECT last_name, SUM(age) FROM users GROUP BY last_name;

-- Trung bình số tuổi theo họ
SELECT last_name, AVG(age) FROM users GROUP BY last_name;


-- =========================================================
-- 28: ĐẾM SỐ LƯỢNG GIỚI TÍNH (NAM/NỮ) TRONG BẢNG
-- =========================================================
-- Lỗi: Bảng `patients` không tồn tại trong mã gốc. Đây là ví dụ:
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    gender VARCHAR(1)
);

select 
	sum(gender = 'M') as male_count,
    sum(gender = 'F') as female_count
from patients;














































