--show all the data form table patients
SELECT * FROM patients

--Q1. Show unique birth years from patients and order them by ascending.
Select 
	distinct year(birth_date) as unique_birth_years
from
	patients
order by unique_birth_years

--Q2. Show unique first names from the patients table which only occurs once in the list.

select first_name
from patients
group by first_name
having count(first_name) = 1


--Q3. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select 
	patient_id, 
    first_name
from
	patients
where first_name like 's____%s'

--Q4. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
select 
	patients.patient_id, first_name, last_name
from patients
	join admissions on patients.patient_id = admissions.patient_id
where diagnosis = 'Dementia'

--Q5. Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
select
	first_name
from
	patients
order by 
	len(first_name), 
    first_name

--Q6. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select 
	sum(gender = 'M') as male_count, 
    sum(gender = 'F') as female_count
from patients

--Q7. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
select 
	first_name,
    last_name,
    allergies
from 
	patients
where allergies in ('Penicillin', 'Morphine')
order by allergies, first_name, last_name

--Q8. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select
	patient_id,
    diagnosis
from	
	admissions
group by patient_id, diagnosis
having count(diagnosis) > 1

--Q9. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
select 
	city, 
    count(city) as total_patients
from 
	patients
group by 	
	city
order by 
	total_patients desc, 
    city asc
    
--Q10. Show first name, last name and role of every person that is either patient or doctor. The role are either "patient" or "Doctor"
select 
	first_name,
    last_name,
    'patient' as role
from 
	patients
union all
select first_name,
	last_name,
    'doctor' as role
from 
	doctors
    
--Q11. Show all allergies ordered by popularity. Remove NULL values from query.
select allergies, count(allergies) as total_diagnosis
from patients
where allergies is not null
group by allergies
order by total_diagnosis desc


--Q12. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select
	first_name,
    last_name,
    birth_date
from
	patients
where year(birth_date) between 1970 and 1979
order by birth_date 

--Q13. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane
select
	concat(upper(last_name),',',lower(first_name)) as new_full_name
from patients
order by
	first_name desc
    
    
--Q14. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than equal to 7,000.
select
	province_id,
   	sum(height) as total_sum
from patients
group by province_id
having total_sum >= 7000

--Q15. Show the difference between the largest weight and smallest weight for patients with teh last name 'Maroni'
select 
	max(weight) - min(weight) as weight_difference
from patients
where 
	last_name = 'Maroni'
    
--Q16. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select distinct day(admission_date) days, count(*) as occurred_admissions
from admissions
group by day(admission_date)
order by occurred_admissions desc


--Q17. Show all columns for patient_id 542's most recent admission_date.
select * 
from admissions
where patient_id = 542
order by admission_date desc
limit 1

--Q18. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
--1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
--2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

select
	patient_id,
    attending_doctor_id,
    diagnosis
from admissions
where (patient_id%2=1 and attending_doctor_id in (1, 5, 19))
	or (attending_doctor_id like '%2%' and len(patient_id) is 3)
    
    
--Q19. Show first_name, last_name, and the total number of admissions attended for each doctor.
--Every admission has been attended by a doctor.
select 
	first_name, last_name, count(*) as admissions_total
from doctors doc
join admissions ad on doc.doctor_id = ad.attending_doctor_id
group by first_name

--Q20. For each doctor, display their id, full name, and the first and last admission date they attended.
select
	doctor_id,
    concat(first_name,' ',last_name) as fullname,
    min(admission_date) as first_admission_date, max(admission_date) as last_admission_date
from
	doctors doc 
join admissions adm on doc.doctor_id = adm.attending_doctor_id
group by first_name

--Q21. Display the total amount of patients for each province. Order by descending.

select 
	province_name, count(*) total_patients
from province_names pn
join patients p on pn.province_id=p.province_id
group by pn.province_name
order by total_patients desc


--Q22. For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
select concat(p.first_name,' ',p.last_name) as fullname,
	ad.diagnosis,
    concat(d.first_name,' ',d.last_name)
from
	patients p
join admissions ad on p.patient_id = ad.patient_id
join doctors d on ad.attending_doctor_id = d.doctor_id

--Q23. display the first name, last name and number of duplicate patients based on their first name and last name.
select
	first_name,
    last_name,
    count(first_name) as duplicate_patients
from
	patients
group by first_name, last_name
having duplicate_patients > 1

--Q24. Display patient's full name,
--height in the units feet rounded to 1 decimal,
--weight in the unit pounds rounded to 0 decimals,
--birth_date, gender non abbreviated.

--Convert CM to feet by dividing by 30.48.
--Convert KG to pounds by multiplying by 2.205.

select
	first_name||' '||last_name fullname,
    round(height/30.48,1) height_in_cm,
    round(weight*2.205,0) weight_in_pounds,
    birth_date,
    case
    	when gender = 'M' then 'Male'
        else 'Female'
    end
    	as gender
from
	patients
    
--Q25. Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
select
	patients.patient_id,
    first_name,
    last_name
from
	patients 
left join admissions on patients.patient_id=admissions.patient_id
where admissions.patient_id is null