START TRANSACTION ;
DELIMITER $$
CREATE
    TRIGGER orientation_meeting AFTER INSERT
    on child
    FOR EACH ROW BEGIN
        INSERT INTO child_event (child_id, event_id, fee) VALUES(NEW.id, 21, 1);
    END $$
DELIMITER ;

INSERT INTO child (first_name, last_name) VALUES ('Billy', 'Johnson');
ROLLBACK ;
COMMIT ;
