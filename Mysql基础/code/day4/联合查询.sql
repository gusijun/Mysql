#进阶9：联合查询
/*
union联合,合并:将多条查询语句的结果合并成一个结果

语法：
查询语句1
union
查询语句2
union
...

应用场景
要查询的结果来自于多个表,且多个表没有直接的连接关系,但查询的信息一致时

特点：
1.要求多条查询语句的查询列数是一致的
2.要求多条查询语句的查询的每一列的类型和顺序最好一致
3.使用union关键字默认去重,如果使用uninon all,可以包含重置项
*/
#引入案例：查询部门编号>90或者是邮箱中包含a的员工信息
SELECT * FROM employees
WHERE email LIKE '%a%' OR department_id > 90;

SELECT * FROM employees WHERE email LIKE '%a%'
UNION 
SELECT * FROM employees WHERE department_id > 90;

#案例：查询中国用户中性别为男的信息以及外国用户中性别为男的用户信息
SELECT id,cname FROM t_ca WHERE csex = '男'
UNION ALL
SELECT t_id,tName FROM t_ua WHERE tGender = 'male';







