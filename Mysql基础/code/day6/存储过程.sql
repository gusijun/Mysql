#存储过程和函数
/*
存储过程和函数：类似于java中的方法
好处：
1.提高代码的重用性
2.简化操作


*/
#存储过程
/*
含义：一组预先编译好的sql语句的集合,理解成批处理语句
1.提高代码的重用性
2.简化操作
3.减少了编译次数并且减少了数据库和服务器的连接次数,提高了效率
*/

#一、创建语法
CREATE PROCEDURE 存储过程名(参数列表)
BEGIN
	存储过程体（一组合法有效的sql语句）
END

注意
1.参数列表包含三部分
参数模式 参数名 参数类型
举例：
IN stuName VARCHAR(20)
参数模式：
in：该参数可以作为输入,也就是说该参数需要调用方传入值
out：该参数可以作为输出,也就是说该参数可以作为返回值
inout：该参数即可以作为输入有可以作为输出,该参数既需要传入值,又可以返回值

2.如果存储过程体只有一句话,`begin end`可以省略
存储过程体的每条sql语句的结尾要求必须加分号,
存储过程的结尾可以使用 DELIMITER 重新设置
语法：
DELIMITER 结束标记
案例:
DELIMITER $

#二、调用语法
CALL 存储过程名（实参列表）；

-# - - - - - - - - - - - - - - - - - - - - - - - 案例演示 - - - - - - - - - - -  - - - - - - - - - - -
#1.空参列表
#案例：插入到admin表中5条记录
DELIMITER $
CREATE PROCEDURE mup1()
BEGIN
	INSERT INTO admin(username,`password`) 
	VALUES('John','0000'),('lily','1111'),('jack','2222'),('tom','4444'),
	('rose','0000');
END $

#调用
CALL mup1()$

#2.创建带in模式参数的存储过程

#案例1：创建存储过程实现根据女神名查询对应的男神信息
CREATE PROCEDURE myp2(IN beautyName VARCHAR(255))
BEGIN 
	SELECT bo.*
	FROM boys bo
	RIGHT OUTER JOIN beauty b
	ON bo.`id` = b.`boyfriend_id`
	WHERE b.name = beautyName;
END $


#调用 
CALL myp2('小昭')$

#案例2：创建存储过程实现用否是否登录成功
CREATE PROCEDURE myp3(IN userName VARCHAR(255),IN `password` VARCHAR(255) )
BEGIN
	DECLARE result INT DEFAULT 0; #声明并初始话化
	SELECT COUNT(*) INTO result	#赋值
	FROM admin
	WHERE admin.`username` = userName
	 AND admin.`password` = `password`;
	
	SELECT IF(result>0,'用户存在','用户不存在') 提示; #使用
END $

#调用
CALL myp3('顾思君',7777)$

#3.创建带Out模式的存储过程

#案例1：根据女神名,返回对象的男神名
DELIMITER $
CREATE PROCEDURE myp4(IN beautyName VARCHAR(255),OUT boyName VARCHAR(255) )
BEGIN 
	SELECT bo.boyName INTO boyName
	FROM boys bo
	INNER JOIN beauty b
	ON bo.id = b.boyfriend_id
	WHERE b.name = beautyName;
END$

 
#调用
SET @boyName$
CALL myp4('小昭'@boyName)$
SELECT @boyName;

#案例2：根据女生名,返回对应的男神名和男神魅力值
DELIMITER $
CREATE PROCEDURE myp5(IN beautyName VARCHAR(255),OUT boyName VARCHAR(255),OUT userCP INT)
BEGIN
	SELECT bo.boyName,bo.userCP
	INTO boyName,userCP
	FROM boys bo
	INNER JOIN 
	beauty b
	ON bo.`id` = b.`boyfriend_id`
	WHERE b.`name` = beautyName;
END $

#调用
CALL mp6('小昭',@bName,@usercp);


#案例：根据用户id,查询部门名（用户可能没有部门,所以只查询有部门的部门名）
DELIMITER $
CREATE PROCEDURE test(IN employee_id INT,OUT departmentName VARCHAR(255))
BEGIN
	SELECT `department_name`
	INTO departmentName
	FROM employees e
	LEFT OUTER JOIN departments  d
	ON e.`department_id`  = d.`department_id`
	WHERE e.employee_id = employee_id;
END $

#查询
SET @deaprtmentName:=' '$
CALL test(20,@deaprtmentName)$
SELECT @deaprtmentName$


#4.创建inout模式的存储过程
#案例：传入a和b两个值,最终a和b都翻倍返回
DELIMITER $
CREATE PROCEDURE myp8(INOUT a INT,INOUT b INT)
BEGIN 
	SET a = a*2;
	SET b = b*2;
END $



#调用
SET @a:=5$
SET @b:=6$
CALL mup8(@a,@b)$

#查看
SELECT @a,@b$


#二、删除存储过程
#语法： drop procedure 存储过程名 
DROP PROCEDURE myp3;

#三、查看存储过程的信息
SHOW CREATE PROCEDURE M;






