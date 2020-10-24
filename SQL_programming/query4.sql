# shows what classes each teacher teaches
CREATE PROCEDURE teacher_classes()
SELECT teacher.first_name as 'teacher', GROUP_CONCAT(class.name) as 'class'
From class
JOIN class_schedule cs on class.id = cs.class_id
JOIN teacher ON teacher.id = cs.teacher_id
group by (teacher.first_name);

CALL teacher_classes();
COMMIT ;
