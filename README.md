# SQL Practice Solutions

## Project Overview
This repository contains solutions to SQL questions from [sql-practice.com](https://sql-practice.com) to database `Hospital`. The questions are categorized into three difficulty levels: easy, medium, and hard. Each file contains SQL queries that address specific challenges and tasks related to database management.

## File Structure
- `Questions-easy.sql`: Contains solutions to easy-level SQL questions.
- `Questions-medium.sql`: Contains solutions to medium-level SQL questions.
- `Questions-hard.sql`: Contains solutions to hard-level SQL questions.

## How to Use
You can copy the SQL queries from the `.sql` files and run them in your SQL environment to practice the queries. Make sure to set up the necessary tables and data as per the problem requirements.

## Example Query (from Questions-easy.sql)
```sql
-- Q1. Show first name, last name, and gender of patients whose gender is 'M'
SELECT first_name, last_name, gender 
FROM patients
WHERE gender = 'M';
```

## Note
There can be more than one solution to the given questions, so feel free to choose the approach that works best for you. Everyone’s coding style is different, and that is perfectly fine! 
> If you feel that the given solution can be customized or if you have a better solution and want to show it off to me, feel free to reach out!