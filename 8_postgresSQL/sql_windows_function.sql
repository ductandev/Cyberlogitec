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


SELECT employee, date, sale,
  SUM(sale) OVER (
    ORDER BY date ROWS
    BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW
  ) AS sum_sales
FROM sales;





