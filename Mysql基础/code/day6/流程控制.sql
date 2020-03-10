#流程控制结构
/*
顺序结构：程序从上往下执行
分支结构：程序两条或多条路径选择一条去执行
循环结构：程序在满足一定条件的基础上,重复执行一段代码
*/

#一、分支结构
#1.if函数
功能：实现简单的双分支
语法：
SELECT IF(表达式1,表达式2,表达式3)
执行顺序：
如果表达式1成立,则if返回表达式2的值,否则返回表达式3的值

应用：任何地方

#2.case结构
情况1：类似于java中的switch语句,一般用于实现的等值判断
语法：
	CASE 变量 | 表达式 | 字段
	WHERE 要判断的值 THEN 返回的值1或语句1;
	WHEN  要判断的值 THEN 返回的值2或语句2;
	...
	ELSE 要返回的值n或语句n;
	END CASE;
情况2：类似于java中的多重if语句,一般用于
语法：
	CASE 
	WHERE 要判断的条件1 THEN 返回的值1或语句1；
	WHEN  要判断的条件2 THEN 返回的值2或语句2；
	...
	ELSE 要返回的值n或语句n；
	END CASE;


特点：
①
可以作为表达式,嵌套在其他语句中使用,可以放在任何地方,BEGIN end中或BEGIN end的外面
可以作为独立的语句去使用,只能放在begin end中
②
如果说when中的值满足或条件成立,则执行对应的then后面的语句,并且结束case
如果都不满足则执行else中的语句或值
③els可以省略,并且所有的when条件都不满足,则返回null


#案例：
#创建存储过程,根据传入的成绩,来显示等级比如传入的成绩在90-100,显示A,80-90,显示B,60-80,显示c,否则,显示D
DELIMITER $
CREATE PROCEDURE test_Case(IN score INT)
BEGIN
	CASE 
	WHEN score >=90 AND score <= 100 THEN SELECT 'A';
	WHEN score >=80  THEN SELECT 'B';
	WHEN score >= 60  THEN SELECT 'C';
	ELSE SELECT 'D';
	END CASE;
END $

CALL test_Case(70)$

#3.if结构
/*
功能：实现多重分支
语法：
if 条件1 then 语句1；
elseif 条件2 then 语句2；
...
【else	语句n】；  
end if；

应用在begin end中
*/

#案例1：根据传入的成绩,来显示等级比如传入的成绩在90-100,返回A,80-90,返回B,60-80,返回c,否则,返回D
DELIMITER $
CREATE FUNCTION test_IF(score INT) RETURNS CHAR
BEGIN
	IF score >= 90 AND score <= 100 THEN RETURN 'A';
	ELSEIF score >= 80 THEN RETURN 'B';
	ELSEIF score >= 60 THEN RETURN 'C';
	ELSE RETURN 'D';
	END IF;
END $ 

SELECT test_IF(88)$

#二、循环结构
/*
分类：
while、loop、repeat

循环控制：
iterate 类似于continue,继续,结束本次循环,继续下一次
leave 类似于beark,跳出,结束当前所在的循环
*/
#1.while
/*
语法:
【标签:】 while 循环条件 do
	循环体；
end  while  【标签】;

while(循环条件){
	循环体；
}

2.loop
语法：
[标签:] loop 
	循环体；
end loop [循环];

可以用来模拟简单的死循环
*/

#3.repeat
/*
语法：
[标签：] repeat
	循环体；
until  结束循环的条件
end repeat [标签];	
*/

#没有添加循环控制语句
#案例：批量插入：根据次数插入到admin表中多条记录

DROP PROCEDURE pro_while1;
CREATE PROCEDURE pro_while1(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	a:WHILE i <= insertCount DO
		INSERT INTO admin(username,`password`) VALUES(CONCAT('Nexus',i),'666');
		SET i =  i + 1;
	END WHILE a;
END $

CALL pro_while1(100);

/*
int i=1;
while(i<=insertCount){
	// 插入
	i++;
}
*/


#2、添加leave语句批量插入：根据次数插入到admin表中多条记录,只插入偶数次
TRUNCATE TABLE admin$
DROP PROCEDURE pro_while1
DELIMITER $
CREATE PROCEDURE  tets_while1(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	a:WHILE i <= insertCount DO
		INSERT INTO admin(username,`password`) VALUES(CONCAT('Netty',i),'9999') ;
		IF i >= 20 THEN LEAVE a;
		END IF;
		SET i = i+1;
	END WHILE a;
END $

CALL tets_while1(200)$


#3.添加iterate语句
TRUNCATE TABLE admin$
DROP PROCEDURE tets_while1
DELIMITER $
CREATE PROCEDURE  tets_while1(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	a:WHILE i <= insertCount DO
		SET i = i+1;
		IF MOD(i,2) != 0 THEN ITERATE a;
		END IF;
		INSERT INTO admin(username,`password`) VALUES(CONCAT('Netty',i),'9999') ;
	END WHILE a;
END $

CALL tets_while1(100)$

SELECT * FROM admin;
/*
int i=-1;
while(i<=insertCount){
	i++;
	if(i%2==0){
		continue
	}
	插入
}
*/














