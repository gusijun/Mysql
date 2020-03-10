#视图
/*
含义：虚拟表,和普通的表一样使用
myqsl5.1版本出现的新特性,是通过表动态生成的数据

比如：舞蹈班和普通班的对比
		创建语法的关键字	是否实际占用物理空间	使用
视图	create view			只是保存了sql逻辑		增删改查,一般不能增删改
表		create table			保存了实际的数据		增删改查

*/

#案例：查询姓张的学生名和专业名
SELECT stuName,majorname
 FROM stuinfo s
 INNER JOIN major m
 ON s.`majorId` = m.`id`
 WHERE s.`stuName` LIKE '张%';
 
 CREATE VIEW v1
 AS
 SELECT stuName,majorname
 FROM stuinfo s
 INNER JOIN major m
 ON s.`majorId` = m.`id`
 WHERE s.`stuName` LIKE '张%';
 
 
 SELECT * FROM v1 WHERE stuName LIKE '张%';
 
 
 #一、创建视图
 /*
语法：
create view 视图名
as 
查询语句;
 */
USE myemployees;
 #1.查询姓名中包含a字符的员工名、部门名和工种信息
 #1）创建
 CREATE VIEW v
 AS 
  SELECT last_name,department_name,g.job_title
 FROM employees e
 INNER JOIN departments d
 ON e.`department_id` = d.`department_id`
INNER JOIN jobs g
 ON e.`job_id` = g.`job_id`;
 
 
 #2）使用
 SELECT * FROM v WHERE last_name LIKE '%a%';
 
 
 #2.查询各部门的平均工资级别

 #①创建视图去查看每个部门的平均工资
 CREATE VIEW mv2 
 AS
 SELECT AVG(salary) ag,department_id  FROM employees
 GROUP BY department_id;
#②使用

 SELECT mv2.`ag`,g.grade_level 
 FROM mv2
 INNER JOIN  job_grades g
 ON mv2.`ag` BETWEEN g.`lowest_sal` AND g.`highest_sal`;
 
 #3.查询平均工资最低的部门信息
SELECT * FROM mv2 ORDER BY ag ASC LIMIT 1;
 
 #4.查询平均工资最低的部门名和工资
CREATE VIEW mv3
AS
SELECT * FROM mv2 ORDER BY ag ASC LIMIT 1;

SELECT d.*,m.ag FROM mv3 m
INNER JOIN departments d
ON m.`department_id` = d.`department_id`;


-- 复习一遍
SELECT d.*,AVG(salary)
FROM employees e
INNER JOIN departments d
ON d.department_id = e.department_id
GROUP BY e.department_id
HAVING AVG(salary) = (
	SELECT MIN(ag_dep.ag)
	FROM (
	SELECT AVG(salary) ag FROM employees
	GROUP BY department_id
	) ag_dep
);


#二、视图修改
#方式一：
/*
create or replace view 视图名
as
查询语句
*/

SELECT * FROM mv3;
CREATE OR REPLACE VIEW mv3
AS
SELECT AVG(salary),job_id 
FROM employees
GROUP BY job_id;

#方式二：
/*
语法：
alter view 视图名
as 
查询语句;
*/
ALTER VIEW mv3
AS
SELECT * FROM employees;


#三、删除视图
/*
语法：drop view 视图名,视图名,....;
*/
DROP VIEW m;
 
 #四、查看视图
DESC mv3;
SHOW CREATE VIEW mv3;

SHOW CREATE TABLE employees;
 
 #五、视图的更新
 CREATE OR REPLACE VIEW myv1
 AS 
SELECT 
  last_name,
  email,
  salary * 12 * (1+ IFNULL(`commission_pct`, 0)) AS "annual salary" 
  FROM employees;
  
  CREATE OR REPLACE VIEW myv1
  AS 
 SELECT 
  last_name,
  email
  FROM employees;
  
 
 SELECT * FROM myv1;
 SELECT * FROM employees;
 #1.插入
 INSERT INTO myv1 VALUES('顾思君','ALIYUN');
 
 #2.修改
 UPDATE myv1 SET last_name = '古俊'  WHERE last_name = '顾思君';
 
 #3.删除
 DELETE FROM myv1 WHERE last_name = '古俊';
 
 #具有以下特点的视图不允许更新
 
 #①包含以下关键字的sql语句：分组函数、distinct、group  by、having、union或者union all
 CREATE OR REPLACE VIEW myv1
 AS 
 SELECT MAX(salary) m,department_id 
 FROM employees
 GROUP BY department_id;
 
 SELECT * FROM myv1;
 
 #更新
 UPDATE  myv1 SET m = 9000 WHERE department_id = 10;
 
 #②常量视图
 CREATE OR REPLACE VIEW myv2
 AS 
 SELECT 'Nexus' `name`;
 
 SELECT * FROM myv2;
 
 #更新
 UPDATE myv2 SET `name` = 'DDD';
 
 #③select中包含子查询
 CREATE OR REPLACE VIEW myv3
 AS
 SELECT department_id,(SELECT MAX(salary) FROM employees) AS 最高工资
 FROM departments;
 #更新
 SELECT * FROM myv3;
 UPDATE myv3 SET 最高工资 = 10000;
 
 #④join
 CREATE OR REPLACE VIEW myv4
 AS 
 SELECT last_name,department_name
 FROM employees e
 INNER JOIN departments d
 ON e.department_id = d.department_id;
 
 #更新
 SELECT * FROM myv4;
 UPDATE myv4 SET last_name  = '古斯' WHERE department_name = 'Pur';
 INSERT INTO myv4 VALUES('陈真','xxx');
 
 #⑤from一个不能更新的视图
 CREATE OR REPLACE VIEW myv5
 AS 
 SELECT * FROM myv3;
 #更新
 SELECT * FROM myv5;
 UPDATE myv5 SET 最高工资 = 100000 WHERE department_id = 20;
 
 #⑥where子句的子查询引用了from子句中的表
 
 CREATE OR REPLACE VIEW myv6
 AS
 SELECT last_name,email,salary
 FROM employees
 WHERE employee_id IN (
	SELECT manager_id
	FROM employees
	WHERE manager_id IS NOT NULL
 );
 
 #更新
 UPDATE myv6 SET salary = 1000 WHERE last_name = 'k_ing';
 SELECT * FROM myv6;
 
 
 
 
 
 
 
 
 
 
 