# shows all the children that have not paid for an event fee and are registered for all the events
START TRANSACTION ;
CREATE PROCEDURE child_events()
SELECT child.first_name AS 'child name', child.last_name AS 'child surname', GROUP_CONCAT(event.name) AS 'event'
FROM child
JOIN child_event ON child.id = child_event.child_id
JOIN event ON event.id = child_event.event_id
WHERE fee = 0
GROUP BY (child.first_name);

CALL child_events();
COMMIT ;
