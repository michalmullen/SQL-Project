# child and teacher count
START TRANSACTION ;
CREATE PROCEDURE child_teacher_count()
SELECT
  (SELECT COUNT(*) FROM child WHERE child.id) as 'child',
  (SELECT COUNT(*) FROM teacher WHERE teacher.id) as 'teacher';

CALL child_teacher_count();
COMMIT ;
