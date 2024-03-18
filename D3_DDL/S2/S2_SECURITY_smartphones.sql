-- rolen en gebruikers

CREATE ROLE Y;
GRANT ALL ON Brand_stores TO Y;

CREATE ROLE Z;
GRANT INSERT, SELECT, DELETE ON Sales TO Z;

CREATE USER S2 IDENTIFIED BY mijnPasswoord1;
GRANT Y TO S2;
GRANT Z TO S2;

-- view

CREATE VIEW view1 as
SELECT brand_name, founding_date, opening_date
FROM Brands b
         JOIN Brand_stores bs ON b.brand_id = bs.brand_id;

GRANT INSERT ON Brands TO S2;

-----------

SELECT *
FROM ALL_USERS;

INSERT INTO view1 (brand_name, founding_date, opening_date)
VALUES ('new brand', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));
