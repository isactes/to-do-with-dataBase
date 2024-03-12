-- Questions: Show first name, last name, and gender of patients whose gender is 'M'
-- Solution:
SELECT
  first_name,
  last_name,
  gender
FROM patients
WHERE gender = 'M';

-- Questions: Show first name and last name of patients who does not have allergies. (null)
-- Solution:
select
  first_name,
  last_name
from patients
where allergies is null

-- Questions: Show first name of patients that start with the letter 'C'
-- Solution:
SELECT first_name
FROM patients
where first_name like 'C%'

-- Questions: Show first name and last name of patients that weigh within the range of 100 to 120 (inclusive)
-- Solution:
SELECT
  first_name,
  last_name
FROM patients
where weight between 100 AND 120

-- Questions: Update the patients table for the allergies column. If the patient's allergies are null, replace it with 'NKA'
-- Solution:
update patients
set allergies = 'NKA'
where allergies is null

-- Questions: Show first name and last name concatenated into one column to show their full name
-- Solution:
select
  concat(first_name, ' ', last_name) as Full_name
from patients


-- Questions: Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON'
-- Solution:
select
  first_name,
  last_name,
  province_name
from patients
  join province_names on province_names.province_id = patients.province_id;

-- Questions: Show how many patients have a birth_date with 2010 as the birth year.
-- Solution:
SELECT count(*)
FROM patients
where year(birth_date) = 2010

-- Questions: Show the first_name, last_name, and height of the patient with the greatest height.
-- Solution:
SELECT
  first_name,
  last_name,
  MAX(height) as height
FROM patients

-- Questions: Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
-- Solution:
select *
from patients
where
  patient_id in (1, 45, 534, 879, 1000)

-- Questions: Show the total number of admissions
-- Solution:
select count(*)
from admissions

-- Questions: Show all the columns from admissions where the patient was admitted and discharged on the same day.
-- Solution:
select *
from admissions
where admission_date = discharge_date

-- Questions: Show the patient id and the total number of admissions for patient_id 579.
-- Solution:
select patient_id, count()
from admissions
where patient_id = 579

-- Questions: Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
-- Solution:
select distinct(city)
from patients
where province_id = 'NS'

-- Questions: Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
-- Solution:
select
  first_name,
  last_name,
  birth_date
from patients
where height > 160 and weight > 70

-- Questions: Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
-- Solution:
select
  first_name,
  last_name,
  allergies
from patients
where allergies is not null and city = 'Hamilton'




