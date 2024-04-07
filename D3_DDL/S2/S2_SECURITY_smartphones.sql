-- rolen en gebruikers
CREATE ROLE Y;
GRANT ALL ON Brand_stores TO Y;

CREATE ROLE Z;
GRANT INSERT, SELECT, DELETE ON Sales TO Z;

CREATE USER S2 IDENTIFIED BY mijnPasswoord1;
GRANT Create session to S2;
GRANT Y TO S2;
GRANT Z TO S2;


-- view
drop view view1;
CREATE OR REPLACE VIEW  view1 AS
SELECT s.SALE_ID, s.DUE_DATES, s.NAME, s.SALE_DATE, s.PHONE_ID, s.PROMOTION_ID, s.STORE_ID , bs.CLOSING_DATE, bs.ADDRESS_ID
FROM SALES s
         JOIN BRAND_STORES bs ON s.STORE_ID = bs.STORE_ID;

GRANT INSERT ON view1 TO S2;
GRANT SELECT ON view1 TO S2;
GRANT SELECT ON SMARTPHONES TO S2;
GRANT SELECT ON PROMOTIONS TO S2;
GRANT SELECT ON ADDRESSES TO S2;

SELECT *
from  view1;

------user
SELECT *
FROM ALL_USERS
WHERE USERNAME = 'S2';

-- Objecten waar de gebruiker toegang toe heeft
SELECT * FROM USER_OBJECTS;

-- Toegangsrechten van de gebruiker op tabellen
SELECT * FROM USER_TAB_PRIVS ;

-- Systeemprivileges van de gebruiker
SELECT * FROM USER_SYS_PRIVS ;

INSERT INTO view1 (DUE_DATES, NAME, SALE_DATE, PHONE_ID, PROMOTION_ID, STORE_ID)
VALUES (TO_DATE('01-01-2010', 'DD-MM-YYYY'), 'user2',
        TO_DATE('01-01-2010', 'DD-MM-YYYY'), (SELECT phone_ID FROM smartphones WHERE name = 'iPhone 15'),
        (SELECT promotion_id FROM PROMOTIONS WHERE name = 'Summer Sale'), (SELECT store_id
                                                                           FROM BRAND_STORES
                                                                           WHERE ADDRESS_ID =
                                                                                 (SELECT address_id
                                                                                  FROM ADDRESSES
                                                                                  WHERE zip = 12345
                                                                                    AND street = 'Broadway'
                                                                                    AND street_number = 100))
                                                                    );
COMMIT;
