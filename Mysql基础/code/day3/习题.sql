已知表stuinfo
id 学号
`name` 姓名
email  邮箱 john@126.com
gradeId 年级编号
sex  性别 男 女
age 年龄

已知表 grade 
id 年级编号
gradeName 年级名称

一、查询所有学员的邮箱用户名（注：有相中@前面的字符）

SELECT SUBSTR(email,1,INSTR(email,'@')-1) AS 用户名
FROM stuinfo;

二、查询男生和女生的个数
SELECT sex,COUNT(*) 个数 FROM stuinfo  GROUP BY sex;

 三、查询年龄>18岁的所有学名的姓名和年级名称
 SELECT `name`,gradeName FROM stuinfo s
 INNER JOIN grade g
 ON s.gradeId = g.id
 WHERE age > 18;

四、查询哪个年级的学生最小年龄>20岁
1.查询每个年级的最小年龄
SELECT MIN(age),gradeId FROM stuinfo GROUP BY gradeId;
2.在1的结果上筛选
SELECT MIN(age),gradeId FROM stuinfo 
GROUP BY gradeId 
HAVING MIN(age) > 20;

五、试说出查询语句涉及的所有的关键字,以及先后执行顺序DQL
SELECT 查询字段 		 ⑦
FROM 表名   			 ①
[JOIN TYPE] JOIN 表2   	 ②
ON 连接条件  			 ③
WHERE 筛选条件  		 ④
GROUP 分组   			 ⑤
HAVING 分组后的筛选  	 ⑥
ORDER BY 排序  			 ⑧
LIMIT 分页  				 ⑨
 








