#删除外键
ALTER TABLE stuinfo DROP FOREIGN KEY fk_stuinfo_major;

#传统的方式设置外键
ALTER TABLE stuinfo ADD CONSTRAINT fk_stuinfo_major 
FOREIGN KEY(majorId) REFERENCES major(id);


SHOW INDEX FROM stuinfo;


SELECT * FROM major;
SELECT * FROM stuinfo;

INSERT INTO major VALUES(1,'Java'),(2,'PHP'),(3,'大数据');
INSERT INTO stuinfo 
SELECT 1,'John1','女',NULL,NULL,1 UNION ALL
SELECT 2,'John2','女',NULL,NULL,2 UNION ALL
SELECT 3,'John3','女',NULL,NULL,3 UNION ALL
SELECT 4,'John4','女',NULL,NULL,1 UNION ALL
SELECT 5,'John5','女',NULL,NULL,2 UNION ALL
SELECT 6,'John6','女',NULL,NULL,1 UNION ALL
SELECT 7,'John7','女',NULL,NULL,2 UNION ALL
SELECT 8,'John8','女',NULL,NULL,3 




#方式一：级联删除
ALTER TABLE stuinfo ADD CONSTRAINT fk_stuinfo_major 
FOREIGN KEY(majorId) REFERENCES major(id) ON DELETE CASCADE;


#删除专业表的3号专业
DELETE FROM major WHERE id = 3;

#方式二：级联置空
ALTER TABLE stuinfo ADD CONSTRAINT fk_stuinfo_major 
FOREIGN KEY(majorId) REFERENCES major(id) ON DELETE SET NULL;

#删除专业表的2号专业
DELETE FROM major WHERE id = 2;


