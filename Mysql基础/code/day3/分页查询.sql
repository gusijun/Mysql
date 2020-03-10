#进阶8 	分页查询 ★
/*
应用场景：当要显示的数据,一页显示不全,需要分页提交sql请求
语法：
	select 查询列表
	from 表名
	【join type join 表2
	on 连接条件
	where 筛选条件
	group by 分组字段
	having 分组后的筛选
	order by 排序的字段】
	limit 【offset,】size;
	
	offset 要显示条目的起始索引（其实索引从0开始）
	size 要显示的条目个数
	
特点：
	①limit语句放在查询语句的最后
	②公式
	要显示的页数是page,每页的条数是size
	select 查询列表 
	from 表
	limit (page-1)*size,size; 
	
	size = 10
	page     offset
	1	     0	
	2  	     10
	3	     20
*/

#案例：查询前5条员工信息
SELECT * FROM employees LIMIT 0,5;
SELECT * FROM employees LIMIT 5;

#案例2：查询第11条-第25条
SELECT * FROM employees LIMIT 10,15;

#案例：查询有奖金的员工的信息，并且工资较高的前10名显示出来
SELECT 
  * 
FROM
  employees 
WHERE `commission_pct` IS NOT NULL 
ORDER BY salary DESC 
LIMIT 10 ;














