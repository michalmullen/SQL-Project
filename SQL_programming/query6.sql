#shows children and their guardians
START TRANSACTION ;
CREATE PROCEDURE child_guardians()
SELECT c.first_name as 'child', GROUP_CONCAT(guardian.first_name) as 'guardian'
FROM guardian
JOIN child_guardian cg on guardian.id = cg.guardian_id
JOIN child c on c.id = cg.child_id
group by c.first_name;

CALL child_guardians();
COMMIT ;