------------------------------------ milestone 8 --------------------------------
-- ik wil een overzicht zien van het aantal sales per promotion van een phone

--------Originele query
SELECT S.STORE_ID,
       Sm.NAME                                                                        AS SMARTPHONE_NAME,
       P.NAME                                                                         AS PROMOTION_NAME,
       SUM(S.DUE_DATES)                                                               AS TOTAL_SALE_VALUE,
       COUNT(S.SALE_ID)                                                               AS TOTAL_SALES,
       SUM(S.DUE_DATES) OVER (PARTITION BY S.STORE_ID ORDER BY SUM(S.DUE_DATES) DESC) AS CUMULATIVE_SALES,
       RANK() OVER (PARTITION BY S.STORE_ID ORDER BY SUM(S.DUE_DATES) DESC)           AS PROMOTION_RANK
FROM SALES S
         JOIN
     SMARTPHONES Sm ON Sm.PHONE_ID = S.PHONE_ID
         JOIN
     PROMOTIONS P ON P.PROMOTION_ID = S.PROMOTION_ID
WHERE Sm.NAME = 'Samsung Note 7'
GROUP BY S.STORE_ID, Sm.NAME, P.NAME
ORDER BY S.STORE_ID, PROMOTION_RANK;

------- Bereken de statistieken voor de tabel
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'SALES');
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'SMARTPHONES');
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'PROMOTIONS');
end;

select segment_name,
       segment_type,
       sum(bytes / 1024 / 1024)        MB,
       (select COUNT(*) FROM SALES) as table_count
from dba_segments
where segment_name = 'SALES'
group by segment_name, segment_type;
-- output voor sales met 633005 is 40mb

-------- Verkrijgen van het explain plan
EXPLAIN PLAN FOR
SELECT Sm.NAME AS smartphone_name, P.NAME AS promotion_name, COUNT(SALE_ID) AS sale_count
FROM SALES S
         JOIN SMARTPHONES Sm ON Sm.PHONE_ID = S.PHONE_ID
         JOIN PROMOTIONS P ON P.PROMOTION_ID = S.PROMOTION_ID
WHERE Sm.NAME = 'Samsung Note 7'
GROUP BY Sm.NAME, P.NAME;

-------- Bekijk het explain plan
SELECT *
FROM TABLE (DBMS_XPLAN.DISPLAY());

--------- Materialized View

GRANT CREATE TABLE TO PROJECT;
DROP MATERIALIZED VIEW mv1;
CREATE MATERIALIZED VIEW
    mv1
AS
SELECT Sm.NAME AS smartphone_name, P.NAME AS promotion_name, COUNT(SALE_ID) AS sale_count
FROM SALES S
         JOIN SMARTPHONES Sm ON Sm.PHONE_ID = S.PHONE_ID
         JOIN PROMOTIONS P ON P.PROMOTION_ID = S.PROMOTION_ID
WHERE Sm.NAME = 'Samsung Note 7'
GROUP BY Sm.NAME, P.NAME;

------- Bereken de statistieken voor de tabel
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'mv1');
end;

select segment_name,
       segment_type,
       sum(bytes / 1024 / 1024)      MB,
       (select COUNT(*) FROM mv1) as table_count
from dba_segments
where segment_name = 'MV1'
group by segment_name, segment_type;

------- Query opnieuw uitvoeren met de materialized view
SELECT smartphone_name, promotion_name, sale_count
FROM mv1
WHERE smartphone_name = 'Samsung Note 7';


------- Verkrijgen van het explain plan met mv
EXPLAIN PLAN FOR
SELECT smartphone_name, promotion_name, sale_count
FROM MV1
WHERE smartphone_name = 'Samsung Note 7';

------- Bekijk het explain plan
SELECT *
FROM TABLE (DBMS_XPLAN.DISPLAY());

-----------negatieve gevolgen----------

-- Voeg nieuwe gegevens toe aan de tabellen
INSERT INTO SALES (DUE_DATES, PHONE_ID, PROMOTION_ID, STORE_ID, NAME, SALE_DATE)
VALUES ( SYSDATE, 3, 1003, 1, 'Test view', SYSDATE);


-- Controleer of de nieuwe gegevens zichtbaar zijn in de materialized view
SELECT smartphone_name, promotion_name, sale_count
FROM mv1;

-- Vernieuw de materialized view en controleer opnieuw
BEGIN
    DBMS_MVIEW.REFRESH('MV1', 'C');
END;

SELECT smartphone_name, promotion_name, sale_count
FROM mv1;

