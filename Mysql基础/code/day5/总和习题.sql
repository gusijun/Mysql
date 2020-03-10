#1.创建Book表,字段如下
bid 整型,要求主键
bname	字符型,要求设置唯一键,并非空
price 	浮点型,要求有默认值10
btypeId 	类型编号,要求引用bookType表的id字段

已知bookType 表(不用创建),字段如下
id
`name`

CREATE TABLE bookType(
	id INT PRIMARY KEY,
	`name` VARCHAR(255)
);
INSERT INTO bookType VALUES(1,'古书');
INSERT INTO bookType VALUES(2,'文书');
SELECT * FROM bookType;

CREATE TABLE Book(
	id INT PRIMARY KEY,
	bname VARCHAR(255) UNIQUE NOT NULL,
	price DOUBLE DEFAULT 10,
	btypeId INT,
	CONSTRAINT fk_Book_bookType FOREIGN KEY(btypeId)  REFERENCES bookType(id)
)

#2.开启事务,向表中插入1行数据,并结束
TRUNCATE TABLE book;
SET autocommit = 0;
START TRANSACTION;
INSERT INTO Book VALUES
(1,'凉生可不可以不忧伤',1000,1),
(2,'那些年',2000,2),
(3,'梦回少年时',800,2);
COMMIT;
SELECT * FROM Book;
#3.创建视图,实现查询价格>100的书名和类型
CREATE OR REPLACE VIEW v
AS 
SELECT bname,`name`
FROM book b
INNER JOIN bookType bt
ON b.btypeId = bt.id
WHERE b.price > 100;

SELECT * FROM v;
#4.修改视图,实现查询价格在1-1500的书名和类型
ALTER VIEW v
AS
SELECT bname,`name`
FROM book b
INNER JOIN bookType bt
ON b.btypeId = bt.id
WHERE b.price > 1 AND b.price < 1500;

SELECT * FROM v;

#5.删除刚才的视图
DROP VIEW v;
