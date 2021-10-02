-- 1 a
SELECT * FROM course WHERE course.credits > 3;

-- 1 b
SELECT * FROM classroom WHERE (classroom.building='Watson' or classroom.building='Packard');

-- 1 c
SELECT * FROM course WHERE course.dept_name='Comp. Sci.';

-- 1 d
SELECT course.course_id,title,dept_name,credits,semester FROM course,section WHERE course.course_id=section.course_id and section.semester='Fall';

-- 1 e
SELECT* FROM student WHERE student.tot_cred>45 and student.tot_cred<90;

-- 1 f
SELECT * FROM student WHERE student.name~*'[aewiuoy]$';

-- 1 g
SELECT course.course_id, title, dept_name,credits,prereq_id FROM course,prereq WHERE prereq.course_id=course.course_id and prereq_id='CS-101';

-- 2 a
SELECT dept_name,avg(instructor.salary) FROM instructor group by dept_name order by avg(instructor.salary) asc;

-- 2 b
SELECT department.building,count(1) FROM department,course WHERE department.dept_name = course.dept_name GROUP BY department.building HAVING count(1)=(SELECT MAX(second.number) FROM (SELECT count(1) as number FROM department,course WHERE department.dept_name = course.dept_name group by department.building) as second);

-- 2 c
SELECT department.dept_name,count(1) FROM department,course WHERE department.dept_name = course.dept_name GROUP BY department.dept_name HAVING count(1)=(SELECT MIN(second.number) FROM (SELECT count(1) as number FROM department,course WHERE department.dept_name = course.dept_name group by department.dept_name) as second);

-- 2 d
SELECT DISTINCT student.id,student.name FROM student WHERE student.id IN (SELECT third.id FROM (SELECT student.id, count(1) as number FROM student,takes,course WHERE student.id=takes.id and takes.course_id=course.course_id and course.dept_name='Comp. Sci.' group by student.id)as third WHERE third.number>3);

-- 2 e
SELECT * FROM instructor WHERE instructor.dept_name='Biology' or instructor.dept_name='Philosophy' or instructor.dept_name='Music';

-- 2 f
SELECT DISTINCT instructor.id, instructor.name, instructor.dept_name, instructor.salary FROM instructor,teaches WHERE instructor.id=teaches.id and teaches.year=2018 and teaches.id NOT IN (SELECT DISTINCT instructor.id FROM instructor,teaches WHERE instructor.id=teaches.id and teaches.year=2017 );

-- 3 a
SELECT DISTINCT student.id,student.name,student.dept_name,student.tot_cred FROM student,takes,course WHERE student.id=takes.id and takes.course_id=course.course_id and course.dept_name='Comp. Sci.' and (takes.grade='A' or takes.grade='A-') group by (student.id,student.name,student.dept_name,student.tot_cred) order by student.name;

-- 3 b
SELECT * FROM instructor WHERE instructor.id in(SELECT advisor.i_id FROM advisor,student,takes WHERE advisor.s_id=student.id and takes.id=student.id and (takes.grade!='A' and takes.grade!='A-' and takes.grade!='B+' and takes.grade!='B' or takes.grade IS NULL));

-- 3 c
SELECT DISTINCT * FROM department WHERE department.dept_name NOT IN (SELECT DISTINCT department.dept_name FROM department,student,takes WHERE department.dept_name=student.dept_name and student.id=takes.id and (takes.grade='F' or takes.grade='C'));

-- 3 d
SELECT DISTINCT * FROM instructor WHERE instructor.id NOT IN (SELECT DISTINCT instructor.id FROM instructor,teaches,takes WHERE instructor.id=teaches.id and teaches.course_id=takes.course_id and takes.grade='A');

-- 3 e
SELECT DISTINCT course.course_id,course.title,course.dept_name, course.credits FROM course,section,time_slot WHERE section.time_slot_id=time_slot.time_slot_id and end_hr<=13 and section.course_id=course.course_id;
