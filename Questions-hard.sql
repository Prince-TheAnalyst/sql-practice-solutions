
--Show all columns from table patients
SELECT *
FROM
  patients 
  
  
--Q1. Show all of the patients grouped into weight groups.
  --Show the total amount of patients in each weight group.
  --Order the list by the weight group decending.
select
  (weight / 10) * 10 as weight_group,
  count(*) as total_patients
from patients
group by weight_group
order by
  weight_group desc 
  
  
--Q2. Show patient_id, weight, height, isObese from the patients table.
  --Display isObese as a boolean 0 or 1.
  --Obese is defined as weight(kg)/(height(m)2) >= 30.
  --weight is in units kg.
  --height is in units cm.
SELECT
  patient_id,
  weight,
  height,
  CASE
    WHEN (
      weight / (power(cast(height as float) / 100, 2))
    ) >= 30 THEN 1
    ELSE 0
  END AS isObese
FROM patients;

--Q3. Show patient_id, first_name, last_name, and attending doctor's specialty.
--Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
--Check patients, admissions, and doctors tables for required information.
select
  pat.patient_id,
  pat.first_name,
  pat.last_name,
  doc.specialty
from patients pat
  join admissions adm on pat.patient_id = adm.patient_id
  join doctors doc on adm.attending_doctor_id = doc.doctor_id
where
  adm.diagnosis = 'Epilepsy'
  and doc.first_name = 'Lisa'
  
  
--Q4.  All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
  --The password must be the following, in order:
  --1. patient_id
  --2. the numerical length of patient's last_name
  --3. year of patient's birth_date
select
  pat.patient_id,
  concat(
    pat.patient_id,
    len(pat.last_name),
    year(pat.birth_date)
  ) as temp_password
from patients pat
  join admissions adm on pat.patient_id = adm.patient_id
group by pat.patient_id 


--Q5. Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
  --Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.
select
  has_insurance,
  sum(will_cost) as cost_after_insurance
from (
    select
      patient_id,
      case
        when patient_id % 2 = 0 then 'Yes'
        else 'NO'
      end as has_insurance,
      case
        when patient_id % 2 = 0 THEN 10
        ELSE 50
      end as will_cost
    from admissions
  )
group by has_insurance


--Q6. Show the provinces that has more patients identified as 'M' than 'F'. Must only shows full provience_name
select prov.province_name
from patients pat
  join province_names prov on pat.province_id = prov.province_id
group by province_name
having sum(gender = 'M') > sum(gender = 'F')

--Q7. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
  -- First_name contains an 'r' after the first two letters.
  -- Identifies their gender as 'F'
  -- Born in February, May, or December
  -- Their weight would be between 60kg and 80kg
  -- Their patient_id is an odd number
  -- They are from the city 'Kingston'
select *
from patients
where
  first_name like '__r%'
  and gender = 'F'
  and month(birth_date) in (2, 5, 12)
  and weight between 60 and 80
  and patient_id % 2 = 1
  and city = 'Kingston'


--Q8. Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
select
  concat(
    round(sum(gender = 'M') * 100.0 / count(*), 2),
    '%'
  ) as percent_of_male_patients
from patients


--Q9. For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
select
  admission_date,
  count(*) as admission_day,
  count(*) - lag(count(*), 1) over(
    order by
      admission_date
  ) as admission_count_change
from admissions
group by admission_date


--Q10. Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
select province_name
from province_names
order by
  case
    when province_name = 'Ontario' then 0
    else 1
  end,
  province_name


--Q11. We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
select
  doc.doctor_id,
  concat(doc.first_name, ' ', doc.last_name) as full_name,
  doc.specialty,
  year(adm.admission_date) as admission_year,
  count(*) as total_admissions
from doctors doc
  join admissions adm on doc.doctor_id = adm.attending_doctor_id
group by
  doc.doctor_id,
  admission_year