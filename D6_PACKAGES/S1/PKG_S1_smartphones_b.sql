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

    DECLARE
        v_invalid_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_invalid_count
        FROM DBA_OBJECTS
        WHERE status = 'INVALID' AND owner = 'PROJECT';

        IF v_invalid_count > 0 THEN
            EXECUTE IMMEDIATE 'ALTER PACKAGE PROJECT.PKG_S1_smartphones COMPILE BODY';
        END IF;
    END;



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

    FUNCTION lookup_user(p_email IN VARCHAR2, p_phonenumber IN NUMBER) RETURN NUMBER AS v_user_id NUMBER;
    BEGIN
        SELECT user_id INTO v_user_id
        FROM users
        WHERE email = p_email
          AND phone_number = p_phonenumber;
        return v_user_id;
    END lookup_user;

    PROCEDURE bewijs_milestone_M4_S1 IS
    BEGIN
        add_website('www.tweakers.net', 'Tweakers', 726511, 'N', 'Netherlands');
        add_website('www.samsung.be', 'Samsung Belgium', 278309, 'Y', 'Japan');
        add_website('www.bol.com', 'Bol', 762579, 'Y', 'Netherlands');
        add_website('www.mediamarkt.be', 'Mediamarkt', 202813, 'N', 'Belgium');
        add_website('www.coolblue.be', 'Coolblue', 625138, 'Y', 'Belgium');

--GENERATION SMARTPHONE DATA
        add_smartphone('Samsung A52', to_date('18-08-2021', 'DD-MM-YYYY'), 6.3, 3, 8, 16, 256);
        add_smartphone('iPhone 15', to_date('09-10-2022', 'DD-MM-YYYY'), 6.8, 5, 16, 32, 512);
        add_smartphone('Samsung Note 7', to_date('27-04-2017', 'DD-MM-YYYY'), 5.9, 3, 8, 8, 128);
        add_smartphone('Huawei 7', to_date('14-05-2015', 'DD-MM-YYYY'), 5.7, 2, 4, 4, 64);
        add_smartphone('Samsung Fold 2', to_date('02-02-2023', 'DD-MM-YYYY'), 6.8, 5, 16, 32, 512);

--GENERATION USER DATA
        add_user('Joppe', 'Dechamps', 'joppedechamps@gmail.com', 0473138096, to_date('14-08-2003', 'DD-MM-YYYY'));
        add_user('Gloria', 'Mihaylova', 'gloria.mihaylova@telenet.be', 0465328666, to_date('04-04-2005', 'DD-MM-YYYY'));
        add_user('Olivier', 'Christiaens', 'olivier.christiaens@gmail.com', 0483660137, to_date('12-08-2003', 'DD-MM-YYYY'));
        add_user('Kristof', 'Van de Walle', 'kristofvdwalle@hotmail.com', 0470534458, to_date('21-12-2002', 'DD-MM-YYYY'));
        add_user('Michiel', 'Gilissen', 'michiel.gilissen@gmail.com', 0493089725, to_date('08-08-2003', 'DD-MM-YYYY'));
        COMMIT;

--GENERATION REVIEW DATA
        add_review(lookup_user('joppedechamps@gmail.com',0473138096),
        lookup_smartphone('Samsung A52', 16, 256),
            lookup_website('www.tweakers.net'),
            to_date('12-04-2019', 'DD-MM-YYYY'),
            'Very glad this one has not blown up yet!',
            'I bought this phone very recently after my other one blew up and did not trust smartphones for a while, I will keep this one in a safe place, so it does not happen again!',
            5, 5, NULL);
        add_review(lookup_user('gloria.mihaylova@telenet.be',0465328666),
            lookup_smartphone('Samsung Note 7', 8, 128),
            lookup_website('www.mediamarkt.be'),
            to_date('25-08-2017', 'DD-MM-YYYY'),
            'Very dangerous phone, blew up on my nightstand!',
            'WTH, I just got this phone a few days ago, and while it was charging on my nightstand it just BLEW UP?! I cannot believe this, very unhappy, will probably stay away from these devices for a while.',
            2837, 1, to_date('27-08-2017', 'DD-MM-YYYY'));
        add_review(lookup_user('olivier.christiaens@gmail.com',0483660137),
            lookup_smartphone('Samsung Fold 2', 32, 512),
            lookup_website('www.coolblue.be'),
            to_date('29-11-2023', 'DD-MM-YYYY'),
            'Happy',
            'Very happy about this device, thanks for coming to my review talk!',
            0, 4, NULL);
        add_review(lookup_user('joppedechamps@gmail.com',0473138096),
            lookup_smartphone('iPhone 15', 32, 512),
            lookup_website('www.tweakers.net'),
            to_date('05-10-2020', 'DD-MM-YYYY'),
            'Clean, well working iPhone',
            'First iPhone I have ever bought, a bit of a hassle to get it working and transfer some things, but got it up and running after a while, will edit if anything changes',
            34, 4, NULL);
        add_review(lookup_user('kristofvdwalle@hotmail.com',0470534458),
            lookup_smartphone('iPhone 15', 32, 512),
            lookup_website('www.coolblue.be'),
            to_date('18-06-2022', 'DD-MM-YYYY'),
            'Very happy about the purchase of the newest hardware!',
            'Just bought the newest iPhone, very happy as transfers from my iPhone 14 were flawless. Edit: After a year and a half of usage it is due for an upgrade, as it is already slowing down',
            124, 5, to_date('23-12-2023', 'DD-MM-YYYY'));
    END bewijs_milestone_M4_S1;

END PKG_S1_smartphones;

