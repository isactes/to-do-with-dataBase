-- Questions: Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending. For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
-- Solution:
SELECT
    FLOOR(weight / 10) * 10 AS weight_group,
    COUNT(*) AS total_patients
FROM
    patients
GROUP BY
    FLOOR(weight / 10)
ORDER BY
    weight_group DESC;

-- Questions: Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m)2) >= 30. weight is in units kg.height is in units cm.
-- Solution:
SELECT 
    patient_id, 
    weight, 
    height, 
    CASE 
        WHEN weight / POWER(height / 100.0, 2) >= 30 THEN 1
        else 0
    END AS isObese
FROM 
    patients;

-- Questions: Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa' Check patients, admissions, and doctors tables for required information. 
-- Solution:
SELECT
  patients.patient_id,
  patients.first_name,
  patients.last_name,
  doctors.specialty
FROM patients
  JOIN admissions ON  patients.patient_id = admissions.patient_id
  JOIN doctors  ON admissions.attending_doctor_id = doctors.doctor_id
WHERE admissions.diagnosis = 'Epilepsy'
  AND doctors.first_name = 'Lisa';


-- Questions: All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
--The password must be the following, in order:
--1. patient_id
--2. the numerical length of patient's last_name
--3. year of patient's birth_date
-- Solution:
select
	DISTINCT
  patients.patient_id,
  concat(
    patients.patient_id,
    len(patients.last_name),
    year(patients.birth_date)
  ) as password
from patients
join admissions on patients.patient_id = admissions.patient_id

-- Questions: Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance. Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.
-- Solution:
SELECT
  has_insurance,
  CASE
    WHEN has_insurance = 'Yes' THEN COUNT(has_insurance) * 10
    ELSE count(has_insurance) * 50
  END AS cost_after_insurance
FROM (
    SELECT
      CASE
        WHEN patient_id % 2 = 0 THEN 'Yes'
        ELSE 'No'
      END AS has_insurance
    FROM admissions
  )
GROUP BY has_insurance

-- Questions:_ We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- First_name contains an 'r' after the first two letters.
-- Identifies their gender as 'F'
-- Born in February, May, or December
-- Their weight would be between 60kg and 80kg
-- Their patient_id is an odd number
-- They are from the city 'Kingston'
-- Solution:
select *
from patients
where
  first_name like '__r%'
  and gender = 'F'
  and weight between 60 and 80
  and city = 'Kingston'

-- Questions: Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
-- Solution:
SELECT CONCAT(
    ROUND(
      (
        SELECT COUNT(*)
        FROM patients
        WHERE gender = 'M'
      ) / CAST(COUNT(*) as float),
      4
    ) * 100,
    '%'
  ) as percent_of_male_patients
FROM patients;

-- Questions: For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
-- Solution: 
select
  admission_date,
  count(admission_date) as admission_day,
  count(admission_date) - lag(count(admission_date)) over(order by admission_date) as admissions_count_change
from admissions
group by admission_date

-- Questions:Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
-- Solution: 
SELECT province_name
FROM province_names
ORDER BY
  (
    CASE
      WHEN province_name = 'Ontario' THEN 0
      ELSE province_name
    END
  );

-- Questions:We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
-- Solution: 
select
  doctors.doctor_id,
  concat(
    doctors.first_name,
    ' ',
    doctors.last_name
  ) as doctor_name,
  doctors.specialty,
  year(admissions.admission_date) as year_ano,
  count(admissions.admission_date) as total_admin
from doctors
  left join admissions on doctors.doctor_id = admissions.attending_doctor_id
where
  year(admissions.admission_date) = [year_ano]
group by
  doctors.doctor_id,
  year_ano



