-- Questions: Show unique birth years from patients and order them by ascending.
-- Solution:
select distinct(year(birth_date))
from patients
order by birth_date asc


-- Questions: Show unique first names from the patients table which only occurs once in the list. For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
-- Solution:
select first_name
from patients
group by first_name
having count(first_name) = 1

-- Questions: Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
-- Solution:
select
  patient_id,
  first_name
from patients
WHERE first_name LIKE 's____%s';

-- Questions: Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.
-- Solution:
select
  patients.patient_id,
  patients.first_name,
  patients.last_name
from patients
  join admissions on admissions.patient_id = patients.patient_id
WHERE diagnosis = 'Dementia'

-- Questions: Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
-- Solution:
SELECT first_name 
FROM patients
order by LENGTH(first_name), first_name;

-- Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
-- Solution:
SELECT
  sum(gender = "M") as total_Male,
  sum(gender = "F") as total_Fale
FROM patients


-- Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
-- Solution:
select
  first_name,
  last_name,
  allergies
from patients
where
  allergies in ('Penicillin', 'Morphine')
order by
  allergies asc,
  first_name asc,
  last_name asc

-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
-- Solution:
SELECT
  patient_id,
  diagnosis
FROM admissions
group by
  patient_id,
  diagnosis
having count(*) > 1

-- Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
-- Solution:
select
  city,
  count(city) as totlsa
from patients
group by city
order by
  totlsa desc,
  city asc

-- Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
-- Solution:
select
  city,
  count(city) as totlsa
from patients
group by city
order by
  totlsa desc,
  city asc

-- Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
-- Solution:
select
  first_name,
  last_name,
  'Patient' as role
from patients
union all
select
  first_name,
  last_name,
  'Doctor' as role
from doctors

-- Show all allergies ordered by popularity. Remove NULL values from query.
-- Solution:
SELECT
  allergies,
  count(*) as Total_sas
FROM patients
where allergies is not null
GROUP BY allergies
ORDER BY Total_sas DESC;

-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
-- Solution:
SELECT
  first_name,
  last_name,
  birth_date
FROM patients
where
  year(birth_date) between 1970 and 1979
order by Date(birth_date) asc

-- We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane
-- Solution:
SELECT
  concat(upper(last_name), ',', lower(first_name)) as name_full
FROM patients
order by first_name desc


-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
-- Solution:
SELECT
  province_id,
  SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING sum_height >= 7000
ORDER BY sum_height;


-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
-- Solution:
select
  (Max(weight) - Min(weight)) as weight_we
from patients
where last_name = 'Maroni'

-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
-- Solution:
select
  day(admission_date) as days_s,
  count(admission_date) as count_s
from admissions
group by days_s
order by count_s desc

-- Show all columns for patient_id 542's most recent admission_date.
-- Solution:
SELECT *
FROM admissions
WHERE patient_id = 542 AND admission_date = (
    SELECT MAX(admission_date)
    FROM admissions
    WHERE patient_id = 542
  );


-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
-- Solution:
SELECT
  patient_id,
  attending_doctor_id,
  diagnosis
FROM admissions
WHERE
  (
    patient_id % 2 <> 0
    AND attending_doctor_id IN (1, 5, 19)
  )
  OR (
    attending_doctor_id LIKE '%2%'
    AND LENGTH(patient_id) = 3
  );
-- Show first_name, last_name, and the total number of admissions attended for each doctor. Every admission has been attended by a doctor.
-- Solution:
select
  doctors.first_name,
  doctors.last_name,
  count(admissions.patient_id) as admin_total
from doctors
  join admissions on doctors.doctor_id = admissions.attending_doctor_id
group by
  doctors.doctor_id,
  doctors.first_name,
  doctors.last_name;

-- For each doctor, display their id, full name, and the first and last admission date they attended.
-- Solution:
select
  doctors.doctor_id,
  concat(
    doctors.first_name,
    ' ',
    doctors.last_name
  ) as full_name,
  min(admissions.admission_date) as first_admin,
  max(admissions.admission_date) as last_admin
from doctors
  join admissions on doctors.doctor_id = admissions.attending_doctor_id
group by
  doctors.doctor_id,
  doctors.first_name,
  doctors.last_name


-- Display the total amount of patients for each province. Order by descending.
-- Solution:
SELECT
  province_names.province_name,
  COUNT(*) AS total_patients
FROM province_names
  JOIN patients ON patients.province_id = province_names.province_id
GROUP BY province_names.province_name
ORDER BY total_patients DESC;

-- For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
-- Solution:
SELECT
  concat(
    patients.first_name,
    ' ',
    patients.last_name
  ) as name_full,
  admissions.diagnosis,
  concat(
    doctors.first_name,
    ' ',
    doctors.last_name
  ) as doctor_name
FROM patients
  join admissions on admissions.patient_id = patients.patient_id
  join doctors on doctors.doctor_id = admissions.attending_doctor_id



-- Display the first name, last name and number of duplicate patients based on their first name and last name. Ex: A patient with an identical name can be considered a duplicate.
-- Solution:
select
  first_name,
  last_name,
  count(*) as cous_total
from patients
group by
  first_name,
  last_name
having count(*) > 1

-- Display patient's full name, height in the units feet rounded to 1 decimal, weight in the unit pounds rounded to 0 decimals, birth_date, gender non abbreviated.
-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.
-- Solution:
SELECT
  CONCAT(first_name, ' ', last_name) AS name_full,
  ROUND(height / 30.48, 1) AS height_aa,
  ROUND(weight * 2.205, 0) AS weight_aa,
  birth_date,
  CASE
    WHEN gender = 'M' THEN 'MALE'
    WHEN gender = 'F' THEN 'FEMALE'
  END AS gender
FROM patients;


-- Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.) 
-- Solution:
SELECT
  patients.patient_id,
  patients.first_name,
  patients.last_name
FROM patients
where patient_id not in (
    select patient_id
    from admissions
  )







