# 1.显示系统时间(注：日期+时间)
SELECT NOW();
# 2.查询员工号,姓名,工资,以及工资提高包分之20%的结果(new salary)
SELECT employee_id,last_name,salary * 1.2 AS "new salary"
FROM employees;

# 3.将员工的姓名按首字母排序,并写出姓名的长度(length)
SELECT 
  LENGTH(last_name) AS 长度,
  SUBSTR(last_name,1, 1) AS 首字符,
  last_name 
FROM
  employees 
ORDER BY 首字符 ASC ;

# 4.
<last_name> earns	<salary> monthly but wants <salary*3>
Dreams Salary 
SELECT CONCAT(last_name,' earns ',salary,' monthly but wants ',salary * 3) AS "Dream Salary"
FROM employees
WHERE salary = 24000;

# 5.使用case-when ,按照下面的条件：
job			grade
AD_PRES	A
ST_MAN		B
IT_PROG	C


SELECT last_name,job_id AS job,
CASE job_id
WHEN 'AD_PRES' THEN  'A'
WHEN 'ST_MAN' THEN  'B'
WHEN 'IT_PROG' THEN  'C'
WHEN 'SA_PRE' THEN 'D'
WHEN 'ST_CLERK' THEN 'E'
END AS Grade
FROM employees
WHERE	job_id = 'AD_PRES';





