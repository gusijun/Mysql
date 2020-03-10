#函数
/*
含义：一组预先编译好的sql语句的集合,理解成批处理语句
1.提高代码的重用性
2.简化操作
3.减少了编译次数并且减少了数据库和服务器的连接次数,提高了效率

区别：
存储过程：可以有0个返回,也可以有多个返回,适合做批量的插入,批量更新
函数：有且仅有一个返回,适合处理数据后返回一个结果

*/

#一、函数的创建语法
crate FUNCTION 函数名(参数列表) RETURNS 返回类型
BEGIN
	函数体
END
/*
注意：
参数列表 包含两部分：
参数名 参数类型

函数体:肯定会有return语句,如果没有会报错
如果return没有放在函数体的最后也不报错,但不建议

return 值；

3.当函数体中只有一句话,则可以省略begin end
4.使用delimiter设置结束标记 
*/

#二、调用语法
SELECT 函数名(参数列表)


#---------------------案例演示-----------------------
#1.无参有返回
#案例：返回员工的个数
DELIMITER $
CREATE FUNCTION myf1() RETURNS INT
BEGIN
	DECLARE c INT DEFAULT 0;#定义变量
	SELECT COUNT(*)  INTO c#为变量赋值
	FROM `employees`;
	RETURN c;
END $

SELECT myf1()$

#案例1：根据员工名返回,返回它的工资
DELIMITER $
CREATE FUNCTION myf2(empName VARCHAR(255)) RETURNS DOUBLE
BEGIN
	DECLARE sal DOUBLE DEFAULT 0.0;
	SELECT  salary
	INTO  sal
	FROM employees
	WHERE last_name =  empName;
	
	RETURN sal;
END $

SELECT myf2('k_ing')$

#案例2：根据部门名,返回该部门的平均工资
DELIMITER $
CREATE FUNCTION myf3(departmentName VARCHAR(255)) RETURNS DOUBLE
BEGIN
	DECLARE avg_salary DOUBLE;
	SELECT AVG(salary) INTO avg_salary
	FROM `employees`
	WHERE `department_id` = (
		SELECT 
		DISTINCT
		e.`department_id` 
		FROM `departments` d
		INNER JOIN `employees` e
		ON d.`department_id` = e.`department_id`
		WHERE d.`department_name` = departmentName
	);
	RETURN avg_salary;
		
END $

SELECT myf3('IT')$

#三、查看函数
SHOW CREATE FUNCTION myf3;

#四、删除函数
DROP FUNCTION myf3;


#案例：创建函数,实现传入两个float,返回二者之和
DELIMITER $
CREATE FUNCTION test_fun1(num1 FLOAT,num2 FLOAT) RETURNS FLOAT
BEGIN
	DECLARE  SUM FLOAT;
	SET SUM = num1+num2;
	RETURN SUM;
END $

SELECT test_fun1(1,2)$



