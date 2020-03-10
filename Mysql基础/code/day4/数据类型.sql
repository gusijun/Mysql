#常见的数据类型
/*
数值型：
	整型
	小数：
		定点数
		浮点数
字符型：
	较短的文本：char,varchar	
	较长的文本：text、blob(较长的二进制数据)
日期型：
	
*/

#一、整型
/*
分类：
tinyint,smallint,mediumint,int/Integer,bigint
 1	       	2    		    3		   	4		 8
 
 特点：
 ①如果不设置无符号还是有符号,默认是有符号
  如果想设置无符号,需要添加unsigned关键字 
 ②如果插入的设置超出整型的范围,会报out of range异常,并且插入的是临界值
 ③如果不设置长度会有默认的长度
 长度代表了显示的最小宽度,如果不够会用0在左边填充
 但必须搭配zerofill使用（加了zerofill就会变成unsigned）
*/

#1.如何设置无符号和有符号
DROP TABLE IF EXISTS tab_int;
CREATE TABLE tab_int(
	t1 INT (7) ZEROFILL,
	t2 INT(7) ZEROFILL 
);

DESC tab_int;
INSERT INTO tab_int VALUES(-123456);
INSERT INTO tab_int VALUES(-123456,-123456);
INSERT INTO tab_int VALUES(214783648,4294967296);

INSERT INTO tab_int VALUES(123,123);

SELECT * FROM tab_int;

#二、小数
/*
分类：
1.浮点型
float(M,D)
double(M,D)
2.定点型
dec(M,D)
decimal(M,D)


特点：
①M和D
M：整数部位+小数部位
D：小数部位
如果超过范围,则插入临界值
②M和D都可以省略
如果是decimal,则M默认是10,D默认是0
如果是float和double,则会根据插入数值的精度来决定精度
③定点型的精确度较高,如果要求插入数值的精度较高如货币运算等
则考虑使用
*/

#测试M和D
DROP TABLE  IF EXISTS tab_float; 
CREATE TABLE tab_float(
	f1 FLOAT,
	f2 DOUBLE,
	f3 DECIMAL
);

SELECT * FROM tab_float;
DESC tab_float;
INSERT INTO tab_float VALUES(127873.45,147823.45,17878723.45);
INSERT INTO tab_float VALUES(123.456,123.456,123.456);
INSERT INTO tab_float VALUES(1523.4,1523.4,1523.4);


#原则：
/*
所选择的类型越简单越好,能保存数值的类型越小越好
*/

#三、字符型
/*
较短的文本：
char
varchar

其他：
binary和varbinary用于保存较短的二进制
enum保存枚举
set保存集合
较长的文本：
text
blob(保存较大的二进制)

特点：
		写法 		M的意思							特点			空间的耗费情况	效率
char         cahar(M)	最大的字符数,可以省略,默认为1	固定长度的字符	比较耗费		高
varchar   varchar(M)	最大的字符数,不可省略			可变长度的字符	比较节省		低
*/



CREATE TABLE tab_char(
	c1 ENUM('顾思君','古俊','马明锦')
);

INSERT INTO tab_char VALUES('顾思君');
INSERT INTO tab_char VALUES('古俊');
INSERT INTO tab_char VALUES('马明锦');
INSERT INTO tab_char VALUES('A');

INSERT INTO tab_char VALUES('古俊');
SELECT * FROM tab_char;

CREATE TABLE tab_set(
	s1 SET('顾思君','古俊','马明锦')
);

INSERT INTO tab_set VALUES('古俊');
INSERT INTO tab_set VALUES('马明锦,古俊')


SELECT * FROM tab_set;#常见的数据类型
/*
数值型：
	整型
	小数：
		定点数
		浮点数
字符型：
	较短的文本：char,varchar	
	较长的文本：text、blob(较长的二进制数据)
日期型：
	
*/

#一、整型
/*
分类：
tinyint,smallint,mediumint,int/Integer,bigint
 1	       	2    		    3		   	4		 8
 
 特点：
 ①如果不设置无符号还是有符号,默认是有符号
  如果想设置无符号,需要添加unsigned关键字 
 ②如果插入的设置超出整型的范围,会报out of range异常,并且插入的是临界值
 ③如果不设置长度会有默认的长度
 长度代表了显示的最小宽度,如果不够会用0在左边填充
 但必须搭配zerofill使用（加了zerofill就会变成unsigned）
*/

#1.如何设置无符号和有符号
DROP TABLE IF EXISTS tab_int;
CREATE TABLE tab_int(
	t1 INT(7) ZEROFILL,
	t2 INT(7) ZEROFILL 
);

DESC tab_int;
INSERT INTO tab_int VALUES(-123456);
INSERT INTO tab_int VALUES(-123456,-123456);
INSERT INTO tab_int VALUES(214783648,4294967296);

INSERT INTO tab_int VALUES(123,123);

SELECT * FROM tab_int;

#二、小数
/*
分类：
1.浮点型
float(M,D)
double(M,D)
2.定点型
dec(M,D)
decimal(M,D)


特点：
①M和D
M：整数部位+小数部位
D：小数部位
如果超过范围,则插入临界值
②M和D都可以省略
如果是decimal,则M默认是10,D默认是0
如果是float和double,则会根据插入数值的精度来决定精度
③定点型的精确度较高,如果要求插入数值的精度较高如货币运算等
则考虑使用
*/

#测试M和D
DROP TABLE  IF EXISTS tab_float; 
CREATE TABLE tab_float(
	f1 FLOAT,
	f2 DOUBLE,
	f3 DECIMAL
);

SELECT * FROM tab_float;
DESC tab_float;
INSERT INTO tab_float VALUES(127873.45,147823.45,17878723.45);
INSERT INTO tab_float VALUES(123.456,123.456,123.456);
INSERT INTO tab_float VALUES(1523.4,1523.4,1523.4);


#原则：
/*
所选择的类型越简单越好,能保存数值的类型越小越好
*/

#三、字符型
/*
较短的文本：
char
varchar

其他：
binary和varbinary用于保存较短的二进制
enum保存枚举
set保存集合
较长的文本：
text
blob(保存较大的二进制)

特点：
		写法 		M的意思							特点			空间的耗费情况	效率
char         cahar(M)	最大的字符数,可以省略,默认为1	固定长度的字符	比较耗费		高
varchar   varchar(M)	最大的字符数,不可省略			可变长度的字符	比较节省		低
*/



CREATE TABLE tab_char(
	c1 ENUM('顾思君','古俊','马明锦')
);

INSERT INTO tab_char VALUES('顾思君');
INSERT INTO tab_char VALUES('古俊');
INSERT INTO tab_char VALUES('马明锦');
INSERT INTO tab_char VALUES('A');

INSERT INTO tab_char VALUES('古俊');
SELECT * FROM tab_char;

CREATE TABLE tab_set(
	s1 SET('顾思君','古俊','马明锦')
);

INSERT INTO tab_set VALUES('古俊');
INSERT INTO tab_set VALUES('马明锦,古俊')


SELECT * FROM tab_set;

#四、日期型
/*
分类：
date:只保存日期
time:只保存时间
year:只保存年

datetime:保存日期+时间
timestamp:保存日期+时间

特点：		字节	范围		时区等的影响
datetime	8		1000-9999	不受
timestamp	4		1970-2038	受
*/
CREATE TABLE  tab_date(
	t1 DATETIME,
	t2 TIMESTAMP
);

INSERT INTO tab_date VALUES(NOW(),NOW());

SELECT * FROM tab_date;

SHOW VARIABLES LIKE 'time_zone';

SET time_zone = '+9:00';





