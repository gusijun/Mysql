一、查询编号>3的女神的男朋友信息,如果有则列出详细,如果没有用Null填充
SELECT b.id,b.name,bo.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id` = bo.id
WHERE b.id > 3;
二、查询哪个城市没有部门
SELECT city
FROM locations l
LEFT OUTER JOIN departments d
ON d.`location_id` = l.`location_id`
WHERE d.location_id IS NULL;
三、查询哪个部门名为SAL或IT的员工信息
-- 部门为SAL或IT的可能没员工所以内连接不合适
SELECT e.*,department_name
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_name` IN ('SAL','IT');

SELECT e.*,department_name
FROM departments d
LEFT OUTER JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE d.`department_name` IN ('SAL','IT');



