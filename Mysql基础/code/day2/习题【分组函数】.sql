1.查询公司员工工资的最大值、最小值、平均值、总和
SELECT MAX(salary) MaxSalary,MIN(salary) MinSalary,TRUNCATE(AVG(salary),2) AvgSalary,SUM(salary) SumSalary
FROM employees;
2.查询员工表的最大入职时间和最小入职时间的相差天数
DIFFRENCE
SELECT DATEDIFF(MAX(`hiredate`),MIN(`hiredate`))
AS  DIFFRENCE
FROM employees;

3.查询部门编号为90的员工的个数
SELECT COUNT(*) FROM employees
WHERE `department_id` = 90;