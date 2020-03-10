#变量
/*
系统变量：
	全局变量
	会话变量
自定义变量：
	用户变量
	局部变量
*/

#一、系统变量
/*
说明：变量是由系统提供的,不是用户定义,属于服务器层面
注意：
如果是全局级别,需要加global,如果是会话级别,则需要加session,如果不写,默认session
使用的语法：
1.查看当前所有的系统变量
SHOW global | 【session】 VARIABLES;
2.查看满足条件的部分变量
show global | 【session】 variables like '%char%';
3.查看某个系统变量的值
select @@global | 【session】.系统变量名;
4.为某个具体的系统变量赋值
方式一：
set global | 【session】系统变量名 = 值；
方式二：
set @@global | 【session】.系统变量名 = 值；
*/

#1)全局变量
/*
作用域：服务器每次启动将为所有的变量赋初始值,针对于所有的会话（连接）有效
		 但不能跨重启
*/
#①查看所有的全局变量
SHOW GLOBAL  VARIABLES;
#②查看部分的全局变量
SHOW GLOBAL VARIABLES LIKE '%char%';
#③查看指定的全局变量的值
SELECT @@global.autocommit;
SELECT @@tx_isolation;
#为某个指定的全局变量赋值
SET @@global.autocommit = 0;
SET GLOBAL autocommit = 1;

#2)会话变量
/*
作用域：仅仅针对于当前的会话(连接)有效
*/

#①查看所有的会话变量
SHOW SESSION VARIABLES;
#②查看部分的会话变量
SHOW  VARIABLES LIKE '%char%';
SHOW SESSION VARIABLES LIKE '%char%';
#③查看指定的某个会话变量
SELECT @@session.autocommit;
SELECT @@tx_isolation;
#为某个指定的会话变量赋值
方式一：
SET @@session.tx_isolation = 'read-uncommitted';
SELECT @@session.tx_isolation;

方式二：
SET SESSION tx_isolation = 'read-committed';

#二、自定义变量
/*
说明：变量是用户自定义的,不是由系统的
使用步骤
声明
赋值
使用（查看、比较、运算等）
*/
#1.用户变量
/*
作用域：针对于当前会话（连接）有效,同于会话变量的作用域
应用在任何地方,也就是begin end里面或begin end外面
*/

#①声明并初始化
赋值的操作符：=或：=
SET @用户变量 = 值；或
SET @用户变量名：=值；或
SELECT @用户变量名：=值；

#赋值（更新用户变量的值）
方式一：通过set或者select 
		SET @用户变量 = 值；或
		SET @用户变量名：=值；或
		SELECT @用户变量名：=值；
方式二：通过select INTO
		SELECT 字段 INTO 变量名
		FROM 表；

#③使用(查看用户变量的值)
SELECT @用户变量名；


#案例
#声明并初始化
SET @name:='Nexus';
SET @name:=100;
SELECT @count:= 99;

#赋值
SELECT 
  COUNT(*) INTO @count 
FROM
  employees ;

#查看
SELECT @count;

#2.局部变量
/*
作用域：仅仅在定义它的begin end中有效
应用在begin end中的第一句话！！！！
*/
#①声明
DECLARE  变量名	类型；
DECLARE  变量名 类型 DEFAULT 值；

#②赋值 
方式一：通过set或者select 
		SET 局部变量名 = 值；或
		SET 局部变量名：=值；或
		SELECT @局部变量名：=值；
方式二：通过select INTO
		SELECT 字段 INTO 局部变量名
		FROM 表；
		
#③使用
SELECT  局部变量名；

对比用户变量和局部变量：
			作用域		定义和使用的位置				语法
用户变量	当前会话	会话中的任何地方				必须加@符号,不用限定类型
局部变量	BEGIN END   只能在begin end中,且为第一句 	一般不用加@符号,需要限定类型

#声明两个变量并赋初值,求和,并打印

#1.用户变量
SET @num1:= 1;
SET @num2:=99;
SET  @sum = @num1 + @num2;
SELECT @sum;



#2.局部变量
DECLARE m INT DEFAULT 1;
DECLARE n INT DEFAULT 99;
DECLARE SUM INT;
SET SUM = m+n;
SELECT SUM;








