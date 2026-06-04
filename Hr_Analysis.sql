use hr_attrition;

-- How many Employee stayed vs left?
select Attrition, count(*) as employee_count
from employee_attrition
group by Attrition;

-- Percentage of Employees who left
select round(sum(case when Attrition = 'Yes'
	then 1 else 0 end) * 100/count(*),2)
		as attrition_rate from employee_attrition;

-- Which Department loses the most Employees?
select Department,round(sum(case when Attrition = 'Yes'
		then 1 else 0 end) * 100/count(*), 2) as Dept_attrition_rate
        from employee_attrition
        group by Department
        order by dept_attrition_rate DESC;
        
-- Does OverTime Increases Attrition?
select OverTime, round(sum(case when Attrition = 'Yes'
		then 1 else 0 end) * 100/count(*), 2) as Attrition_rate
        from employee_attrition
        group by OverTime;
        
-- which overtime job roles have the highest attrition?
select JobRole, OverTime, round(sum(case when Attrition ='yes'
		then 1 else 0 end) * 100/count(*), 2) as Attrition_rate,
        count(*) as Total_Employees
        from employee_attrition
        where OverTime ='yes'
        group by JobRole, OverTime
        order by Attrition_rate desc;
        
-- Are dissatisfied employees more likely to leave?
select JobSatisfaction, JobRole, round(sum(case when Attrition ='yes'
		then 1 else 0 end) * 100/count(*), 2) as Attrition_rate,
        count(*) as Total_Employees
        from employee_attrition
        group by JobSatisfaction, JobRole
        order by JobSatisfaction asc,
        Attrition_rate desc;

-- Are low earners leaving more?
select JobRole, round(avg(MonthlyIncome)) as Avg_Monthly_Income,
		round(sum(case when Attrition = 'Yes'
		then 1 else 0 end) * 100/count(*), 2) as Attrition_rate,
        count(*) as Total_Employees
from employee_attrition
group by JobRole
order by Avg_Monthly_Income asc;

-- Does poor work-life balance affect retention?
	select WorkLifeBalance, OverTime,
		round(sum(case when Attrition ='No'
		then 1 else 0 end) * 100/count(*), 2) as retention_rate,
        count(*) as Total_Employees
        from employee_attrition
        group by WorkLifeBalance, OverTime
        order by WorkLifeBalance asc,
        OverTime desc;


-- when are employees most likely to leave?
select JobRole,
		case when YearsAtCompany <= 1 then '1. New Hire (0-1 yrs)'
			when YearsAtCompany between 2 and 5 then '2. Mid-Tenure (2-5 yrs)'
            else '3. Senior (6+ yrs)'
            end as Tenure,
		round(sum(case when Attrition ='yes'
						then 1 else 0 end) * 100/count(*), 2) as Attrition_rate,
        count(*) as Total_Employees
from employee_attrition
group by JobRole, 
		case when YearsAtCompany <= 1 then '1. New Hire (0-1 yrs)'
			when YearsAtCompany between 2 and 5 then '2. Mid-Tenure (2-5 yrs)'
            else '3. Senior (6+ yrs)'
            end
order by Attrition_rate desc,
Tenure asc;