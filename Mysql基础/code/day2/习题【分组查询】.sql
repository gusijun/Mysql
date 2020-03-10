1.查询各job_id的员工工资的最大值、最小值、平均值、总和,并按照job_id升序
SELECT job_id,MAX(salary) 最大值,MIN(salary) 最小值,AVG(salary) 平均值,
SUM(salary) 总和
FROM employees 
GROUP BY job_id
ORDER BY job_id ASC;
2.查询员工最高工资和最低工资的差距(DIFFERENCE)
SELECT  MAX(salary)-MIN(salary) AS
DIFFERENCE
FROM employees;
3.查询各个管理者手下员工的最低工资,其中最低工资不能低于6000,没有管理者的员工不计算在内
SELECT `manager_id`,MIN(salary) `min`
FROM employees
WHERE `manager_id` IS NOT NULL
GROUP BY `manager_id`
HAVING `min` >=6000;

4.查询所有部门的编号,员工数量和平均工资值,并按平均工资降序
SELECT department_id,COUNT(*),AVG(salary) a
FROM employees
GROUP BY department_id
ORDER BY a DESC; 
5.选择具有各个job_id的员工人数
SELECT COUNT(*) 个数,job_id
FROM employees
GROUP BY job_id;






