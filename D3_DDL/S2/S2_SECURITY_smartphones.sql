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
SELECT b.brand_name, b.founding_date, bs.opening_date,bs.BRAND_ID
FROM Brands b
         JOIN Brand_stores bs ON b.brand_id = bs.brand_id;

GRANT INSERT ON Brands TO S2;
SELECT * from VIEW1;
-----------

SELECT *
FROM ALL_USERS
WHERE USERNAME = 'S2';

INSERT INTO view1 (brand_name, founding_date, opening_date, BRAND_ID)
VALUES ('new brand', TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('01-01-2025', 'DD-MM-YYYY'), (SELECT brand_id FROM brands WHERE brand_name = 'Apple'));
