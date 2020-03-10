#一、创建视图emp_v1,要求查询电话号码为'011'开头的员工姓名和工资、邮箱
CREATE VIEW emp_v1
AS 
SELECT last_name,salary,email
FROM employees
WHERE `phone_number` LIKE '011%';

SELECT * FROM emp_v1;

#二、创建视图emp_v2,要求查询部门的最高工资高于12000的部门信息

-- 老师答案
CREATE VIEW m
AS
SELECT MAX(salary) ag,department_id
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 12000; 


SELECT d.*,m.ag
FROM departments d
INNER JOIN m
ON m.department_id = d.`department_id`;


-- 方式一：连接查询
SELECT d.*
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
GROUP BY e.department_id
HAVING MAX(salary) > 12000;


-- 方式二 ：子查询
SELECT d.*
FROM departments d
WHERE department_id = ANY (
	SELECT department_id 
	FROM employees
	WHERE salary IN (
			SELECT MAX(salary) 
			FROM employees
			GROUP BY department_id
			HAVING MAX(salary) > 12000
		)
);


CREATE VIEW emp_v2
AS
SELECT d.*
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
GROUP BY e.department_id
HAVING MAX(salary) > 12000;


CREATE VIEW emp_v3
AS
SELECT d.*
FROM departments d
WHERE department_id = ANY (
	SELECT department_id 
	FROM employees
	WHERE salary IN (
			SELECT MAX(salary) 
			FROM employees
			GROUP BY department_id
			HAVING MAX(salary) > 12000
		)
);

SELECT * FROM emp_v2;
SELECT * FROM emp_v3;









