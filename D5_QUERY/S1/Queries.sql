SELECT 'S1-A  : users' AS table_name,   (SELECT COUNT(*) FROM users) AS table_count   FROM DUAL UNION
SELECT 'S1-B/X: smartphones',           (SELECT COUNT(*) FROM smartphones           ) FROM DUAL UNION
SELECT 'S1-C  : websites',              (SELECT COUNT(*) FROM websites              ) FROM DUAL UNION
SELECT 'S1-D  : reviews',               (SELECT COUNT(*) FROM reviews               ) FROM DUAL UNION
SELECT 'S2-  : brands',                 (SELECT COUNT(*) FROM brands                ) FROM DUAL UNION
SELECT 'S2-  : brand_stores',           (SELECT COUNT(*) FROM brand_stores          ) FROM DUAL UNION
SELECT 'S2-  : sales',                  (SELECT COUNT(*) FROM sales                 ) FROM DUAL UNION
SELECT 'S2-  : promotions',             (SELECT COUNT(*) FROM promotions            ) FROM DUAL UNION
SELECT 'S2_  : addresses',              (SELECT COUNT(*) FROM addresses             ) FROM DUAL;