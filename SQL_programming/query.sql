# shows all the events the each child is registered for
CREATE PROCEDURE child_events()
SELECT child.first_name AS 'child name', child.last_name AS 'child surname', GROUP_CONCAT(event.name) AS 'event'
FROM child
JOIN child_event ON child.id = child_event.child_id
JOIN event ON event.id = child_event.event_id
GROUP BY (child.first_name);

CALL child_events();

COMMIT ;