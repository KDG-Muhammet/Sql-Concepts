SELECT 'S1-A  : users' AS table_name, (SELECT COUNT(*) FROM users) AS table_count
FROM DUAL
UNION
SELECT 'S1-B  : smartphones', (SELECT COUNT(*) FROM smartphones)
FROM DUAL
UNION
SELECT 'S1-C  : websites', (SELECT COUNT(*) FROM websites)
FROM DUAL
UNION
SELECT 'S1-D  : reviews', (SELECT COUNT(*) FROM reviews)
FROM DUAL
UNION
SELECT 'S2-X  : brands', (SELECT COUNT(*) FROM brands)
FROM DUAL
UNION
SELECT 'S2-Y  : brand_stores', (SELECT COUNT(*) FROM brand_stores)
FROM DUAL
UNION
SELECT 'S2-Z  : sales', (SELECT COUNT(*) FROM sales)
FROM DUAL
UNION
SELECT 'S2-W  : promotions', (SELECT COUNT(*) FROM promotions)
FROM DUAL
UNION
SELECT 'S2_   : addresses', (SELECT COUNT(*) FROM addresses)
FROM DUAL;

------------------------------------ milestone 4 --------------------------------
BEGIN

    execute immediate 'ALTER PACKAGE PROJECT.PKG_S1_SMARTPHONES COMPILE BODY';
    execute immediate 'ALTER PACKAGE PROJECT.PKG_S2_SMARTPHONES COMPILE BODY';

    --S1
    PKG_S1_smartphones.empty_tables_s1();
    PKG_S1_SMARTPHONES.bewijs_milestone_M4_S1();
    --S2
    PKG_S2_smartphones.empty_tables_s2();
    PKG_S2_SMARTPHONES.bewijs_milestone_M4_S2();

    COMMIT;

end;

------------------------------------ milestone 5 --------------------------------
BEGIN

    PKG_S2_SMARTPHONES.GENERATE_ADDRESSES(1100);
    PKG_S2_SMARTPHONES.GENERATE_BRANDS(30);
    PKG_S2_SMARTPHONES.generate_brands_stores(30);
    PKG_S2_SMARTPHONES.GENERATE_PROMOTIONS(30);
    PKG_S2_SMARTPHONES.GENERATE_SALES(60);

    Commit;
end;

BEGIN
    --PKG_SAMEN_SMARTPHONES.bewijs_Random_M5();
    PKG_S1_SMARTPHONES.EMPTY_TABLES_S1();
    PKG_S1_SMARTPHONES.bewijs_milestone_5_S1(30000, 30000, 30000, 400000);
    PKG_S2_SMARTPHONES.EMPTY_TABLES_S2();
    PKG_S2_SMARTPHONES.bewijs_milestone_M5_S2();
    COMMIT;
end;

------------------------------------ milestone 7 --------------------------------
BEGIN
    --PKG_S1_smartphones.empty_tables_s1();
    PKG_S1_SMARTPHONES.BEWIJS_COMPARISON_SINGLE_BULK_S1(30000, 30000, 30000, 400000, FALSE);
    --PKG_S1_SMARTPHONES.bewijs_milestone_M4_S1();
    --PKG_S2_SMARTPHONES.bewijs_milestone_M7_S2();

end;

SELECT *
FROM SALES
ORDER BY DBMS_RANDOM.VALUE()
    FETCH FIRST 10 ROWS ONLY;


