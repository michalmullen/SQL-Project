# shows all teachers schedule, shows class, what day the class will be taught and at what time
# can add additions to this command such as "where teacher.id = 1" go get more specific data
CREATE PROCEDURE teacher_class_schedul()
SELECT teacher.first_name as 'teacher', class.name as 'class', day.name as 'day', cs.start_time as 'start', cs.end_time as 'end'
From class
JOIN class_schedule cs on class.id = cs.class_id
JOIN teacher ON teacher.id = cs.teacher_id
JOIN day on day.id = cs.day_id
group by (cs.id);

CALL teacher_class_schedul();
COMMIT ;