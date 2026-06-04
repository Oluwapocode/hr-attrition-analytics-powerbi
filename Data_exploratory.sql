CREATE DATABASE hr_attrition;
USE hr_attrition;
select * from employee_attrition
limit 10;

-- Total Employee
select count(*) as total_employees
from employee_attrition;

-- Show Tables
Describe employee_attrition;

-- Names of Department in the Department column
select distinct Department
from employee_attrition;

-- Job roles
select distinct JobRole
from employee_attrition;