--Create Users
DROP USER Gloria CASCADE;
CREATE USER Gloria IDENTIFIED BY Password1234;
GRANT CREATE SESSION TO Gloria;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON smartphones TO Gloria WITH GRANT OPTION;
GRANT CREATE ANY TRIGGER, ALTER ANY TRIGGER TO Gloria;
GRANT SELECT, UPDATE (RATING) ON reviews TO Gloria;
COMMIT;
--Create View
drop view best3;
CREATE VIEW best3 AS
SELECT u.USER_ID AS userID, u.FIRST_NAME AS userfirstname, p.NAME AS phonename, r.RATING
FROM users u
         JOIN reviews r ON u.USER_ID = r.review_user_ID
         JOIN smartphones p ON r.REVIEW_PHONE_ID = p.PHONE_ID JOIN websites w ON r.WEBSITE_ID = w.WEBSITE_ID
ORDER BY r.RATING DESC FETCH FIRST 3 ROWS ONLY;

GRANT SELECT ON best3 TO PUBLIC;

DROP SYNONYM best3Reviews;
CREATE PUBLIC SYNONYM best3Reviews FOR best3; --AANPASSEN SYNONYM NAME
commit;
-- Prove user Gloria exists:
SELECT * FROM ALL_USERS WHERE USERNAME = 'GLORIA';

--Dictionary Tables
SELECT * FROM USER_SYS_PRIVS;
SELECT * FROM USER_TAB_PRIVS;
SELECT * FROM USER_COL_PRIVS;
--Synonym
SELECT * FROM best3Reviews;


--Can edit Smartphones Table
UPDATE smartphones
SET SCREEN_DIAGONAL = 6.9
WHERE name = 'Samsung A52';
--Change back to original
UPDATE SMARTPHONES
SET SCREEN_DIAGONAL = 6.3
WHERE name = 'Samsung A52';


-- voeg een attribuut toe aan de tabel
ALTER TABLE WEBSITES
    ADD first_online DATE;
select * from WEBSITES;
alter table WEBSITES
    drop column first_online;
select * from WEBSITES;
COMMIT;