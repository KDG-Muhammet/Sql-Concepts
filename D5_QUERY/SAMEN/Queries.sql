SELECT 'S1-A  : users' AS table_name,   (SELECT COUNT(*) FROM users) AS table_count   FROM DUAL UNION
SELECT 'S1-B  : smartphones',           (SELECT COUNT(*) FROM smartphones           ) FROM DUAL UNION
SELECT 'S1-C  : websites',              (SELECT COUNT(*) FROM websites              ) FROM DUAL UNION
SELECT 'S1-D  : reviews',               (SELECT COUNT(*) FROM reviews               ) FROM DUAL UNION
SELECT 'S2-X  : brands',                (SELECT COUNT(*) FROM brands                ) FROM DUAL UNION
SELECT 'S2-Y  : brand_stores',          (SELECT COUNT(*) FROM brand_stores          ) FROM DUAL UNION
SELECT 'S2-Z  : sales',                 (SELECT COUNT(*) FROM sales                 ) FROM DUAL UNION
SELECT 'S2-W  : promotions',            (SELECT COUNT(*) FROM promotions            ) FROM DUAL UNION
SELECT 'S2_  : addresses',              (SELECT COUNT(*) FROM addresses             ) FROM DUAL;


--S1
--User Reviews about Smartphones
SELECT u.FIRST_NAME, p.NAME, r.RATING
FROM users u
         JOIN reviews r ON u.USER_ID = r.review_user_ID
         JOIN smartphones p ON r.REVIEW_PHONE_ID = p.PHONE_ID;

--User Reviews on Websites
SELECT u.FIRST_NAME, r.POSTEDDATE, w.NAME, w.WEB_ADDRESS
FROM users u
         JOIN reviews r ON u.USER_ID = r.review_user_ID
         JOIN websites w ON r.WEBSITE_ID = w.WEBSITE_ID;

--Test Web Address format constraint
INSERT INTO websites (NAME, WEB_ADDRESS) VALUES ('Test', 'w.test');

--Test Review Rating constraint
INSERT INTO reviews (REVIEW_USER_ID,REVIEW_PHONE_ID, RATING, POSTEDDATE, WEBSITE_ID, TITLE, CONTENT)
VALUES (1,1,6,to_date('19-03-2024','DD-MM-YYYY'), 1, 'Test Review', 'Test Content');


--S2
-- query 2 niveaus diep

SELECT brand_name, opening_date as brand_store_opening_date, employee_count , sale_date, p.name as name_promotion, DISCOUNT
FROM Brands b
JOIN Brand_stores bs ON b.brand_id = bs.brand_id
JOIN Sales s ON bs.store_id = s.store_id
JOIN PROMOTIONS p on s.PROMOTION_ID = p.PROMOTION_ID
ORDER BY brand_name;

-- query brand_store address sale

SELECT city, STREET, STREET_NUMBER, opening_date as brand_store_opening_date, employee_count , sale_date
FROM ADDRESSES a
         JOIN BRAND_STORES bs ON a.ADDRESS_ID = bs.ADDRESS_ID
         JOIN Sales s ON bs.store_id = s.store_id
ORDER BY CITY;


-- bewijs contraints

INSERT INTO Addresses (zip, city, street_number, street)
VALUES (-1000, 'Seoul', 100,'Samsung Street 1');

INSERT INTO Promotions (promotion_id, discount, name, start_date, end_date)
VALUES (1001, 150, 'Summer Sale', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'));




