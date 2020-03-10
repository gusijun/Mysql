#进阶7：子查询
/*
含义：
出现在其他语句中的select语句,成为子查询或内查询
外部的查询语句,成为主查询或外查询

分类：
按子查询出现的位置：	
	select后面：
		仅仅支持标量子查询
	from后面
		支持表子查询
	where或having后面： ★
		标量子查询（单行） √
		列子查询    （多行） √
		
		行子查询
	exists（相关子查询）
		表子查询
		
按结果集行列数不同：
	标量子查询（结果集只有一行一列）
	列子查询（结果集只有一列多行）
	行子查询（结果集有一行多列）
	表子查询（结果集一般为多行多列）
	
*/

#一、where或having后面
/*
1.标量子查询（单行子查询）
2.列子查询（多行子查询）

3.行子查询（多列多行）


特点：
①子查询放在小括号内
②子查询一般放在条件的右侧
③标量子查询,一般搭配单行操作符使用
> < >= <= <>

列子查询，一般搭配着多行操作符使用
in,any/some,all
④子查询的执行优先于主查询执行,主查询的条件用到了子查询的结果
*/

#1.标量子查询
#案例１：谁的工资比Abel 高？
#①查询Abel工资
SELECT salary
FROM employees
WHERE last_name = 'Abel'

#②查询员工的信息,满足salary>①的结果
SELECT * FROM employees
WHERE salary > (
	SELECT salary
	FROM employees
	WHERE last_name = 'Abel'
);

#案例2：返回job_id与141号相同,salary比143员工多的员工 姓名,job_id和工资
#①查询141号员工的job_id
SELECT 
  job_id 
FROM
  employees 
WHERE employee_id = 141;
#②查询143号员工的salary
SELECT 
 salary
 FROM
 employees
 WHERE employee_id = 143;

#③查询员工的姓名,job_id和工资,要求job_id=①并且salary>②
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = (
	SELECT 
	  job_id 
	FROM
	  employees 
	WHERE employee_id = 141 
)  AND
salary > (
	SELECT 
	  salary 
	FROM
	  employees 
	WHERE employee_id = 143 
);

#案例3：返回公司工资最少的last_name,job_id和salary
#①查询工资的最少工资
SELECT MIN(salary) FROM employees;

#②查询ast_name,job_id和salary,要求salary=①
SELECT last_name,job_id,salary
FROM employees
WHERE salary = (
	SELECT 
	  MIN(salary) 
	FROM
	  employees 
);

#案例4：查询最低工资大于50号部门最低工资的部门id和其最低工资

#①查询50号部门的最低工资
SELECT MIN(salary) FROM employees
WHERE department_id = 50;

#②查询每个部门的最低工资
SELECT MIN(salary),department_id FROM employees
GROUP BY department_id;

#③在②基础上筛选，满足min(salary) > ①的结果
SELECT department_id,salary
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT 
	  MIN(salary) 
	FROM
	  employees 
	WHERE department_id = 50 

);

# 非法使用标量子查询

SELECT department_id,salary
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT 
	  salary 
	FROM
	  employees 
	WHERE department_id = 250 
);

#2.列子查询（多行子查询）
#案例1：返回location_id是1400或1700的部门中的所有员工姓名

#①查询location_id是1400或1700的部门编号
SELECT 
DISTINCT
department_id
FROM departments
WHERE location_id = 1400 OR location_id = 1700;

#②查询员工姓名,要求部门号是①列表中的某一个
SELECT last_name
FROM employees
WHERE department_id IN (
	SELECT 
	DISTINCT
	department_id
	FROM departments
	WHERE location_id = 1400 OR location_id = 1700
);


# @用内连接做一下
SELECT last_name
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`
INNER JOIN  locations l
ON d.`location_id` = l.`location_id`
WHERE  l.`location_id` IN (1400,1700);

#案例2：返回其他工种中比job_ib为'IT_PROG'任一门工资低的员工的员工号、姓名、job_id以及salary

#①查询job_id为‘IT_PROG'部门任一门工资
SELECT DISTINCT salary FROM employees
WHERE job_id = 'IT_PROG'; 
#②查询员工号、姓名、job_id以及salary,salary<①中的任意一个结果
SELECT department_id,last_name,job_id,salary
FROM employees
WHERE salary < ANY(
	SELECT DISTINCT 
	  salary 
	FROM
	  employees 
	WHERE job_id = 'IT_PROG' 
) AND job_id <> 'IT_PROG';

#或
SELECT department_id,last_name,job_id,salary
FROM employees
WHERE salary < (
	SELECT DISTINCT 
	  MAX(salary) 
	FROM
	  employees 
	WHERE job_id = 'IT_PROG' 
) AND job_id <> 'IT_PROG';

# 案例3：返回其他工种中比job_ib为'IT_PROG'所有门工资低的员工的员工号、姓名、job_id以及salary
SELECT department_id,last_name,job_id,salary
FROM employees
WHERE salary < ALL(
	SELECT DISTINCT 
	  salary 
	FROM
	  employees 
	WHERE job_id = 'IT_PROG' 
) AND job_id <> 'IT_PROG';

#或
SELECT department_id,last_name,job_id,salary
FROM employees
WHERE salary < (
	SELECT DISTINCT 
	  MIN(salary) 
	FROM
	  employees 
	WHERE job_id = 'IT_PROG' 
) AND job_id <> 'IT_PROG';

#3、行子查询（结果集是一行多列或多行多列）
#案例：查询员工编号最小并且工资最高的员工信息

SELECT * 
FROM employees
WHERE (employee_id,salary) = (
	SELECT  MIN(employee_id),MAX(salary)
	FROM employees
);

#①查询最小的员工编号
SELECT MIN(employee_id) FROM employees;

#②查询出最高的工资
SELECT MAX(salary) FROM employees;

#③查询员工信息
SELECT * 
FROM employees
WHERE employee_id = (
	SELECT 
	  MIN(employee_id) 
	FROM
	  employees 
) AND salary = (
	SELECT 
	  MAX(salary) 
	FROM
	  employees
);

#二、select后面
#案例：查询每个部门的员工个数
/*
仅仅支持标量子查询
*/
SELECT d.*,(
	SELECT 
	  COUNT(*) 
	FROM
	  employees e 
	WHERE e.department_id = d.`department_id` 
) AS 部门个数
FROM departments d;

#外连接 搞定
SELECT d.*,IF(e.`employee_id` IS NULL,0,COUNT(*)) 个数
FROM departments d
LEFT OUTER JOIN employees e
ON e.`department_id` = d.`department_id`
# where e.`employee_id` is not null
GROUP BY d.`department_id`;

#案例2：查询员工号=102的部门名
SELECT (
	SELECT department_name FROM departments d
	INNER JOIN employees e
	ON e.`department_id` = d.department_id
	WHERE e.`employee_id` = 102
) AS 部门名;

#三、from后面

#实例：查询每个部门的平均工资的工资等级
#①查询每个部门的平均工资
/*
将子查询结果充当一张表，要求必须起别名
*/
SELECT 
  AVG(salary) 
FROM
  employees 
GROUP BY department_id ;

SELECT * FROM job_grades;

#②连接①的结果集合job_grades表，筛选条件平均工资在between and
SELECT	
	ag_dep.*,g.`grade_level`
FROM (
	SELECT 
	  AVG(salary)  ag,department_id
	FROM
	  employees 
	GROUP BY department_id 
) ag_dep
INNER JOIN job_grades g
ON ag_dep.ag BETWEEN `lowest_sal` AND `highest_sal`;

#四、exists后面（相关子查询）

/*
语法：
exixts(完整的查询语句)
结果：
1或0
*/

SELECT EXISTS(SELECT employee_id FROM employees WHERE salary = 30000);
#案例1：查询有员工的部门名'
SELECT department_name
FROM departments d
WHERE d.`department_id` IN (
	SELECT department_id
	FROM employees 
);


SELECT department_name FROM 
departments d
WHERE EXISTS(
	SELECT * FROM employees e
	WHERE d.`department_id` = e.`department_id`
);

#连接试试

SELECT
DISTINCT
department_name
FROM departments d
LEFT OUTER JOIN employees e
ON e.`department_id` =  d.`department_id`
WHERE e.`employee_id` IS NOT NULL;

#案例2：查询没有女朋友的男神信息

#in
SELECT bo.*
FROM boys bo
WHERE bo.`id` NOT IN(
	SELECT boyfriend_id 
	FROM beauty
);

#exists
SELECT bo.* 
FROM boys bo
WHERE NOT EXISTS(
	SELECT boyfriend_id 
	FROM beauty b
	WHERE b.`boyfriend_id` = bo.`id`
);



