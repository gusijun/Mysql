#DML语法
/*
数据操作语言
插入 insert  
修改 update
删除 delate
*/

#一、插入语句
#方式一：经典的插入
/*
语法：
insert into 表名(列名,.....) values(值,....);
*/
#1.插入的值的类型要与列的类型一致或兼容
SELECT * FROM beauty;
INSERT INTO beauty(id,`name`,sex,borndate,phone,photo,boyfriend_id)
VALUES(13,'李沁','女','1998-10-14','18988888',NULL,2);

#2.不可以为null的值必须插入值,可以为null的列如何插入值？
#方式一：
INSERT INTO beauty(id,`name`,sex,borndate,phone,photo,boyfriend_id)
VALUES(22,'李沁','女',NULL,'18988888',NULL,2);

#方式二：
INSERT INTO beauty(id,`name`,sex,phone)
VALUES(15,'娜扎','女','20988888');

#3.列的顺序是否可以调换？
INSERT INTO beauty(`name`,sex,id,phone)
VALUES('顾思君','男',99,'77777777777');

#4.列数和值的个数必须一致
INSERT INTO beauty(`name`,sex,id,phone)
VALUES('关晓彤','女',17,'77777777777');

#5.可以省略列名,默认省略所有列,而且列的顺序和表中列的顺序一致
INSERT INTO beauty
VALUES(19,'张飞','男',NULL,'119',NULL,NULL);

#方式二
/*
insert into 表名
set 列名 = 值,列名 = 值,....
*/

INSERT INTO  beauty 
SET id = 111,`name` = '刘涛',phone = '999';

#两种方式大pk
1.方式一支持插入多行,方式2不支持
INSERT INTO beauty 
VALUES(77,'李沁2','女','1998-10-14','18988888',NULL,2),
		(88,'李沁8','女','1998-10-14','18988888',NULL,2),
		(199,'李沁77','女','1998-10-14','18988888',NULL,2);

2.方式一支持子查询，方式二不支持
INSERT INTO beauty(id,`name`,phone)
SELECT 44,'啪啪啪','54575';

#二、修改语句
/*
1.修改单表中的记录★
语法：
update 表名
set 列 = 值,列=值,.....
where 筛选条件;


2.修改多表的记录【补充】
语法：
sql92语法：
update 表1 别名,表2 别名
set 列 = 值,....
where 连接条件
and 筛选条件

sql99语法
update 表1 别名
inner | left | right join 表2 别名
on 连接条件
set 列 = 值,....
where 筛选条件
*/

#案例1.修改beauty表中姓顾的男神的电话改成99999
UPDATE beauty 
SET phone = '99999'
WHERE `name` LIKE '顾%';

#案例2：修改boys表中的id号为2的名称为古俊,魅力值为100
UPDATE boys SET `boyname` = '古俊',usercp = 100
WHERE id = 2;

#2.修改多表的记录
#案例：1.修改张无忌的女朋友的手机号为114
UPDATE boys bo
INNER JOIN beauty b
ON bo.`id` = b.`boyfriend_id`
SET b.`phone` = '114'
WHERE bo.`boyName` = '张无忌';


#子查询
SELECT id FROM boys b
WHERE boyName = '张无忌'

UPDATE beauty 
SET phone = '411'
WHERE boyfriend_id = (
	SELECT id FROM boys b
	WHERE boyName = '张无忌'
);  

#案例2：修改没有男朋友的女神的男朋友编号都为2号

UPDATE beauty b
LEFT OUTER JOIN boys bo
ON b.`boyfriend_id`   = bo.`id`
SET b.`boyfriend_id` = 2
WHERE bo.`id` IS NULL;


#三、删除语句
/*
语法一：delete
语法：
1.单表的删除【☆】
delete from 表名 where 筛选条件
2.多表的删除【补充】

sql92语法:

delete  表1的别名,表2的别名
from 表1 别名,表2 别名
where 连接条件
and 筛选条件

sql99语法:
delete  表1的别名,表2的别名
from 表1 别名
[join type] 表2
on 连接条件
where 筛选条件


方式二：truncate
语法：truncate table 表名;
*/

#方式一:delete
#1.单表的删除
#案例1：删除手机号以9结尾的女神信息
DELETE FROM beauty WHERE phone LIKE '%9';
SELECT * FROM beauty;

#2.多表的删除
#案例：删除张无忌的女朋友信息

DELETE b 
FROM beauty b
INNER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`boyName` = '张无忌';

-- 子查询
DELETE FROM beauty
WHERE boyfriend_id = (
	SELECT id FROM boys
	WHERE boyName='张无忌'
); 

#删除黄晓明的信息以及他女朋友的信息
DELETE b,bo
FROM beauty b
INNER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`boyName` = '黄晓明';


#案例：将魅力值大于100的男神删除
TRUNCATE TABLE boys;

#delete pk truncate 【面试题☆】
/*
1.delete 可以加where条件,truncate不可以加
2.truncate删除,效率高一丢丢
3.假如要删除的表中有自增长列,如果用delete删除后,再插入数据
自增长列的值从断点开始,而truncate删除后,再插入数据,增长列的值
从1开始
4.truncate删除没有返回值,delete删除有返回值
5.truncate删除不能回滚,delete可以回滚
*/
DELETE FROM boys;
TRUNCATE TABLE boys;
INSERT INTO boys(boyname,usercp) VALUES('张飞',100),
										('刘备',200);

