CREATE OR REPLACE PACKAGE BODY PKG_S1_smartphones AS

PROCEDURE empty_tables_S1 IS
BEGIN

    FOR all_constraints in (select table_name , constraint_name from user_constraints where constraint_type = 'R' AND OWNER = 'PROJECT' AND STATUS = 'ENABLED')
        LOOP
            EXECUTE IMMEDIATE 'ALTER TABLE ' || all_constraints.table_name || ' DISABLE CONSTRAINT ' || all_constraints.constraint_name;
        END LOOP;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE REVIEWS CASCADE';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE SALES CASCADE';
    EXECUTE IMMEDIATE 'ALTER TABLE SALES MODIFY(SALE_ID GENERATED AS IDENTITY (START WITH 1))';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE USERS CASCADE';
    EXECUTE IMMEDIATE 'ALTER TABLE USERS MODIFY(USER_ID GENERATED AS IDENTITY (START WITH 1))';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE SMARTPHONES CASCADE';
    EXECUTE IMMEDIATE 'ALTER TABLE SMARTPHONES MODIFY(PHONE_ID GENERATED AS IDENTITY (START WITH 1))';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE WEBSITES CASCADE';
    EXECUTE IMMEDIATE 'ALTER TABLE WEBSITES MODIFY(WEBSITE_ID GENERATED AS IDENTITY (START WITH 1))';
    EXECUTE IMMEDIATE 'PURGE RECYCLEBIN';

    for all_constraints in (select table_name , constraint_name from user_constraints where constraint_type = 'R' AND OWNER = 'PROJECT' AND STATUS = 'DISABLED')
        LOOP
            EXECUTE IMMEDIATE 'ALTER TABLE ' || all_constraints.table_name || ' ENABLE CONSTRAINT ' || all_constraints.constraint_name;
        END LOOP;

    IF (SELECT object_name, object_type FROM DBA_OBJECTS WHERE status = 'INVALID' AND owner = 'PROJECT') THEN
        EXECUTE IMMEDIATE 'ALTER PACKAGE PROJECT.PKG_S1_smartphones COMPILE BODY';
    END IF;



END empty_tables_S1;

    PROCEDURE add_smartphone(p_name IN VARCHAR2, p_releasedate IN DATE,
                             p_screendiagonal IN NUMBER(3,2), p_cameraamount IN NUMBER,
                             p_processorcores IN NUMBER, p_memory IN NUMBER,
                             p_storage IN NUMBER) IS
    BEGIN
        INSERT INTO SMARTPHONES (NAME, RELEASE_DATE, SCREEN_DIAGONAL, CAMERA_AMOUNT, PROCESSOR_CORES, MEMORY, STORAGE)
        VALUES (p_name, p_releasedate, p_screendiagonal, p_cameraamount, p_processorcores, p_memory, p_storage);
    END add_smartphone;

    PROCEDURE add_user(p_firstname IN VARCHAR2, p_lastname IN VARCHAR2,
                       p_email IN VARCHAR2, p_phonenumber IN VARCHAR2,
                       p_birthdate IN DATE) IS
    BEGIN
        INSERT INTO USERS (FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, BIRTHDATE)
        VALUES (p_firstname, p_lastname, p_email, p_phonenumber, p_birthdate);
    END add_user;

    PROCEDURE add_website(p_webaddress IN VARCHAR2, p_name IN VARCHAR2,
                          p_yearlyusers IN NUMBER, p_mobileapp IN CHAR,
                          p_servercountry IN VARCHAR2) IS
    BEGIN
        INSERT INTO WEBSITES (WEB_ADDRESS, NAME, YEARLY_USERS, MOBILE_APP, SERVER_COUNTRY)
        VALUES (p_webaddress, p_name, p_yearlyusers, p_mobileapp, p_servercountry);
    END add_website;

    PROCEDURE add_review(p_userid IN NUMBER, p_phoneid IN NUMBER,
                         p_websiteid IN NUMBER, p_posteddate IN DATE,
                         p_title IN VARCHAR2, p_content IN VARCHAR2,
                         p_likes IN NUMBER, p_rating IN NUMBER,
                         p_lastediteddate IN DATE) IS
    BEGIN
        INSERT INTO REVIEWS (REVIEW_USER_ID, REVIEW_PHONE_ID, WEBSITE_ID, POSTEDDATE, TITLE, CONTENT, LIKES, RATING, LAST_EDITED_DATE)
        VALUES (p_userid, p_phoneid, p_websiteid, p_posteddate, p_title, p_content, p_likes, p_rating, p_lastediteddate);
    END add_review;

    FUNCTION lookup_smartphone(p_phonename IN VARCHAR2, p_memory IN NUMBER, p_storage IN NUMBER) RETURN NUMBER AS v_phone_id NUMBER;
    BEGIN
        SELECT phone_id INTO v_phone_id
        FROM smartphones
        WHERE name = p_phonename AND memory = p_memory AND storage = p_storage;
        return v_phone_id;
    END lookup_smartphone;

    FUNCTION lookup_website(p_url IN VARCHAR2) RETURN NUMBER AS v_website_id NUMBER;
    BEGIN
        SELECT website_id INTO v_website_id
        FROM websites
        WHERE WEB_ADDRESS = p_url;
        return v_website_id;
    END lookup_website;

    FUNCTION lookup_user(p_email IN VARCHAR2, p_firstname IN VARCHAR2, p_lastname IN VARCHAR2) RETURN NUMBER AS v_user_id NUMBER;
    BEGIN
        SELECT user_id INTO v_user_id
        FROM users
        WHERE email = p_email
          AND first_name = p_firstname
          AND last_name = p_lastname;
        return v_user_id;
    END lookup_user;

    FUNCTION lookup_review(p_user_id IN NUMBER, p_phone_id IN NUMBER, p_website_id IN NUMBER) RETURN NUMBER AS v_review_id NUMBER;
    BEGIN
        SELECT review_id INTO v_review_id
        FROM reviews
        WHERE user_id = p_user_id
          AND phone_id = p_phone_id
          AND website_id = p_website_id;
        return v_review_id;
    END lookup_review;

END PKG_S1_smartphones;

