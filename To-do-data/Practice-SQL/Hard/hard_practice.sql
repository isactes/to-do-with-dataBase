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
