SELECT 'S1-A : users ' as table_name , COUNT(*) as player_count FROM users;
SELECT 'S1-B : users ' as table_name , COUNT(*) as player_count FROM users;
SELECT 'S1-C : users ' as table_name , COUNT(*) as player_count FROM users;
SELECT 'S1-D : users ' as table_name , COUNT(*) as player_count FROM users;
SELECT 'S1_  : users ' as table_name , COUNT(*) as player_count FROM users;

SELECT 'S2-W : promotions ' as table_name,   COUNT(*) as brand_count FROM Promotion;
SELECT 'S2-X : brands ' as table_name,       COUNT(*) as brand_count FROM Brand;
SELECT 'S2-Y : brand_stores ' as table_name, COUNT(*) as brand_count FROM Brand_store;
SELECT 'S2-Z : sales ' as table_name,        COUNT(*) as brand_count FROM Sale;
SELECT 'S2_  : Addresses ' as table_name, COUNT(*) as brand_count FROM Address;


-- query 2 niveaus diep

SELECT brand_name, opening_date, employee_count , sale_date
FROM Brand b
JOIN Brand_store bs ON b.brand_id = bs.brand_id
JOIN Sale s ON bs.store_id = s.store_id
ORDER BY brand_name;

-- bewijs contraints

INSERT INTO Address (zip, city, street_number, street)
VALUES (-1000, 'Seoul', 100,'Samsung Street 1');

INSERT INTO Promotion (promotion_id, discount, name, start_date, end_date)
VALUES (1001, 150, 'Summer Sale', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'));




