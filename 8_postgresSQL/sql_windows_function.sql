CREATE TABLE Sales (
    City NVARCHAR(50),
    Region NVARCHAR(50),
    SalesAmount DECIMAL(10, 2)
);

INSERT INTO Sales (City, Region, SalesAmount) VALUES
('Hà Nội', 'Miền Bắc', 1000),
('Hải Phòng', 'Miền Bắc', 1500),
('Đà Nẵng', 'Miền Trung', 2000),
('Huế', 'Miền Trung', 1800),
('TP.HCM', 'Miền Nam', 2500),
('Cần Thơ', 'Miền Nam', 2200);

-- ===================================================
--              OVER() || PARTITION BY
-- ===================================================

-- OVER(): Định nghĩa phạm vi (window)
-- OVER() là có thể giữ nguyên tất cả các hàng mà không cần gộp nhóm (grouping), hữu ích khi cần các phép tính tổng hợp nhưng vẫn giữ chi tiết
-- PARTITION BY: Region chia nhóm dữ liệu theo từng vùng.
-- ✅ CÁCH 1: DÙNG OVER() VÀ PARTITION
SELECT 
    City,
    Region,
    SalesAmount,
    SUM(SalesAmount) OVER (PARTITION BY Region) AS TotalSalesByRegion
FROM Sales;


-- ✅ CÁCH 2: DÙNG GROUP BY
SELECT
    city,
    region,
    sales_amount,
    SUM(sales_amount) AS TotalSalesByRegion
from sales
GROUP BY city,region, sales_amount




|----------------------------------------------------------------|
|                       ✅ KỂT QUẢ ✅                           |
| City       || Region      || SalesAmount || TotalSalesByRegion |
|------------||-------------||-------------||--------------------|
| Hà Nội     || Miền Bắc    || 1000.00     || 2500.00            |
| Hải Phòng  || Miền Bắc    || 1500.00     || 2500.00            |
| Đà Nẵng    || Miền Trung  || 2000.00     || 3800.00            |
| Huế        || Miền Trung  || 1800.00     || 3800.00            |
| TP.HCM     || Miền Nam    || 2500.00     || 4700.00            |
| Cần Thơ    || Miền Nam    || 2200.00     || 4700.00            |
|----------------------------------------------------------------|


-- 2 câu lệnh nảy tương đương với nhau 
SELECT i, SUM(i) OVER () FROM t;

SELECT i,(SELECT SUM(i) FROM t) FROM t

|------------------|
| ✅ KỂT QUẢ ✅   |
| i     || sum     |
|-------||---------|
| 1     ||   10    |
| 2     ||   10    |
| 3     ||   10    |
| 4     ||   10    |
|------------------|



CREATE TABLE sales(
	employee VARCHAR(50), 
	"date" DATE, 
	sale INT
);

INSERT INTO sales VALUES 
('odin', '2017-03-01', 200),
('odin', '2017-04-01', 300),
('odin', '2017-05-01', 400),
('thor', '2017-03-01', 400),
('thor', '2017-04-01', 300),
('thor', '2017-05-01', 500);


SELECT employee, SUM(sale) FROM sales 
GROUP BY employee;

SELECT employee, date, sale, SUM(sale) OVER (PARTITION BY employee) AS sum FROM sales;

-- ORDER BY (sth) "frame_unit" BETWEEN "frame_start" AND "frame_end"
-- frame_unit : ROWS (row thực tế) hoặc RANGE (row logic - 1 row là 1 giá trị ví dụ 100 200 200 thì có 2 row)
-- frame_start và frame_end có thể là :
--         🔰CURRENT ROW (row hiện tại), 
--         🔰UNBOUNDED PRECEDING (tất cả row trước), 
--         🔰UNBOUNDED FOLLOWING (tất cả row sau), 
--         🔰n PRECEDING (n row trước), 
--         🔰n FOLLOWING (n row sau).
-- Chú ý: bắt buộc phải kèm theo "ORDER BY" khi dùng window frame nếu không SQL ko có cách nào biết row nào trước, row nào sau để tạo ra frame
SELECT employee, date, sale,
  SUM(sale) OVER (
    ORDER BY date ROWS
    BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW
  ) AS sum_sales
FROM sales;

|--------------------------------------------------|
|                ✅ KỂT QUẢ ✅                    |
| employee  | Date       | Sale | sum_sales        |
|-----------|------------|------|------------------|
| odin      | 2017-03-01 | 200  | 200              |
| thor      | 2017-03-01 | 400  | 600              |
| odin      | 2017-04-01 | 300  | 900              |
| thor      | 2017-04-01 | 300  | 1200             |
| odin      | 2017-05-01 | 400  | 1600             |
| thor      | 2017-05-01 | 500  | 2100             |
|--------------------------------------------------|



-- ===================================================
--                    ROW_NUMBER()
-- ===================================================
CREATE TABLE Employees (
    EmployeeID INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 7000),
(3, 'Charlie', 'HR', 5500),
(4, 'David', 'IT', 8000),
(5, 'Eve', 'Finance', 6000);

SELECT * FROM employees;

-- Cột ROW_NUMBER(): Mỗi hàng được gán một số thứ tự (RowNum) theo tiêu chí sắp xếp.
-- Câu lệnh OVER(): giữ nguyên tất cả các hàng mà không cần gộp nhóm (grouping)
-- PARTITION BY Department: Chia dữ liệu thành các nhóm nhỏ dựa trên giá trị của cột Department.
-- Trong ví dụ này, các nhóm nhỏ là:
-- 🔰Nhóm HR (Charlie, Alice)
-- 🔰Nhóm IT (David, Bob)
-- 🔰Nhóm Finance (Eve)
SELECT 
	EmployeeID,
    Name,
    Department,
    Salary,
    ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RowNum
FROM Employees;

|--------------------------------------------------------|
|                       ✅ KỂT QUẢ ✅                   |
| EmployeeID | Name     | Department | Salary   | RowNum |
|------------|----------|------------|----------|--------|
| 5          | Eve      | Finance    | 6000.00  | 1      |
| 3          | Charlie  | HR         | 5500.00  | 1      |
| 1          | Alice    | HR         | 5000.00  | 2      |
| 4          | David    | IT         | 8000.00  | 1      |
| 2          | Bob      | IT         | 7000.00  | 2      |
|--------------------------------------------------------|



-- ===========================================================
--  SỰ KHÁC NHAU GIỮ - ROW_NUMBER() - RANK() - DENSE_RANK()
-- ===========================================================
WITH tempp AS (
  SELECT 1 AS id, 'tai' AS name
  UNION ALL 
  SELECT 2 AS id, 'tai' AS name
  UNION ALL 
  SELECT 4 AS id, 'tai' AS name
  UNION ALL 
  SELECT 5 AS id, 'duy' AS name
  UNION ALL 
  SELECT 9 AS id, 'duy' AS name
  UNION ALL 
  SELECT 10 AS id, 'tai' AS name
  UNION ALL 
  SELECT 11 AS id, 'bao' AS name
  UNION ALL 
  SELECT 12 AS id, 'bao' AS name
  UNION ALL 
  SELECT 15 AS id, 'cuong' AS name
  UNION ALL 
  SELECT 16 AS id, 'toai' AS name
)
SELECT 
  name,
  ROW_NUMBER()  OVER (PARTITION BY name ORDER BY name) AS RowNum_partition,
  ROW_NUMBER() 	OVER (ORDER BY name) AS row_number,
  RANK() 		    OVER (ORDER BY name) AS rank,
  DENSE_RANK() 	OVER (ORDER BY name) AS dense_rank
FROM tempp;

-- ✅ROW_NUMBER():  không quan tâm giá trị trùng.
-- ✅RANK():        bỏ qua thứ hạng khi có giá trị trùng.
-- ✅DENSE_RANK():  không bỏ qua thứ hạng, giữ liên tục.
|------------------------------------------------------------|
|                       ✅ KỂT QUẢ ✅                       |
| name   | RowNum_partition | row_number | rank | dense_rank |
|--------|------------------|------------|------|------------|
| bao    | 1                | 1          | 1    | 1          |
| bao    | 2                | 2          | 1    | 1          |
| cuong  | 1                | 3          | 3    | 2          |
| duy    | 1                | 4          | 4    | 3          |
| duy    | 2                | 5          | 4    | 3          |
| tai    | 1                | 6          | 6    | 4          |
| tai    | 2                | 7          | 6    | 4          |
| tai    | 3                | 8          | 6    | 4          |
| tai    | 4                | 9          | 6    | 4          |
| toai   | 1                | 10         | 10   | 5          |
|------------------------------------------------------------|







SELECT 
	EmployeeID,
    Name,
    Department,
    Salary,
 	  ROW_NUMBER()  OVER (PARTITION BY Department ORDER BY Salary ASC) AS RowNum_1,
 	  ROW_NUMBER()  OVER (ORDER BY Department ASC) AS RowNum_2,
	  RANK() 		    OVER (ORDER BY Department ASC) AS Rank,
	  DENSE_RANK()  OVER (ORDER BY Department ASC) AS DenseRank
FROM Employees;

|--------------------------------------------------------------------------------------|
|                                  ✅ KỂT QUẢ ✅                                      |
| ID  | Name    | Department | Salary  | row_number1 | row_number2 | rank | dense_rank |
|-----|---------|------------|---------|-------------|-------------|------|------------|
| 5   | Eve     | Finance    | 6000.00 | 1           | 1           | 1    | 1          |
| 1   | Alice   | HR         | 5000.00 | 1           | 2           | 2    | 2          |
| 3   | Charlie | HR         | 5500.00 | 2           | 3           | 2    | 2          |
| 2   | Bob     | IT         | 7000.00 | 1           | 4           | 4    | 3          |
| 4   | David   | IT         | 8000.00 | 2           | 5           | 4    | 3          |
|--------------------------------------------------------------------------------------|
