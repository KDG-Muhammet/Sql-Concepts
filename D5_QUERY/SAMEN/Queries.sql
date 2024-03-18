SELECT 'S1-A : users ' as table_name , COUNT(*) as player_count FROM users;
SELECT 'S1-B : users ' as table_name , COUNT(*) as player_count FROM users;
SELECT 'S1-C : users ' as table_name , COUNT(*) as player_count FROM users;
SELECT 'S1-D : users ' as table_name , COUNT(*) as player_count FROM users;
SELECT 'S1_  : users ' as table_name , COUNT(*) as player_count FROM users;

SELECT 'S2-W : promotions ' as table_name,   COUNT(*) as brand_count FROM Promotions;
SELECT 'S2-X : brands ' as table_name,       COUNT(*) as brand_count FROM Brands;
SELECT 'S2-Y : brand_stores ' as table_name, COUNT(*) as brand_count FROM Brand_stores;
SELECT 'S2-Z : sales ' as table_name,        COUNT(*) as brand_count FROM Sales;
SELECT 'S2_  : Addresses ' as table_name, COUNT(*) as brand_count FROM Addresses;


-- query 2 niveaus diep

SELECT brand_name, opening_date as brand_store_opening_date, employee_count , sale_date
FROM Brands b
JOIN Brand_stores bs ON b.brand_id = bs.brand_id
JOIN Sales s ON bs.store_id = s.store_id
ORDER BY brand_name;

-- bewijs contraints

INSERT INTO Addresses (zip, city, street_number, street)
VALUES (-1000, 'Seoul', 100,'Samsung Street 1');

INSERT INTO Promotions (promotion_id, discount, name, start_date, end_date)
VALUES (1001, 150, 'Summer Sale', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'));




