--Create Users
CREATE USER Gloria IDENTIFIED BY Password123!;
GRANT CREATE SESSION TO Gloria;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON heroes TO Maria WITH GRANT OPTION;
grant create any trigger, Alter any trigger to Gloria;

GRANT SELECT, UPDATE (team) ON playerteams TO Gloria; --TODO Change tables
--Create Views
drop view best3Reviews;
CREATE VIEW best3Reviews AS
SELECT u.USERID AS userID, u.NAME AS name, p.NAME AS smartphones.name, pt.team, pt.masterylevel --TODO change team and masterylevel
FROM players p
         JOIN playerTeams pt ON p.playerId = pt.playerId
         JOIN heroes h ON pt.heroId = h.heroId JOIN matches m ON pt.matchId = m.matchId
ORDER BY pt.masterylevel DESC FETCH FIRST 3 ROWS ONLY;

GRANT SELECT ON top3 TO PUBLIC;

CREATE PUBLIC SYNONYM top3MasteryLevels FOR top3; --AANPASSEN SYNONYM NAME
commit;
-- bewijzen user Gloria:
-- username
Select user from DUAL;

--Dictionary Tables
SELECT * FROM USER_SYS_PRIVS;
SELECT * FROM USER_TAB_PRIVS;
SELECT * FROM USER_COL_PRIVS;
--Synonym
SELECT * FROM top3MasteryLevels;
-- mogelijkheid tot aanpassingen aan heroes
UPDATE heroes
SET health = 250
WHERE name = 'Mercy';
-- terugzetten
UPDATE heroes
SET health = 200
WHERE name = 'Mercy';
-- voeg een attribuut toe aan de tabel
ALTER TABLE heroes
    ADD ability VARCHAR2(100);
select * from HEROES;
alter table HEROES drop column ability;
select * from HEROES;