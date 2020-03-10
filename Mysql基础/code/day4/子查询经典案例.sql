1.查询工资最低的员工信息:last_name,salary
#①查询最低工资
SELECT MIN(salary) FROM employees;
#②在①的结果上筛选
SELECT last_name,salary FROM employees
WHERE salary = (
	SELECT 
	  MIN(salary) 
	FROM
	  employees 
);

2.查询平均工资最低的部门信息
#①查询每个部门的平均工资
SELECT `department_id`,AVG(salary) FROM employees
GROUP BY `department_id`;
#②查询①结果上的最低平均工资
SELECT MIN(ag)
FROM (
	SELECT 
	  AVG(salary) ag
	FROM
	  employees 
	GROUP BY `department_id` 
) ag_dep;

#③查询那个编号的部门平均工资=②
SELECT `department_id`,AVG(salary)
 FROM employees
GROUP BY `department_id`
HAVING AVG(salary) = (
		SELECT MIN(ag)
		FROM (
			SELECT 
			  `department_id`,
			  AVG(salary) ag
			FROM
			  employees 
			GROUP BY `department_id` 
		) ag_dep
);

#④查询部门信息
SELECT d.* 
FROM departments d
WHERE d.`department_id` = (
	SELECT `department_id`
	 FROM employees
	GROUP BY `department_id`
	HAVING AVG(salary) = (
			SELECT MIN(ag)
			FROM (
				SELECT 
				  `department_id`,
				  AVG(salary) ag
				FROM
				  employees 
				GROUP BY `department_id` 
			) ag_dep
	)
) ;

#方式二：
#①各部门的平均工资
SELECT AVG(salary),department_id
FROM employees
GROUP BY department_id;
#②求出最低工资的部门编号
SELECT department_id 
FROM employees
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;
#③查询部门信息
SELECT *
FROM departments 
WHERE department_id = (
	SELECT department_id 
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1
);

-- 自己写的
SELECT d.* FROM departments   d
INNER JOIN (
	SELECT `department_id`,AVG(salary)  ag FROM employees
	GROUP BY `department_id`
) AS e
ON e.`department_id` = d.`department_id`
ORDER BY e.ag ASC
LIMIT 1;

3.查询平均工资最低的部门信息和该部门的平均工资
#①各部门的平均工资
SELECT AVG(salary),department_id
FROM employees
GROUP BY department_id;
#②求出最低工资的部门编号
SELECT AVG(salary)department_id 
FROM employees
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;
#③查询部门信息
SELECT d.*,ag
FROM departments d
INNER JOIN (
	SELECT AVG(salary) ag,department_id 
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1
) ag_dep
ON d.`department_id` = ag_dep.department_id;



-- 自己写的
SELECT d.*,e.ag FROM departments   d
INNER JOIN (
	SELECT `department_id`,AVG(salary)  ag FROM employees
	GROUP BY `department_id`
) AS e
ON e.`department_id` = d.`department_id`
ORDER BY e.ag ASC
LIMIT 1;

4.查询平均工资最高的job信息
#①查询最高job的平均工资
SELECT AVG(salary),job_id FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC
LIMIT 1

#②查询job信息
SELECT * FROM jobs
WHERE job_id = (
	SELECT job_id FROM employees
	GROUP BY job_id
	ORDER BY AVG(salary) DESC
	LIMIT 1
);

-- 自己写的

SELECT * FROM jobs j  
WHERE j.`job_id` = (
	SELECT job_id FROM employees 
	GROUP BY job_id
	HAVING AVG(salary) =  (
		SELECT MAX(a) 
		FROM (
			SELECT AVG(salary) a  FROM employees
			GROUP BY job_id
		) e	
	)
);





5.查询平均工资高于公司平均工资的部门有哪些？
#①查询平均工资
SELECT AVG(salary) FROM employees;

#②查询每个部门的平均工资
SELECT AVG(salary),department_id FROM employees
GROUP BY department_id;

#③筛选②结果集,满足平均工资>①
SELECT AVG(salary),department_id FROM employees
GROUP BY department_id
HAVING AVG(salary) > (
	SELECT AVG(salary) FROM employees
) 

-- 自己写的
SELECT department_id FROM employees 
GROUP BY department_id
HAVING AVG(salary) > (
	SELECT AVG(salary) FROM employees
);

6.查询出公司所有manager的详细信息
#①查询所有manager的员工编号
SELECT DISTINCT manager_id FROM employees;
#②查询详细信,满足employee_id = ①


SELECT * FROM employees 
WHERE employee_id IN (
	SELECT DISTINCT manager_id 
	FROM employees
);
7.各个部门中 最高工资中最低的那个部门的 最低工资是多少？
#①查询各部门的最高工资最低的
SELECT department_id FROM employees
GROUP BY department_id
ORDER BY MAX(salary) ASC
LIMIT 1;
#②查询①结果的那个部门的最低工资
SELECT MIN(salary),department_id FROM employees
WHERE department_id = (
	SELECT department_id FROM employees
	GROUP BY department_id
	ORDER BY MAX(salary) ASC
	LIMIT 1
);

8.查询平均工资最高的部门的manager的详细信息:last_name,department_id,email
salary

#①查询平均工资最高的部门编号
SELECT department_id
FROM employees
GROUP BY department_id
ORDER BY AVG(salary) DESC
LIMIT 1;

SELECT last_name,d.department_id,email,salary
FROM employees e
INNER JOIN departments d
ON d.`manager_id` = e.`employee_id`
WHERE d.`department_id` = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) DESC
	LIMIT 1
);




















