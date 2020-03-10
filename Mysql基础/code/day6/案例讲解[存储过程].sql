#一、创建存储过程实现传入用户名和密码,插入到admin表中
DELIMITER $
CREATE PROCEDURE `insert`(IN userName VARCHAR(255),IN `password` VARCHAR(255))
BEGIN
	INSERT INTO admin(admin.`username`,admin.`password`) VALUES(userName,`password`);
END $

CALL `insert`('顾思君','nsdwm159')$

# ``慎用,一旦用着个调用存储过程的时候,也得是`insert`

#二、创建存储过程或函数传入女神编号,返回女神名称和电话
DELIMITER $
CREATE PROCEDURE M(IN beautyNo INT,OUT `name` VARCHAR(255),OUT phone VARCHAR(255))
BEGIN
	SELECT b.`name`,b.`phone`
	INTO `name`,phone
	FROM beauty b
	WHERE b.`id` = beautyNo;
END $


SET @name:=''$
SET @phone:=''$
CALL M(4,@name,@phone)$

#三、创建存储过程或函数实现传入两个女生生日,返回大小
DELIMITER $
CREATE PROCEDURE G(IN v1 DATETIME,IN v2 DATETIME,OUT `day` INT)
BEGIN
	SELECT DATEDIFF(v1,v2) INTO DAY;
END $

SET @day:=0$
CALL G('1998-02-03','1997-12-30',@day)$


#四、创建存储过程或函数实现传入一个日期,格式化成xx年xx月xx日并返回
DELIMITER $
CREATE PROCEDURE date_to_str(IN `date` DATETIME,OUT simpledate VARCHAR(255) )
 BEGIN
	SELECT DATE_FORMAT(`date`,'%y年%m月%d日') INTO simpledate;
 END $
 
 SET @simpledate:=''$
CALL date_to_str('1998-9-12',@simpledate)$

#创建存储过程或函数实现传入女神名称,返回女神 and 男神  格式的字符串
DELIMITER $
CREATE PROCEDURE Q(IN `name` VARCHAR(255),OUT str VARCHAR(255))
BEGIN
	DECLARE boyName VARCHAR(255);
	SELECT bo.`boyName` 
	INTO boyName
	FROM boys bo
	LEFT OUTER JOIN beauty b
	ON bo.`id` = b.`boyfriend_id`
	WHERE b.name = `name`;
	
	SELECT CONCAT(`name`,'  and  ',IFNULL(boyName,'Null')) INTO str;
END $

SET @str:=''$
CALL Q('柳岩',@str)$
SELECT @str$

#六、创建存储过程或函数,根据传入的条目数和起始索引,查询beauty表的记录
DELIMITER $
CREATE PROCEDURE W(IN `offset` INT,IN size INT)
BEGIN
	SELECT * FROM beauty
	LIMIT `offset`,size;
END $

CALL W(4,3)$





