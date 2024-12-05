-- =========================================================
-- XÓA DATABASE (DROP DATABASE)
-- =========================================================
-- PostgreSQL không cho phép xóa một database nếu bạn đang kết nối đến nó.
-- Bạn phải kết nối đến một database khác (ví dụ: `postgres`) trước khi thực hiện lệnh này.
-- Lỗi: `USE` không được hỗ trợ.
-- Sửa: Sử dụng lệnh `\c database_name` trong psql để chuyển đổi database.

DROP DATABASE IF EXISTS instagram;

-- TẠO DATABASE
CREATE DATABASE instagram;

-- Chọn database để thao tác (chỉ dùng trong psql):
-- \c instagram;

-- =========================================================
-- TẠO BẢNG (CREATE TABLE)
-- =========================================================
CREATE TABLE users (
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

ALTER TABLE users
ALTER COLUMN first_name TYPE VARCHAR(150),
ALTER COLUMN last_name TYPE VARCHAR(160);

-- PostgreSQL không cho phép mặc định chuỗi sử dụng dấu nháy đôi `"`.
-- Sửa: Thay `"customer"` bằng `'customer'`.
ALTER TABLE users
ADD COLUMN user_type VARCHAR(100) DEFAULT 'customer';

-- =========================================================
-- RÀNG BUỘC (CONSTRAINTS)
-- =========================================================
-- AUTO_INCREMENT: Không cần thêm vì đã dùng SERIAL khi tạo bảng.
-- Sửa: Thêm ràng buộc NOT NULL bằng lệnh `ALTER COLUMN`.

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
-- TẠO BẢNG COMMENTS
-- =========================================================
DROP TABLE IF EXISTS user_comment;

CREATE TABLE user_comment (
    id SERIAL PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL
);

-- Thêm dữ liệu vào bảng user_comment
INSERT INTO user_comment (comment_text, created_at)
VALUES 
    ('Hào coder', '2020-12-05 01:30:59'),
    ('Code tại CyberSoft thật đỉnh', '2020-07-14 16:02:47'),
    ('No Comment :))', '2021-01-27 23:59:32');

-- =========================================================
-- CẬP NHẬT DỮ LIỆU (UPDATE)
-- =========================================================
-- PostgreSQL không hỗ trợ `SQL_SAFE_UPDATE`, bỏ dòng đó.
-- Sửa: Chuỗi phải dùng dấu `'`.

UPDATE users SET user_type = 'admin' WHERE id = 2;

-- Cập nhật độ tuổi
UPDATE users SET age = 20 WHERE age = 19;

-- =========================================================
-- XÓA RECORD DỮ LIỆU (DELETE)
-- =========================================================
DELETE FROM users WHERE id = 2;

DELETE FROM users WHERE age > 20;

-- Xóa tất cả người dùng
DELETE FROM users;

--`UPDATE`.
UPDATE user_comment
SET comment_text = NULL
WHERE comment_text != '';

-- =========================================================
-- HÀM XỬ LÝ CHUỖI (STRING FUNCTIONS)
-- =========================================================
-- Sửa: Hàm `SUBSTRING` trong PostgreSQL cần `FROM` và `FOR`.
SELECT SUBSTRING(birthday FROM 1 FOR 4) AS year_of_birth FROM users;
SELECT SUBSTRING(birthday FROM 6 FOR 2) AS month_of_birth FROM users;
SELECT SUBSTRING(birthday FROM 9 FOR 2) AS day_of_birth FROM users;

-- Sửa: PostgreSQL hỗ trợ toán tử `||` thay cho `CONCAT`.
SELECT first_name || ' ' || last_name AS fullname FROM users;
SELECT CONCAT(first_name, last_name) AS concat_comment FROM user_comment;

-- Hàm REPLACE
SELECT REPLACE(user_type, 'customer', 'super_admin') AS loai_nguoi_dung FROM users;

-- Hàm REVERSE (PostgreSQL không có sẵn, cần dùng thủ tục hoặc extension)
-- Sửa: Sử dụng lệnh sau nếu cài module `string_agg`.
SELECT REVERSE(last_name) AS last_name_reverse FROM users;

-- Hàm UPPER, LOWER
SELECT UPPER(first_name), LOWER(last_name) FROM users;

-- Cắt chuỗi và thêm "..." nếu chuỗi dài hơn 8 ký tự
SELECT CONCAT(SUBSTRING(comment_text FROM 1 FOR 8), '...') AS concat_comment FROM user_comment;

-- =========================================================
-- DISTINCT, ORDER BY, LIMIT
-- =========================================================
SELECT DISTINCT last_name FROM users;

SELECT * FROM users ORDER BY age ASC;
SELECT * FROM users ORDER BY age DESC;

-- LIMIT và OFFSET
SELECT * FROM users LIMIT 2;
SELECT * FROM users ORDER BY id DESC LIMIT 3;

-- =========================================================
-- AGGREGATE FUNCTIONS (COUNT, MIN, MAX, GROUP BY)
-- =========================================================
SELECT COUNT(*) AS tong_so_luong_nguoi_dung FROM users;

SELECT MIN(age) AS age_min, MAX(age) AS age_max FROM users;

-- Subquery để tìm người trẻ nhất
SELECT * FROM users WHERE age = (SELECT MIN(age) FROM users);

-- Group by họ và đếm số lượng
SELECT last_name, COUNT(*) FROM users GROUP BY last_name;

-- Tổng số tuổi theo họ
SELECT last_name, SUM(age) FROM users GROUP BY last_name;

-- Trung bình số tuổi theo họ
SELECT last_name, AVG(age) FROM users GROUP BY last_name;

-- =========================================================
-- TÌM KIẾM VỚI LIKE
-- =========================================================
SELECT * FROM users WHERE last_name LIKE '%ê%';

-- =========================================================
-- BÀI TẬP: SẮP XẾP COMMENT THEO THỜI GIAN
-- =========================================================
SELECT * FROM user_comment
ORDER BY created_at DESC
LIMIT 3;

-- =========================================================
-- ĐẾM SỐ LƯỢNG GIỚI TÍNH (NAM/NỮ) TRONG BẢNG
-- =========================================================
-- Lỗi: Bảng `patients` không tồn tại trong mã gốc. Đây là ví dụ:
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    gender VARCHAR(1)
);

SELECT 
    SUM(gender = 'M') AS male_count,
    SUM(gender = 'F') AS female_count
FROM patients;
