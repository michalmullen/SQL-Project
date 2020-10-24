# counts the number of days a child was at the kindergarten based off of the child's ID
START TRANSACTION ;
CREATE PROCEDURE child_attendance (
 in id_child int(10)
)
SELECT child.first_name AS 'child', count(attendance.present) AS 'days present'
FROM child, attendance
where  child.id = id_child
and child.id = attendance.child_id
group by (child.id);

CALL child_attendance(20);
COMMIT ;