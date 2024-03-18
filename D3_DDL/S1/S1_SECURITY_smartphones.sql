--Create Users
CREATE USER Gloria IDENTIFIED BY Password123;
GRANT CREATE SESSION TO Gloria;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON smartphones TO Gloria WITH GRANT OPTION;
grant create any trigger, Alter any trigger to Gloria;

--Create Views
drop view best3;
CREATE VIEW best3 AS
SELECT u.USER_ID AS userID, u.FIRST_NAME AS userfirstname, p.NAME AS phonename, r.RATING --TODO change team and masterylevel
FROM users u
         JOIN reviews r ON u.USER_ID = r.review_user_ID
         JOIN smartphones p ON r.REVIEW_PHONE_ID = p.PHONE_ID JOIN websites w ON r.WEBSITE_ID = w.WEBSITE_ID
ORDER BY r.RATING DESC FETCH FIRST 3 ROWS ONLY;

GRANT SELECT ON best3 TO PUBLIC;

CREATE PUBLIC SYNONYM best3Reviews FOR best3; --AANPASSEN SYNONYM NAME
commit;
-- bewijzen user Gloria:
-- username
Select user from DUAL;

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