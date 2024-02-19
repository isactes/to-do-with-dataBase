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