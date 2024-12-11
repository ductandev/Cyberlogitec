-- =============================================
-- ⭐ BÀI 1: viết function tìm số bé thứ "n"
-- Vd: 
-- data hiện tại là 1 - 5 - 7 - 10 - 12
-- Số nhỏ nhất thứ 2 là 5
-- Số nhỏ nhất thứ 3 là 7
-- Số nhỏ nhất thứ 4 là 10
-- =============================================

-- ✅ LỜI GIẢI BÀI TẬP
-- Ví dụ: Giả sử bảng tempp có các giá trị:
-- number
-- 1
-- 5
-- 7
-- 10
-- 12
-- Khi subquery được thực hiện cho từng t1.number:

-- Nếu t1.number = 1:  COUNT(*) đếm các giá trị ≤ 1  → Kết quả: 1.
-- Nếu t1.number = 5:  COUNT(*) đếm các giá trị ≤ 5  → Kết quả: 2.
-- Nếu t1.number = 7:  COUNT(*) đếm các giá trị ≤ 7  → Kết quả: 3.
-- Nếu t1.number = 10: COUNT(*) đếm các giá trị ≤ 10 → Kết quả: 4.
-- Nếu t1.number = 12: COUNT(*) đếm các giá trị ≤ 12 → Kết quả: 5.


WITH tempp AS (
	SELECT 1 AS number
	UNION 
	SELECT 7 AS number
	UNION 
	SELECT 5 AS number
	UNION 
	SELECT 10 AS number
	UNION 
	SELECT 12 AS number
)

-- ✅ cách 4:
SELECT number FROM tempp t1
WHERE (
	SELECT COUNT(*)
	FROM tempp t2
	WHERE t2.number <= t1.number
) = :a ;


-- SELECT *
-- FROM tempp t1
-- WHERE exists (
-- 	(SELECT count(*)
-- 	FROM tempp t2
-- 	WHERE t2.number <= t1.number) = :a
-- );


-- ✅ cách 3:
ranked_numbers AS (
	SELECT number, ROW_NUMBER() OVER (ORDER BY number ASC) AS row_rank
	FROM tempp
)
SELECT number
FROM ranked_numbers
WHERE row_rank = :a;

select number from tempp
order by number asc;


-- ✅ Cách 2:
SELECT MAX(number)
FROM
	(select number from tempp
	order by number ASC
	limit :a);


-- ✅ Cách 1:
SELECT number from tempp
order by number asc
LIMIT 1 OFFSET (:a - 1);






-- ===============================================================================
-- ⭐ BÀI 2: Viết câu Query tìm những name được lặp lại "n" lần liên tiếp
-- Với data cho trước như sau và id không liên tiếp
-- tai
-- tai
-- tai
-- duy
-- duy
-- tai
-- bao
-- bao
-- cuong
-- toai

-- nhập 1 kết quả lần lượt gồm: tai, duy, bao, cuong, toai 
-- nhập 2 kết quả lần lượt gồm: tai, duy, bao 
-- nhập 3 kết quả lần lượt gồm: tai
-- ===============================================================================
with tempp as (
  select 1 as id, 'tai' as name
  union all 
  select 2 as id, 'tai' as name
  union all 
  select 4 as id, 'tai' as name
  union all 
  select 5 as id, 'duy' as name
  union all 
  select 9 as id, 'duy' as name
  union all 
  select 10 as id, 'tai' as name
  union all 
  select 11 as id, 'bao' as name
  union all 
  select 12 as id, 'bao' as name
  union all 
  select 15 as id, 'cuong' as name
  union all 
  select 16 as id, 'toai' as name
)
select * from tempp;



-- ✅ Cách 1:
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
),
data_with_prev AS (
  SELECT 
    t1.id,
    t1.name,
    (
      SELECT t2.name
      FROM tempp t2
      WHERE t2.id < t1.id
      ORDER BY t2.id DESC
      LIMIT 1
    ) AS prev_name -- Tìm `name` của dòng trước đó (nếu có)
  FROM tempp t1
),
grouped_data AS (
  SELECT 
    id,
    name,
    CASE 
      WHEN name = prev_name THEN NULL -- Cùng nhóm nếu `name` giống dòng trước
      ELSE id -- Bắt đầu nhóm mới khi `name` thay đổi
    END AS group_start
  FROM data_with_prev
),
filled_groups AS (
  SELECT 
    t1.id,
    t1.name,
    COALESCE(
      (SELECT MAX(t2.group_start)
       FROM grouped_data t2
       WHERE t2.group_start IS NOT NULL AND t2.id <= t1.id),
      t1.id
    ) AS grp -- Gán nhóm cho mỗi dòng dựa trên `group_start` gần nhất
  FROM grouped_data t1
),
final_group AS (
  SELECT 
    name,
    grp,
    COUNT(*) AS cnt
  FROM filled_groups
  GROUP BY name, grp
)
SELECT DISTINCT name
FROM final_group
WHERE cnt >= :a -- Thay `n` mong muốn tại đây
ORDER BY name;


-- ✅ Cách 2: DÙNG SQL WINDOS FUNCTION
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
),
group_with_seq AS (
  SELECT 
    id,
    name,
    -- Tăng nhóm khi giá trị `name` thay đổi so với hàng trước đó
    ROW_NUMBER() OVER (ORDER BY id) 
      - ROW_NUMBER() OVER (PARTITION BY name ORDER BY id) AS grp
  FROM tempp
),
final_group AS (
  SELECT 
    name,
    grp,
    COUNT(*) AS cnt
  FROM group_with_seq
  GROUP BY name, grp
)
SELECT DISTINCT name
FROM final_group
WHERE cnt >= :a -- Thay "n" mong muốn ở đây
ORDER BY name;










-- =======================================================
--        Bài giải mẫu để hiểu và làm bài tập
-- =======================================================
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

SELECT 
	EmployeeID,
    Name,
    Department,
    Salary,
 	ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS RowNum_1,
 	ROW_NUMBER() OVER (ORDER BY Department ASC) AS RowNum_2,
	RANK() 		 OVER (ORDER BY Department ASC) AS Rank,
	DENSE_RANK() OVER (ORDER BY Department ASC) AS DenseRank
FROM Employees;



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
  RANK() 		OVER (ORDER BY name) AS rank,
  DENSE_RANK() 	OVER (ORDER BY name) AS dense_rank
FROM tempp;



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
SELECT name, RowNum_partition
FROM (
  SELECT name, ROW_NUMBER() OVER (PARTITION BY name ORDER BY name) AS RowNum_partition 
  FROM tempp
) subquery
GROUP BY name, RowNum_partition
HAVING RowNum_partition = :a;


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
SELECT *, count(dense_rank) as appear
FROM (
	SELECT name, DENSE_RANK() OVER (ORDER BY name) AS dense_rank FROM tempp
)
group by name, DENSE_RANK
HAVING count(dense_rank) >= :a;






