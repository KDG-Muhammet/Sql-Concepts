begin
    PROJECT.PKG_S1_SMARTPHONES.EMPTY_TABLES_S1();
    PROJECT.PKG_S1_SMARTPHONES.BEWIJS_COMPARISON_SINGLE_BULK_S1(50000,50000,50000,500000,FALSE);
    END;

--Size before Partitions
select segment_name,
       segment_type,
       sum(bytes / 1024 / 1024)          MB,
       (select COUNT(*) FROM REVIEWS) as table_count
from dba_segments
where segment_name = 'REVIEWS'
group by segment_name, segment_type;

SELECT /*+ NOPARALLEL(r)*/ u.EMAIL, p.NAME, TITLE, CONTENT, POSTEDDATE, LIKES
FROM REVIEWS r
         JOIN USERS u ON r.REVIEW_USER_ID = u.USER_ID
         JOIN SMARTPHONES p ON r.REVIEW_PHONE_ID = p.PHONE_ID
WHERE RATING = 5
GROUP BY p.NAME, u.EMAIL, TITLE, CONTENT, POSTEDDATE, LIKES
ORDER BY LIKES DESC;

--Add Partitions
ALTER TABLE REVIEWS
    MODIFY
        PARTITION BY RANGE (rating) INTERVAL (1) (
        PARTITION RATED_0 VALUES LESS THAN (1),
        PARTITION RATED_1 VALUES LESS THAN (2),
        PARTITION RATED_2 VALUES LESS THAN (3),
        PARTITION RATED_3 VALUES LESS THAN (4),
        PARTITION RATED_4 VALUES LESS THAN (5),
        PARTITION RATED_5 VALUES LESS THAN (6));
COMMIT;

--Select with partitions
SELECT /*+ NOPARALLEL(r)*/ u.EMAIL, p.NAME, TITLE, CONTENT, POSTEDDATE, LIKES
FROM REVIEWS r
         JOIN USERS u ON r.REVIEW_USER_ID = u.USER_ID
         JOIN SMARTPHONES p ON r.REVIEW_PHONE_ID = p.PHONE_ID
WHERE RATING = 5
GROUP BY p.NAME, u.EMAIL, TITLE, CONTENT, POSTEDDATE, LIKES
ORDER BY LIKES DESC;

--Size after Partitions
select segment_name,
       segment_type,
       sum(bytes / 1024 / 1024)          MB,
       (select COUNT(*) FROM REVIEWS) as table_count
from dba_segments
where segment_name = 'REVIEWS'
group by segment_name, segment_type;


