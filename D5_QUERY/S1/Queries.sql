SELECT 'S1-A  : users' AS table_name,   (SELECT COUNT(*) FROM users) AS table_count   FROM DUAL UNION
SELECT 'S1-B  : smartphones',           (SELECT COUNT(*) FROM smartphones           ) FROM DUAL UNION
SELECT 'S1-C  : websites',              (SELECT COUNT(*) FROM websites              ) FROM DUAL UNION
SELECT 'S1-D  : reviews',               (SELECT COUNT(*) FROM reviews               ) FROM DUAL UNION
SELECT 'S2-X  : brands',                (SELECT COUNT(*) FROM brands                ) FROM DUAL UNION
SELECT 'S2-Y  : brand_stores',          (SELECT COUNT(*) FROM brand_stores          ) FROM DUAL UNION
SELECT 'S2-Z  : sales',                 (SELECT COUNT(*) FROM sales                 ) FROM DUAL UNION
SELECT 'S2-W  : promotions',            (SELECT COUNT(*) FROM promotions            ) FROM DUAL UNION
SELECT 'S2_  : addresses',              (SELECT COUNT(*) FROM addresses             ) FROM DUAL;

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