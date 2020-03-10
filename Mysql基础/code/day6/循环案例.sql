/*
一、已知表stringontent
其中字段：
id 		自增长
content 	varchar(20)

向该表插入指定个数的,随机的字符串
*/

DROP TABLE IF EXISTS stringContent;
CREATE TABLE stringContent(
	id INT PRIMARY KEY AUTO_INCREMENT,
	content VARCHAR(255)
);

DROP PROCEDURE test_randstr_insert;
DELIMITER $
CREATE PROCEDURE test_randstr_insert(IN insertcount INT )
BEGIN
	DECLARE i INT DEFAULT 1; #定义一个循环变量i,来表示插入的次数
	DECLARE str VARCHAR(26) DEFAULT 'abcdefghijklmnopqrstuvwxyz';
	DECLARE startIndex INT DEFAULT 1; #代表起始索引
	DECLARE len INT; #代表截取的字符长度1-（26-startinex+1）
	WHILE i<=insertcount DO
		
		SET len = FLOOR(RAND()*(26-startIndex+1)+1); #产生一个随机的整数,代表截取的长度,
		SET startIndex = FLOOR(RAND()*26+1);#产生一个随机的整数,代表起始索引1-26
		INSERT INTO stringContent(content)  VALUES(SUBSTR(str,startIndex,len));	
		SET i = i+1; #循环变量更新
	END WHILE;
END $

CALL test_randstr_insert(10)$









