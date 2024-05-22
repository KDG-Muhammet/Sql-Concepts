------------------------------------ milestone 8 --------------------------------

-- ik wil een overzicht zien van het aantal sales per promotion per store van een phone
EXPLAIN PLAN FOR
SELECT Sm.NAME, p.NAME, COUNT(SALE_ID),STORE_ID
from SALES S
         join SMARTPHONES Sm on Sm.PHONE_ID = S.PHONE_ID
         join PROJECT.PROMOTIONS P on P.PROMOTION_ID = S.PROMOTION_ID
where Sm.NAME = 'Samsung Note 7'
group by sm.NAME, P.NAME ,STORE_ID;

-- Bekijk het explain plan
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());

BEGIN
    DBMS_STATS.GATHER_TABLE_STATS('PROJECT', 'SALES');
end;

select segment_name,
       segment_type,
       sum(bytes / 1024 / 1024)        MB,
       (select COUNT(*) FROM SALES) as table_count
from dba_segments
where segment_name = 'SALES'
group by segment_name, segment_type;
-- output voor sales met 633005 is 40mb


GRANT CREATE TABLE TO PROJECT;
-- Materialized View
CREATE MATERIALIZED VIEW
    mv1
            BUILD IMMEDIATE
    REFRESH ON DEMAND AS
SELECT Sm.NAME, p.NAME, COUNT(SALE_ID),STORE_ID
from SALES S
         join SMARTPHONES Sm on Sm.PHONE_ID = S.PHONE_ID
         join PROJECT.PROMOTIONS P on P.PROMOTION_ID = S.PROMOTION_ID
where Sm.NAME = 'Samsung Note 7'
group by sm.NAME, P.NAME ,STORE_ID;

-- Query opnieuw uitvoeren met de materialized view
EXPLAIN PLAN FOR
SELECT * FROM PROJECT.MV1;

-- Bekijk het explain plan
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());