1.显示所有员工的姓名、部门号和部门名称
SELECT  last_name,d.department_id,department_name
FROM   employees e,departments d
WHERE d.department_id = e.department_id;
2.查询90号部门员工的job_id和90号部门的location_id

SELECT job_id,location_id
FROM employees e,departments d
WHERE e.`department_id` = d.`department_id`
AND e.`department_id` = 90;

3.选择所有有奖金的员工的last_name,department_name,location_id,city
SELECT last_name,d.department_name,d.location_id,city
FROM employees e,departments d,locations l
WHERE e.department_id = d.department_id
AND l.location_id = d.location_id
AND e.`commission_pct` IS NOT NULL;

4.选择city在Toronto工作的员工的last_name,job_id,department_id,department_name
SELECT last_name,e.job_id,e.department_id,d.department_name
FROM employees e,departments d,locations l 
WHERE e.department_id = d.department_id
AND l.location_id = d.location_id
AND l.city = 'Toronto';

5.查询每个工种、每个部门的部门名、工种名和最低工资
SELECT d.department_name,job_title,MIN(salary) 最低工资
FROM employees e,jobs j,departments d
WHERE d.department_id = e.department_id 
AND e.job_id = j.`job_id`
GROUP BY department_name,job_title;

6.查询每个国家下的部门个数>2的国家编号
SELECT country_id,COUNT(*) 部门个数
FROM departments d,locations l
WHERE d.location_id = l.location_id
GROUP BY l.country_id
HAVING COUNT(*) > 2;
7.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
employees   	Emp#   manager Mgr#
Kochhar		King     100
SELECT e1.last_name employees,e1.employee_id "Emp#",e2.last_name "manager",e2.employee_id "Mgr#"
FROM employees e1,employees e2
WHERE e1.manager_id = e2.employee_id
AND e1.last_name = "Kochhar";






