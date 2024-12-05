-- =======================================================
-- 
-- =======================================================
select city, count(*) as num_patients from patients
group by city
ORDER BY num_patients DESC, city asc;

-- =======================================================
-- Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
-- =======================================================
select city, count(*) as num_patients from patients
group by city
ORDER BY num_patients DESC, city asc;

-- =======================================================
-- 
-- =======================================================
select allergies, count(*) as total_diagnosis from patients
where allergies is not null
group by allergies
order by total_diagnosis desc;

SELECT
  allergies,
  count(*)
FROM patients
WHERE allergies NOT NULL
GROUP BY allergies
ORDER BY count(*) DESC

-- =======================================================
-- 
-- =======================================================
SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE
  YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;

SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE
  birth_date >= '1970-01-01'
  AND birth_date < '1980-01-01'
ORDER BY birth_date ASC


-- =======================================================
-- 
-- =======================================================
select province_id, 
	sum(height) as sum_height  
from patients 
group by province_id
having sum_height >= 7000


-- =======================================================
-- 
-- =======================================================
select 
	(max(weight) - min(weight)) as weight_delta
from patients
where last_name = 'Maroni'


-- =======================================================
-- 
-- =======================================================
SELECT
  DAY(admission_date) AS day_number,
  COUNT(*) AS number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC


-- =======================================================
-- 
-- =======================================================
select * from admissions
where patient_id = 542
group by patient_id
having max(admission_date);

SELECT * FROM admissions
WHERE patient_id = 542
ORDER BY admission_date DESC
LIMIT 1

SELECT *
FROM admissions
GROUP BY patient_id
HAVING
  patient_id = 542
  AND max(admission_date)


-- =======================================================
-- 
-- =======================================================
SELECT
  patient_id,
  attending_doctor_id,
  diagnosis
FROM admissions
WHERE
  (
    attending_doctor_id IN (1, 5, 19)
    AND patient_id % 2 != 0
  )
  OR 
  (
    attending_doctor_id LIKE '%2%'
    AND len(patient_id) = 3
  )


-- =======================================================
-- 
-- =======================================================
SELECT
  first_name,
  last_name,
  count(*) as admissions_total
from admissions a
  join doctors ph on ph.doctor_id = a.attending_doctor_id
group by attending_doctor_id


-- =======================================================
-- 
-- =======================================================
select d.doctor_id, 
		d.first_name || ' ' || d.last_name as full_name,
        min(admission_date) as first_admission_date,
        MAX(admission_date) as last_admission_date
from doctors d
join admissions a
on d.doctor_id = a.attending_doctor_id
group by a.attending_doctor_id;



-- =======================================================
-- 
-- =======================================================
SELECT
  province_name,
  COUNT(*) as patient_count
FROM patients pa
  join province_names pr on pr.province_id = pa.province_id
group by pr.province_id
order by patient_count desc;



-- =======================================================
-- 
-- =======================================================
SELECT 
	pa.first_name || ' ' || pa.last_name as patient_name,
    ad.diagnosis,
	do.first_name || ' ' || do.last_name as doctor_name
FROM patients pa
join admissions ad
ON pa.patient_id = ad.patient_id
join doctors do
on do.doctor_id = ad.attending_doctor_id


-- =======================================================
-- 
-- =======================================================
select
  first_name,
  last_name,
  count(*) as num_of_duplicates
from patients
group by
  first_name,
  last_name
having count(*) > 1


-- =======================================================
-- 
-- =======================================================
select
select
    concat(first_name, ' ', last_name) AS 'patient_name', 
    ROUND(height / 30.48, 1) as 'height "Feet"', 
    ROUND(weight * 2.205, 0) AS 'weight "Pounds"', birth_date,
CASE
	WHEN gender = 'M' THEN 'MALE' 
  ELSE 'FEMALE' 
END AS 'gender_type'
from patients

-- =======================================================
-- 
-- =======================================================
SELECT
  patients.patient_id,
  first_name,
  last_name
from patients
where patients.patient_id not in (
    select admissions.patient_id
    from admissions
  )

SELECT
  patients.patient_id,
  first_name,
  last_name
from patients
  left join admissions 
  on patients.patient_id = admissions.patient_id
where admissions.patient_id is NULL



































