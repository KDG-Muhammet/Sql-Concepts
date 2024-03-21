-- rolen en gebruikers

CREATE ROLE Y;
GRANT ALL ON Brand_stores TO Y;

CREATE ROLE Z;
GRANT INSERT, SELECT, DELETE ON Sales TO Z;

CREATE USER S2 IDENTIFIED BY mijnPasswoord1;
GRANT Y TO S2;
GRANT Z TO S2;

-- view
CREATE OR REPLACE VIEW view1 AS
SELECT bs.OPENING_DATE, bs.EMPLOYEE_COUNT, bs.ADDRESS_ID, bs.BRAND_ID
FROM Brands b
         JOIN Brand_stores bs ON b.brand_id = bs.brand_id;

GRANT INSERT ON Brands TO S2;
SELECT *
from VIEW1;
-----------

SELECT *
FROM ALL_USERS
WHERE USERNAME = 'S2';

INSERT INTO view1 (OPENING_DATE,EMPLOYEE_COUNT , ADDRESS_ID, BRAND_ID)
VALUES (TO_DATE('01-01-2024', 'DD-MM-YYYY'), 50 ,
        (SELECT address_id FROM addresses WHERE zip = 12345 AND street = 'Broadway' AND street_number = 100),
        (SELECT brand_id FROM brands WHERE brand_name = 'Apple'));
