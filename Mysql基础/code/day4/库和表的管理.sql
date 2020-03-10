#DDL
/*
数据定义语言
库和表的管理操作
一、库的管理
创建、修改、删除
二、表的管理
创建、修改、删除

创建：create
修改： alter
删除： drop
*/
#一、库的管理
#1.库的创建
/*
语法
create database [if not exists]库名；
*/
#案例：创建库Books
CREATE  DATABASE IF NOT EXISTS Books;

#2.库的修改

#更改库的字符集
ALTER DATABASE booksplus CHARACTER SET gbk;

#3.库的删除
DROP DATABASE IF EXISTS  books;

#二、表的管理
#1.表的创建 ☆
/*
语法：
create table 表名(
	列名 列的类型【(长度) 约束】,
	列名 列的类型【(长度) 约束】,
	....
	列名 列的类型【(长度) 约束】
)
*/

#案例:创建表Books
CREATE TABLE book(
	id  INT, #编号
	`name` VARCHAR(20), #图书名
	price DOUBLE,      #价格
	autherId INT, #作者编号 
	publishDate DATETIME#出版日期
);


DESC book;

#案例：创建author
CREATE TABLE IF NOT EXISTS author(
	id INT,
	au_name VARCHAR(20),
	nation VARCHAR(10)
)

DESC author;

#2.表的修改
/*
语法：
alter table 表名 add | drop | modify | change   column 列名 [列类型 约束]
*/
#1）修改列名
ALTER TABLE book CHANGE  COLUMN publishDate pubDate DATETIME;
#2）修改列的类型或约束
ALTER TABLE book MODIFY COLUMN pubDate TIMESTAMP;
#3）添加新列
ALTER TABLE author ADD COLUMN annual DOUBLE;
#4）删除列
ALTER TABLE author DROP COLUMN  annual;
#5）修改表名
ALTER TABLE author RENAME TO `authors`;

#3.表的删除
DROP TABLE IF EXISTS `authors`;
SHOW TABLES;

#通用的写法:
DROP DATABASE IF EXISTS 旧库名；
CREATE DATABASE 新库名；

DROP TABLE IF EXISTS 旧表名；
CREATE TABLE 新表名()；

#4.表的复制
INSERT INTO author VALUES
(1,'顾思君','中国'),
(2,'古俊','日本'),
(3,'马明锦','中国') 

SELECT * FROM author;
SELECT * FROM copy2;
#1.仅仅复制表的结构
CREATE TABLE copy LIKE author;
#2.复制表的结构+数据
CREATE TABLE copy2 
SELECT * FROM author;

#3.只复制部分数据
CREATE TABLE copy3
SELECT id,au_name
FROM author
WHERE nation = '中国';

#仅仅复制某些字段
CREATE TABLE cpoy4
SELECT id,au_name
FROM author 
WHERE 0; # 1= 2






