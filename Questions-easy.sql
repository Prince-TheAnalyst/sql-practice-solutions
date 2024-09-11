--show all the data in table patients
select * from patients

--Q1. Show first name, last name, and gender of patients whose gender is 'M'
select first_name, last_name, gender 
from patients
where gender = 'M'

--Q2. Show first name and last name of patients who does not have allergies. (null)
select first_name, last_name
from patients
where allergies is null

--Q3. Show first name of patients that start with the letter 'C'
select
	first_name
from patients
where first_name like 'C%'

--Q4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select
	first_name, last_name
from patients
where weight in (100,120)

--Q5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
update patients
set allergies='NKA'
where allergies is null

--Q6. Show first name and last name concatinated into one column to show their full name.
select concat(first_name,' ',last_name) as fullname
from patients

--Q7. Show first name, last name, and the full province name of each patient.
select first_name, last_name, province_name
from patients p 
join province_names pn
on p.province_id = pn.province_id

--Q8. Show how many patients have a birth_date with 2010 as the birth year.
select count(birth_date) as count_birth_date_2010
from patients
where year(birth_date) = 2010

--Q9. Show the first_name, last_name, and height of the patient with greatest height
select
	first_name,
    last_name,
    height
from 
	patients
order by height desc
limit 1

--Q10. Show all columns for patients who have one of the following patients_ids: 1, 45, 534, 879, 1000
select * 
from patients
where patient_id in (1,45,534,879,1000)

--Q11. Show the total number of admissions
select count(*) as total_admissions
from admissions


--Q12. Show all the columns from admissions where the patient was admitted and discharged on the same day
select * 
from admissions
where admission_date = discharge_date

--Q13. Show the patient id and the total number of admissions for patient_id 579
select patient_id, count(*) as total_admissions
from admissions
where patient_id = 579
group by patient_id

--Q14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select city
from patients
where province_id = 'NS'
group by city

--Q15. Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
select 
	first_name,
    last_name,
    birth_date
from 
	patients
where height > 160
and weight > 70


--Q16. Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'

select 
	first_name,
    last_name,
    allergies
from
	patients
where allergies is not null
	and city = 'Hamilton'

