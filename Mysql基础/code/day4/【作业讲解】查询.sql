1.每个专业的学生人数
SELECT `majorname`,COUNT(*) 学生人数 FROM student s
INNER JOIN `major` m
ON s.`majorid` = m.`majorid`
GROUP BY  s.`majorid`;
2.查询参加考试的学生中,每个学生的平均分、最高分
SELECT AVG(score),MAX(score),studentno
FROM result 
GROUP BY studentno;


3.查询姓为张的每个学生的最低分大于60的学号和姓名
#①查询姓为张的每个学生
SELECT `studentname` FROM student
WHERE `studentname` LIKE '张%';

SELECT s.`studentno`,s.`studentname`,MIN(score)
FROM `student` s
INNER JOIN `result` r
ON s.`studentno` = r.`studentno`
WHERE `studentname` LIKE '张%'
GROUP BY `studentname`
HAVING MIN(score) > 60;

4.查询专业生日在'1998-1-1'后的学生姓名、专业名称
SELECT studentname,majorname 
FROM student s
INNER JOIN major m
ON s.`majorid` = m.`majorid`
#where s.`borndate` > '1998-1-1';
WHERE DATEDIFF(borndate,'1998-1-1') > 0;

5.查询每个专业的男生人数和女生人数别人是多少

SELECT sex,majorname,COUNT(*) 人数
FROM student s
INNER JOIN major m
ON s.`majorid` = m.`majorid`
GROUP BY sex,`majorname`;

#方式二
SELECT m.majorname 专业,
(SELECT COUNT(*) FROM student WHERE sex = '男' AND majorid =  s.`majorid`)男,
(SELECT COUNT(*) FROM student WHERE sex = '女' AND majorid = s.`majorid`) 女
FROM student s
INNER JOIN major m
ON s.`majorid` = m.`majorid`
GROUP BY m.majorid;


6.查询专业和张翠山一样的学生的最低分
#①查询张翠山的专业id
SELECT `majorid` FROM `student` 
WHERE `studentname` = '张翠山';


SELECT MIN(r.score) 分数 FROM student s
INNER JOIN result r
ON s.`studentno` = r.`studentno`
WHERE s.`majorid` =  (	
	SELECT `majorid` FROM `student` 
	WHERE `studentname` = '张翠山'
)

-- 老师答案
#①查询张翠山的专业编号
SELECT majorid 
FROM student
WHERE studentname = '张翠山'

#②查询编号=①的所有学生编号
SELECT studentno FROM student
WHERE majorid = (
	SELECT majorid 
	FROM student
	WHERE studentname = '张翠山'
)
#③查询最低分
SELECT MIN(score) 
FROM result
WHERE studentno IN (
	SELECT studentno FROM student
		WHERE majorid = (
			SELECT majorid 
			FROM student
			WHERE studentname = '张翠山'
		)
)

7.查询大于60分的学生的姓名、密码、专业名
SELECT studentname,loginpwd,`majorname`
FROM student s
INNER JOIN major m
ON s.`majorid` = m.majorid
INNER JOIN result r
ON s.`studentno` = r.`studentno`
WHERE score > 60;

8.按邮箱位数分组,查询每组的学生个数
SELECT COUNT(*),LENGTH(email) FROM student
GROUP BY LENGTH(email);

9.查询学生名、专业名、分数
SELECT studentname,majorname,score
FROM student s
INNER JOIN major m
ON s.majorid = m.majorid
LEFT OUTER JOIN result r
ON s.studentno = r.studentno;

10.查询哪个专业没有学生,分别用左连接和右连接实现
SELECT `majorname` 
FROM `major` m
LEFT OUTER JOIN `student` s
ON s.`majorid` = m.`majorid`
WHERE  `studentno` IS NULL;

SELECT `majorname` 
FROM student s
RIGHT OUTER JOIN major m
ON s.`majorid` = m.`majorid`
WHERE  `studentno` IS NULL;
 
 11.查询没有成绩的学生人数
 SELECT COUNT(*) FROM student s
 LEFT OUTER JOIN result r
 ON s.`studentno` = r.`studentno`
 WHERE r.id IS NULL;
 
 
 
 
 
 



