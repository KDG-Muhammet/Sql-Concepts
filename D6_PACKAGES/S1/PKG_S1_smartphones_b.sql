CREATE OR REPLACE PACKAGE BODY PKG_S1_smartphones AS

    PROCEDURE empty_tables_S1 IS
    BEGIN

        FOR all_constraints in (select table_name, constraint_name
                                from user_constraints
                                where constraint_type = 'R'
                                  AND OWNER = 'PROJECT'
                                  AND STATUS = 'ENABLED')
            LOOP
                EXECUTE IMMEDIATE 'ALTER TABLE ' || all_constraints.table_name || ' DISABLE CONSTRAINT ' ||
                                  all_constraints.constraint_name;
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

        for all_constraints in (select table_name, constraint_name
                                from user_constraints
                                where constraint_type = 'R'
                                  AND OWNER = 'PROJECT'
                                  AND STATUS = 'DISABLED')
            LOOP
                EXECUTE IMMEDIATE 'ALTER TABLE ' || all_constraints.table_name || ' ENABLE CONSTRAINT ' ||
                                  all_constraints.constraint_name;
            END LOOP;

        /*DECLARE
            v_invalid_objects NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_invalid_objects FROM DBA_OBJECTS WHERE status = 'INVALID' AND owner = 'PROJECT';

            IF (1 > 0) THEN
                EXECUTE IMMEDIATE 'ALTER PACKAGE PROJECT.PKG_S1_smartphones COMPILE BODY';
            END IF;
        END;*/


    END empty_tables_S1;

    PROCEDURE add_smartphone(p_name IN VARCHAR2, p_releasedate IN DATE,
                             p_screendiagonal IN NUMBER, p_cameraamount IN NUMBER,
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
        INSERT INTO REVIEWS (REVIEW_USER_ID, REVIEW_PHONE_ID, WEBSITE_ID, POSTEDDATE, TITLE, CONTENT, LIKES, RATING,
                             LAST_EDITED_DATE)
        VALUES (p_userid, p_phoneid, p_websiteid, p_posteddate, p_title, p_content, p_likes, p_rating,
                p_lastediteddate);
    END add_review;

    FUNCTION lookup_smartphone(p_phonename IN VARCHAR2, p_memory IN NUMBER, p_storage IN NUMBER) RETURN NUMBER AS
        v_phone_id NUMBER;
    BEGIN
        SELECT phone_id
        INTO v_phone_id
        FROM smartphones
        WHERE name = p_phonename
          AND memory = p_memory
          AND storage = p_storage;
        return v_phone_id;
    END lookup_smartphone;

    FUNCTION lookup_website(p_url IN VARCHAR2) RETURN NUMBER AS
        v_website_id NUMBER;
    BEGIN
        SELECT website_id
        INTO v_website_id
        FROM websites
        WHERE WEB_ADDRESS = p_url;
        return v_website_id;
    END lookup_website;

    FUNCTION lookup_user(p_email IN VARCHAR2, p_phonenumber IN NUMBER) RETURN NUMBER AS
        v_user_id NUMBER;
    BEGIN
        SELECT user_id
        INTO v_user_id
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
        add_user('Olivier', 'Christiaens', 'olivier.christiaens@gmail.com', 0483660137,
                 to_date('12-08-2003', 'DD-MM-YYYY'));
        add_user('Kristof', 'Van de Walle', 'kristofvdwalle@hotmail.com', 0470534458,
                 to_date('21-12-2002', 'DD-MM-YYYY'));
        add_user('Michiel', 'Gilissen', 'michiel.gilissen@gmail.com', 0493089725, to_date('08-08-2003', 'DD-MM-YYYY'));
        COMMIT;

--GENERATION REVIEW DATA
        add_review(lookup_user('joppedechamps@gmail.com', 0473138096),
                   lookup_smartphone('Samsung A52', 16, 256),
                   lookup_website('www.tweakers.net'),
                   to_date('12-04-2019', 'DD-MM-YYYY'),
                   'Very glad this one has not blown up yet!',
                   'I bought this phone very recently after my other one blew up and did not trust smartphones for a while, I will keep this one in a safe place, so it does not happen again!',
                   5, 5, NULL);
        add_review(lookup_user('gloria.mihaylova@telenet.be', 0465328666),
                   lookup_smartphone('Samsung Note 7', 8, 128),
                   lookup_website('www.mediamarkt.be'),
                   to_date('25-08-2017', 'DD-MM-YYYY'),
                   'Very dangerous phone, blew up on my nightstand!',
                   'WTH, I just got this phone a few days ago, and while it was charging on my nightstand it just BLEW UP?! I cannot believe this, very unhappy, will probably stay away from these devices for a while.',
                   2837, 1, to_date('27-08-2017', 'DD-MM-YYYY'));
        add_review(lookup_user('olivier.christiaens@gmail.com', 0483660137),
                   lookup_smartphone('Samsung Fold 2', 32, 512),
                   lookup_website('www.coolblue.be'),
                   to_date('29-11-2023', 'DD-MM-YYYY'),
                   'Happy',
                   'Very happy about this device, thanks for coming to my review talk!',
                   0, 4, NULL);
        add_review(lookup_user('joppedechamps@gmail.com', 0473138096),
                   lookup_smartphone('iPhone 15', 32, 512),
                   lookup_website('www.tweakers.net'),
                   to_date('05-10-2020', 'DD-MM-YYYY'),
                   'Clean, well working iPhone',
                   'First iPhone I have ever bought, a bit of a hassle to get it working and transfer some things, but got it up and running after a while, will edit if anything changes',
                   34, 4, NULL);
        add_review(lookup_user('kristofvdwalle@hotmail.com', 0470534458),
                   lookup_smartphone('iPhone 15', 32, 512),
                   lookup_website('www.coolblue.be'),
                   to_date('18-06-2022', 'DD-MM-YYYY'),
                   'Very happy about the purchase of the newest hardware!',
                   'Just bought the newest iPhone, very happy as transfers from my iPhone 14 were flawless. Edit: After a year and a half of usage it is due for an upgrade, as it is already slowing down',
                   124, 5, to_date('23-12-2023', 'DD-MM-YYYY'));
    END bewijs_milestone_M4_S1;

    -- M5
    FUNCTION random_number(p_min IN NUMBER, p_max IN NUMBER) RETURN NUMBER AS
        v_int NUMBER;
    BEGIN
        v_int := TRUNC(DBMS_RANDOM.VALUE(p_min, p_max));
        RETURN v_int;
    END random_number;

    FUNCTION random_date(p_min IN DATE, p_max IN DATE) RETURN DATE AS
        v_date DATE;
        v_diff NUMBER;
    BEGIN
        --random date in the last year
        v_diff := TRUNC(p_max) - TRUNC(p_min);
        v_date := TRUNC(p_min) + TRUNC(random_number(0, v_diff + 1));
        RETURN v_date;
    END random_date;

    FUNCTION random_element(p_elements SYS.ODCIVARCHAR2LIST) RETURN VARCHAR2 AS
        v_element      VARCHAR2;
        v_size         NUMBER;
        v_random_index NUMBER;
    BEGIN
        v_size := p_elements.COUNT;
        v_random_index := random_number(1, v_size + 1);
        RETURN p_elements(v_random_index) in v_element;
    END random_element;

    FUNCTION random_combination(
        p_list SYS.ODCIVARCHAR2LIST,
        p_counter IN NUMBER
    ) RETURN VARCHAR2 IS
        v_random_element VARCHAR2(100);
    BEGIN
        v_random_element := random_element(p_list);
        RETURN v_random_element || LPAD(p_counter, 3, '0');
    END random_combination;

    FUNCTION random_mail(p_firstname IN VARCHAR2, p_lastname IN VARCHAR2, p_counter IN NUMBER) RETURN VARCHAR2 AS
        v_mail           VARCHAR2;
        v_mail_providers SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
                'gmail.com', 'yahoo.com', 'outlook.com', 'hotmail.com', 'aol.com',
                'icloud.com', 'mail.com', 'protonmail.com', 'zoho.com', 'gmx.com',
                'yandex.com', 'live.com', 'msn.com', 'comcast.net', 'verizon.net',
                'att.net', 'bellsouth.net', 'charter.net', 'cox.net', 'earthlink.net',
                'juno.com', 'mindpsring.com', 'roadrunner.com', 'sbcglobal.net', 'wowway.com',
                'aim.com', 'mac.com', 'me.com', 'email.com', 'inbox.com',
                'fastmail.com', 'hushmail.com', 'tutanota.com', 'mail.ru', 'rediffmail.com',
                'bigpond.com', 'btinternet.com', 'virginmedia.com', 'sky.com', 'ntlworld.com',
                'blueyonder.co.uk', 'btopenworld.com', 'talktalk.net', 'tiscali.co.uk', 'uk2.net',
                'lycos.com', 'usa.net', 'earthlink.com', 'q.com', 'ymail.com',
                'rocketmail.com', 'icloud.net', 'boxbe.com', 'runbox.com', 'lavabit.com',
                'gawab.com', 'myway.com', 'opera.com', 'mailinator.com', 'jetable.org',
                'tempmail.com', 'guerrillamail.com', '10minutemail.com', 'discard.email', 'sharklasers.com',
                'spambog.com', 'spamgourmet.com', 'trashmail.com', 'maildrop.cc', 'byom.de',
                'mailbox.org', 'disroot.org', 'neomailbox.com', 'vfemail.net', 'riseup.net',
                'openmailbox.org', 'yopmail.com', 'mailnesia.com', 'getairmail.com', 'fakeinbox.com',
                'mintemail.com', 'guerrillamail.net', 'guerrillamail.de', 'guerrillamail.biz', 'guerrillamail.org',
                'guerrillamail.info', 'guerrillamailblock.com', 'guerrillamailblock.net', 'guerrillamailblock.de',
                'guerrillamailblock.org',
                'tempinbox.com', 'temp-mail.org', 'throwawaymail.com', 'mailcatch.com', 'maildrop.com',
                '10mail.org', '20mail.it', 'abusemail.de', 'afrobacon.com', 'amilegit.com');
    BEGIN
        RETURN p_firstname || '.' || p_lastname || p_counter || '@' || random_element(v_mail_providers);
    END random_mail;

    FUNCTION random_diagonal(p_min IN NUMBER, p_max IN NUMBER) RETURN NUMBER AS
        v_diagonal NUMBER;
    BEGIN
        v_diagonal := TRUNC(DBMS_RANDOM.VALUE(p_min, p_max), 2);
        RETURN v_diagonal;
    END random_diagonal;

    FUNCTION timestamp_diff(a timestamp, b timestamp)
        RETURN NUMBER IS
    BEGIN
        RETURN EXTRACT(day from (a - b)) * 24 * 60 * 60 +
               EXTRACT(hour from (a - b)) * 60 * 60 +
               EXTRACT(minute from (a - b)) * 60 +
               EXTRACT(second from (a - b));
    END;

--Tabel A - User
    PROCEDURE generate_random_user(p_amount IN NUMBER) AS
        v_first_names    SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
                'Aaron', 'Abigail', 'Adam', 'Adrian', 'Aiden', 'Alex', 'Alexander', 'Alexis', 'Alice', 'Alicia',
                'Allison', 'Alyssa', 'Amanda', 'Amber', 'Amy', 'Andrea', 'Andrew', 'Angela', 'Anna', 'Anthony',
                'Ashley', 'Austin', 'Ava', 'Barbara', 'Benjamin', 'Blake', 'Brandon', 'Brianna', 'Brittany', 'Brooke',
                'Bryan', 'Caleb', 'Cameron', 'Carl', 'Carla', 'Carlos', 'Catherine', 'Chad', 'Charles', 'Charlotte',
                'Cheryl', 'Chloe', 'Christian', 'Christopher', 'Claire', 'Cody', 'Colin', 'Connor', 'Courtney',
                'Crystal',
                'Daniel', 'David', 'Dawn', 'Deborah', 'Dennis', 'Derek', 'Diana', 'Diane', 'Dominic', 'Donna',
                'Dylan', 'Edward', 'Elaine', 'Elijah', 'Elizabeth', 'Ella', 'Emily', 'Emma', 'Ethan', 'Eva',
                'Evelyn', 'Faith', 'Felix', 'Gabriel', 'Gavin', 'Grace', 'Gregory', 'Hannah', 'Heather', 'Henry',
                'Isabella', 'Jack', 'Jackson', 'Jacob', 'James', 'Jason', 'Jayden', 'Jennifer', 'Jessica', 'John',
                'Jonathan', 'Jordan', 'Joseph', 'Joshua', 'Julia', 'Justin', 'Kaitlyn', 'Katherine', 'Kayla', 'Kevin');
        v_last_names     SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
                'Anderson', 'Armstrong', 'Baker', 'Barnes', 'Bell', 'Bennett', 'Brooks', 'Brown', 'Butler', 'Campbell',
                'Carter', 'Clark', 'Collins', 'Cook', 'Cooper', 'Cox', 'Davis', 'Diaz', 'Edwards', 'Evans',
                'Flores', 'Foster', 'Garcia', 'Gonzales', 'Gonzalez', 'Gray', 'Green', 'Griffin', 'Hall', 'Harris',
                'Hernandez', 'Hill', 'Howard', 'Hughes', 'Jackson', 'James', 'Jenkins', 'Johnson', 'Jones', 'Kelly',
                'King', 'Lee', 'Lewis', 'Long', 'Lopez', 'Martin', 'Martinez', 'Miller', 'Mitchell', 'Moore',
                'Morgan', 'Morris', 'Murphy', 'Nelson', 'Nguyen', 'Ortiz', 'Parker', 'Perez', 'Perry', 'Peterson',
                'Phillips', 'Powell', 'Price', 'Ramirez', 'Reed', 'Richardson', 'Rivera', 'Roberts', 'Robinson',
                'Rodriguez',
                'Rogers', 'Ross', 'Russell', 'Sanchez', 'Sanders', 'Scott', 'Simmons', 'Smith', 'Stewart', 'Taylor',
                'Thomas', 'Thompson', 'Torres', 'Turner', 'Walker', 'Ward', 'Washington', 'Watson', 'White', 'Williams',
                'Wilson', 'Wood', 'Wright', 'Young');
        v_firstname      VARCHAR2(100);
        v_lastname       VARCHAR2(100);
        -- time tracking for generation and insertion
        v_start_time_gen TIMESTAMP;
    BEGIN
        v_start_time_gen := systimestamp;
        for i in 1..p_amount
            loop
                add_user(
                        random_element(v_first_names) IN v_firstname,
                        random_element(v_last_names) IN v_lastname,
                        random_mail(v_firstname, v_lastname, i),
                        '0' || random_number(470000000, 499999999),
                        random_date(to_date('01-01-1990', 'DD-MM-YYYY'), to_date('31-12-2005', 'DD-MM-YYYY'))
                );
            end loop;
        DBMS_OUTPUT.PUT_LINE('Finished procedure generate_random_user with parameters: p_amount: ' || p_amount);
        DBMS_OUTPUT.PUT_LINE('Actual amount of Rows added: ' || (SELECT COUNT(*) FROM REVIEWS));
        DBMS_OUTPUT.PUT_LINE('Duration for generate_random_user: ' ||
                             timestamp_diff(systimestamp, v_start_time_gen) * 1000 || 'ms');

    END generate_random_user;

--Tabel B - Smartphone
    PROCEDURE generate_random_smartphone(p_amount IN NUMBER) AS
        v_smartphone_series SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
                'Apple iPhone', 'Samsung Galaxy S', 'Samsung Galaxy Note', 'Samsung Galaxy Z Fold',
                'Samsung Galaxy Z Flip',
                'Google Pixel', 'OnePlus', 'Xiaomi Mi', 'Oppo Find X', 'Oppo Reno',
                'Sony Xperia 1', 'Sony Xperia 5', 'Sony Xperia 10', 'Huawei P', 'Huawei Mate',
                'LG Velvet', 'LG Wing', 'LG G', 'LG V', 'Motorola Moto G',
                'Motorola Moto Edge', 'Motorola Moto E', 'Nokia X', 'Nokia G', 'Nokia 8',
                'Realme GT', 'Realme X', 'Realme Narzo', 'Realme C', 'Asus ROG Phone',
                'Asus Zenfone', 'Vivo X', 'Vivo V', 'Vivo Y', 'ZTE Axon',
                'ZTE Nubia Red Magic', 'ZTE Blade', 'Lenovo Legion Phone Duel', 'Lenovo K', 'Lenovo Z',
                'Microsoft Surface Duo', 'BlackBerry KEY', 'BlackBerry Motion', 'BlackBerry Evolve', 'Honor Magic',
                'Honor View', 'Honor 50', 'Honor 30', 'Honor Play', 'Meizu 18',
                'Meizu 17', 'Meizu 16', 'Alcatel OneTouch', 'Alcatel Idol', 'Tecno Camon',
                'Tecno Phantom', 'Tecno Spark', 'Infinix Zero', 'Infinix Note', 'Infinix Hot',
                'Coolpad Cool', 'Coolpad Note', 'Micromax Canvas', 'Micromax Bharat', 'Lava Z',
                'Lava Agni', 'Panasonic Eluga', 'Panasonic P', 'Panasonic Toughbook', 'BLU Vivo',
                'BLU Bold', 'Gionee M', 'Gionee S', 'Gionee F', 'LeEco Le',
                'Fairphone', 'Cat S', 'Doogee S', 'Doogee X', 'UMIDIGI Bison',
                'UMIDIGI A', 'UMIDIGI F', 'Ulefone Armor', 'Ulefone Note', 'Ulefone Power',
                'iQOO', 'Redmi Note', 'Redmi K', 'Poco X', 'Poco M');
        -- time tracking for generation and insertion
        v_start_time_gen    TIMESTAMP;
    BEGIN
        v_start_time_gen := systimestamp;
        for i in 1..p_amount
            loop
                add_smartphone(
                        random_combination(v_smartphone_series, i),
                        random_date(to_date('01-01-2010', 'DD-MM-YYYY'), to_date('31-12-2023', 'DD-MM-YYYY')),
                        random_diagonal(5, 8),
                        random_number(2, 5),
                        random_number(4, 16),
                        random_number(4, 32),
                        random_number(64, 512)
                );
            end loop;
        DBMS_OUTPUT.PUT_LINE('Finished procedure generate_random_smartphone with parameters: p_amount: ' || p_amount);
        DBMS_OUTPUT.PUT_LINE('Actual amount of Rows added: ' || (SELECT COUNT(*) FROM SMARTPHONES));
        DBMS_OUTPUT.PUT_LINE('Duration for generate_random_smartphone: ' ||
                             timestamp_diff(systimestamp, v_start_time_gen) * 1000 || 'ms');
    END generate_random_smartphone;

--Tabel C - Website
    PROCEDURE generate_random_website(p_amount IN NUMBER) AS
        v_website_names     SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
                'GSM Arena', 'Phone Arena', 'TechRadar', 'CNET', 'Android Authority',
                'The Verge', 'Toms Guide', 'Engadget', 'PCMag', 'Trusted Reviews',
                'Digital Trends', 'TechCrunch', 'AnandTech', 'Android Central', 'NotebookCheck',
                '9to5Google', 'XDA Developers', 'iMore', 'Macworld', 'Wired',
                'Ars Technica', 'SlashGear', 'Pocket-lint', 'uSwitch', 'Recombu',
                'What Hi-Fi?', 'Tech Advisor', 'Android Headlines', 'Reviewed', 'Consumer Reports',
                'NDTV Gadgets', 'AndroidPIT', 'TechSpot', 'ZDNet', 'Expert Reviews',
                'Gizmodo', 'BGR', 'T3', 'Ubergizmo', 'Coolsmartphone',
                'Know Your Mobile', 'Digital Photography School', 'Stuff', 'Laptop Mag', 'MakeUseOf',
                'TechHive', 'Tech Times', 'Droid Life', 'Pocketnow', 'Phone Review Pro',
                'Mobile Drop', 'Phonegg', 'Review Geek', 'Mashable', 'Tech Week Mag',
                'Android World', 'Android Authority', 'Phone Arena Reviews', 'Fossbytes', 'Tweakers',
                'Neowin', 'Computerworld', 'GeekWire', 'Mobigyaan', 'Tech ARP',
                'Fudzilla', 'Shutterbug', 'HardwareZone', 'Pocketables', 'MobileTechReview',
                'GearOpen', 'Phandroid', 'TopTenGamer', 'Toms Hardware', 'TechWalls',
                'Phone Scoop', 'Android Community', 'Geeky Gadgets', 'Coolblue', 'Android Planet',
                'Techblog', 'Clubic', 'Les Numériques', 'Toms Hardware FR', 'Les Mobiles',
                '01net', 'Frandroid', 'Phonandroid', 'Journal du Geek', 'NextPit',
                'Minimachines');
        v_website_countries SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
                'Belgium', 'Netherlands', 'Germany', 'France', 'United Kingdom');
        v_website_name      VARCHAR2(100);
        -- time tracking for generation and insertion
        v_start_time_gen    TIMESTAMP;
    BEGIN
        v_start_time_gen := systimestamp;
        for i in 1..p_amount
            loop
                v_website_name := random_combination(v_website_names, i);
                add_website(
                        'www.' || v_website_name || '.com',
                        v_website_name,
                        random_number(10000, 1000000),
                        CASE
                            WHEN random_number(1, 3) = 1 THEN 'Y'
                            ELSE 'N'
                            END,
                        random_element(SYS.ODCIVARCHAR2LIST('Belgium', 'Netherlands', 'Germany', 'France',
                                                            'United Kingdom'))
                );
            end loop;
        DBMS_OUTPUT.PUT_LINE('Finished procedure generate_random_website with parameters: p_amount: ' || p_amount);
        DBMS_OUTPUT.PUT_LINE('Actual amount of Rows added: ' || (SELECT COUNT(*) FROM WEBSITES));
        DBMS_OUTPUT.PUT_LINE('Duration for generate_random_website: ' ||
                             timestamp_diff(systimestamp, v_start_time_gen) * 1000 || 'ms');

    END generate_random_website;

--Tabel D - Review
    PROCEDURE tussenreviews(p_amount IN NUMBER)
    AS
        --Maakt voor ieder park, 3 willekeurige attracties in parkattracties
        TYPE type_tab_userid IS table of USERS.USER_ID%TYPE;
        TYPE type_tab_smartphoneid IS TABLE OF SMARTPHONES.PHONE_ID%TYPE;
        TYPE type_tab_websiteid IS TABLE OF WEBSITES.WEBSITE_ID%TYPE;
        TYPE type_tab_phone_releasedates IS TABLE OF SMARTPHONES.RELEASE_DATE%TYPE;
        t_userid              type_tab_userid;
        t_smartphoneid        type_tab_smartphoneid;
        t_websiteid           type_tab_websiteid;
        t_phonereleasedates   type_tab_phone_releasedates;
        v_random_userindex    NUMBER;
        v_random_phoneindex   NUMBER;
        v_random_websiteindex NUMBER;
        v_generated_count     NUMBER;
        v_userid              USERS.USER_ID%TYPE;
        v_phoneid             SMARTPHONES.PHONE_ID%TYPE;
        v_websiteid           WEBSITES.WEBSITE_ID%TYPE;
        v_posteddate          DATE;
        v_releasedate         DATE;
        v_random_contentindex NUMBER;
        v_review_titles       SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
                'Amazing Battery Life!',
                'Great Performance, But Lacking in Camera',
                'Perfect for Everyday Use',
                'Exceeded My Expectations',
                'Disappointed with the Build Quality',
                'Best Phone Ive Ever Owned',
                'Good Value for the Price',
                'Mediocre Performance',
                'Fantastic Display and Design',
                'Not Worth the Hype',
                'Impressive Speed and Smoothness',
                'Battery Drains Too Fast',
                'Solid Phone with Great Features',
                'Overheats During Heavy Use',
                'Superb Camera Quality',
                'Poor Customer Service Experience',
                'A Solid Upgrade from Previous Model',
                'Too Many Software Bugs',
                'Great for Gaming',
                'Underwhelming Audio Quality',
                'Sleek and Stylish Design',
                'Average Phone for the Price',
                'Excellent Storage Options',
                'Screen Scratches Easily',
                'Reliable and Durable',
                'Great for Photography Enthusiasts',
                'Not User-Friendly',
                'Beautiful and Functional',
                'Battery Life Could Be Better',
                'Highly Recommend for Business Use',
                'Slow Charging Speed',
                'Top Notch Security Features',
                'Unresponsive Touchscreen',
                'Great for Social Media',
                'Frequent Software Updates',
                'Heavy and Bulky',
                'Worth Every Penny',
                'Lacks Essential Features',
                'Perfect for Kids and Teens',
                'User Interface Needs Improvement',
                'A Premium Feel at a Mid-Range Price',
                'Incredible Night Mode Camera',
                'Subpar Speaker Quality',
                'Best in Class Performance',
                'Poor Signal Reception',
                'Amazing Fast Charging Capabilities',
                'Limited Color Options',
                'Very Satisfied with My Purchase',
                'Buttons Feel Cheap',
                'Great for Streaming Videos',
                'Terrible Customer Support',
                'Perfect Balance of Price and Features',
                'Frequent App Crashes',
                'Stunning HDR Display',
                'Difficult to Set Up',
                'Great for Outdoor Use',
                'Poor Battery Performance Over Time',
                'Beautiful OLED Display',
                'Feels Outdated Quickly',
                'Superb Build Quality',
                'Complicated Settings Menu',
                'Excellent for Video Calls',
                'Not Waterproof',
                'Highly Responsive Face Unlock',
                'No Headphone Jack',
                'Great for Productivity',
                'Charger Cable Too Short',
                'Excellent 5G Connectivity',
                'Lacks Wireless Charging',
                'Clear and Loud Speakers',
                'Heavy and Uncomfortable to Hold',
                'Great Parental Controls',
                'Flimsy Back Cover',
                'Affordable and Reliable',
                'No Expandable Storage',
                'Long-Lasting Battery',
                'Disappointing Screen Resolution',
                'Excellent Gaming Experience',
                'Heats Up Quickly',
                'Smooth and Fast Performance',
                'Unimpressive Design',
                'Great Work Phone',
                'Substandard Front Camera',
                'User-Friendly Interface',
                'Too Expensive for What You Get',
                'Great Low Light Photography',
                'Weak Vibration Motor',
                'Perfect for Media Consumption',
                'Unreliable Fingerprint Scanner',
                'Great for Virtual Meetings',
                'Prone to Scratches',
                'Amazing Display Quality',
                'Lacks Dual SIM Capability',
                'Very Durable and Sturdy',
                'Too Many Pre-Installed Apps',
                'Best Phone for the Price',
                'Poor Wi-Fi Connectivity',
                'Excellent Value for Money',
                'Camera Lags Sometimes',
                'Great for Video Editing',
                'Boring Design',
                'Fast and Reliable');
        v_review_contents     SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(
                'I have been using this phone for a week, and the battery life is incredible! It lasts me more than a day with heavy usage.',
                'The phone performs really well with most apps, but the camera is not as good as I expected. It struggles in low light.',
                'This smartphone is perfect for my daily needs. It handles all my tasks effortlessly and is very user-friendly.',
                'I wasn’t expecting much, but this phone has blown me away. It’s fast, sleek, and the camera is fantastic.',
                'I dropped the phone once, and it already has a dent. The build quality is not up to the mark for the price.',
                'This is the best phone I have ever owned. It’s fast, the camera is excellent, and it feels premium in hand.',
                'For the price, this phone offers a lot of features. It’s definitely a good value for money.',
                'The performance is just average. It’s okay for basic tasks, but it lags when running heavy applications.',
                'I love the display and the design of this phone. It looks and feels very premium.',
                'After all the hype, I expected more from this phone. It’s decent but not as great as advertised.',
                'The speed and smoothness of this phone are very impressive. It handles multitasking with ease.',
                'The battery drains too quickly for my liking. I have to charge it twice a day.',
                'This phone is solid with great features. It’s reliable and performs well under various conditions.',
                'The phone overheats when I play games for a long time. It’s quite uncomfortable to hold.',
                'The camera quality is superb. The pictures come out clear and vibrant.',
                'The customer service experience was terrible. They took too long to respond and didn’t solve my issue.',
                'Upgrading from my old phone was a great decision. This one is much faster and has better features.',
                'The phone has too many software bugs. I hope the company releases updates to fix them soon.',
                'This phone is great for gaming. It runs smoothly without any lag.',
                'The audio quality is underwhelming. The speakers could be better.',
                'The design is sleek and stylish. I get compliments on it all the time.',
                'It’s an average phone for the price. Nothing too special, but it gets the job done.',
                'I appreciate the excellent storage options. I can store all my files and apps without any issues.',
                'The screen scratches easily. I recommend getting a screen protector.',
                'This phone is reliable and durable. It has survived several drops without any damage.',
                'As a photography enthusiast, I love the camera on this phone. It takes amazing photos.',
                'The phone is not very user-friendly. The interface is confusing and hard to navigate.',
                'It’s both beautiful and functional. I’m very pleased with this purchase.',
                'The battery life could be better. I have to charge it by the end of the day.',
                'I highly recommend this phone for business use. It’s efficient and supports all necessary applications.',
                'The charging speed is very slow. It takes hours to fully charge the battery.',
                'This phone has top-notch security features. I feel safe using it for online transactions.',
                'The touchscreen is unresponsive at times. It gets frustrating when trying to type messages.',
                'This phone is great for social media. The apps run smoothly, and the camera is perfect for selfies.',
                'I appreciate the frequent software updates. It keeps the phone running smoothly and securely.',
                'The phone is heavy and bulky. It’s not very comfortable to carry around.',
                'This phone is worth every penny. It’s fast, reliable, and has all the features I need.',
                'It lacks some essential features that I expected at this price point.',
                'This phone is perfect for kids and teens. It’s easy to use and has good parental controls.',
                'The user interface needs improvement. It’s not very intuitive and can be confusing at times.',
                'This phone gives a premium feel at a mid-range price. It’s a great deal.',
                'The night mode camera is incredible. It takes clear and bright photos even in low light.',
                'The speaker quality is subpar. The sound is not as clear as I hoped.',
                'This phone offers best-in-class performance. It’s fast and handles all my tasks effortlessly.',
                'The signal reception is poor. I often lose connection in areas where other phones work fine.',
                'The fast charging capabilities are amazing. I can get a full charge in under an hour.',
                'There are limited color options available. I wish there were more choices.',
                'I am very satisfied with my purchase. The phone meets all my expectations.',
                'The buttons feel cheap and flimsy. They don’t give a satisfying click when pressed.',
                'This phone is great for streaming videos. The display is clear and vibrant.',
                'The customer support was terrible. They were not helpful and very slow to respond.',
                'It’s a perfect balance of price and features. You get a lot of value for your money.',
                'The apps crash frequently. It’s quite frustrating and disrupts my usage.',
                'The HDR display is stunning. Colors are vibrant and the contrast is excellent.',
                'Setting up the phone was difficult. The instructions were not clear.',
                'This phone is great for outdoor use. The screen is bright enough to see in direct sunlight.',
                'The battery performance has declined over time. It doesn’t last as long as it used to.',
                'The OLED display is beautiful. The colors are rich and the blacks are deep.',
                'The phone feels outdated quickly. Newer models come out too often.',
                'The build quality is superb. It feels very sturdy and well-made.',
                'The settings menu is complicated. It’s hard to find specific options.',
                'This phone is excellent for video calls. The front camera is clear and has good quality.',
                'The phone is not waterproof. I had an accident and now it’s not working properly.',
                'The face unlock feature is highly responsive and works in low light.',
                'I miss having a headphone jack. It’s inconvenient to use an adapter.',
                'This phone is great for productivity. It helps me stay organized and efficient.',
                'The charger cable is too short. I had to buy a longer one separately.',
                'The 5G connectivity is excellent. I get fast internet speeds everywhere.',
                'It lacks wireless charging. I was hoping for this feature at this price point.',
                'The speakers are clear and loud. Great for listening to music and watching videos.',
                'The phone is heavy and uncomfortable to hold for long periods.',
                'The parental controls are great. I can easily monitor my child’s phone usage.',
                'The back cover feels flimsy. It doesn’t give a premium feel.',
                'This phone is affordable and reliable. It’s a good choice for budget-conscious buyers.',
                'There is no expandable storage. I wish I could add more memory.',
                'The battery lasts a long time. I can go two days without charging.',
                'The screen resolution is disappointing. It’s not as sharp as other phones.',
                'This phone provides an excellent gaming experience. It’s smooth and responsive.',
                'The phone heats up quickly during heavy use.',
                'The performance is smooth and fast. I haven’t experienced any lag.',
                'The design is unimpressive. It looks too similar to older models.',
                'This phone works great for my job. It’s reliable and has all the apps I need.',
                'The front camera is substandard. Selfies don’t look great.',
                'The interface is user-friendly. It’s easy to navigate and use.',
                'The phone is too expensive for what you get. There are better options at this price.',
                'The low light photography is great. The camera captures a lot of detail even in the dark.',
                'The vibration motor is weak. I often miss calls and notifications.',
                'This phone is perfect for media consumption. The display and sound quality are top-notch.',
                'The fingerprint scanner is unreliable. It often fails to recognize my fingerprint.',
                'It’s great for virtual meetings. The camera and microphone quality are excellent.',
                'The phone is prone to scratches. I recommend using a case.',
                'The display quality is amazing. Colors are vivid and the resolution is high.',
                'It lacks dual SIM capability. I need to carry a second phone for work.',
                'The phone is very durable and sturdy. It has withstood several drops.',
                'There are too many pre-installed apps. They take up unnecessary space.',
                'This is the best phone for the price. It offers a lot of features for a reasonable cost.',
                'The Wi-Fi connectivity is poor. I often lose connection even with a strong signal.',
                'It’s an excellent value for money. I’m happy with my purchase.',
                'The camera lags sometimes. It takes a while to focus and take pictures.',
                'It’s great for video editing. The processing power and screen quality are ideal.',
                'The design is boring. I was expecting something more innovative.',
                'The phone is fast and reliable. It hasn’t let me down so far.');
        -- time tracking for generation and insertion
        v_start_time_gen      TIMESTAMP;
    BEGIN
        SELECT USER_ID BULK COLLECT INTO t_userid FROM USERS;
        SELECT PHONE_ID BULK COLLECT INTO t_smartphoneid FROM SMARTPHONES;
        SELECT WEBSITE_ID BULK COLLECT INTO t_websiteid FROM WEBSITES;
        SELECT RELEASE_DATE BULK COLLECT INTO t_phonereleasedates FROM SMARTPHONES;
        v_start_time_gen := systimestamp;
        WHILE v_generated_count < p_amount
            LOOP
                v_random_userindex := random_number(1, t_userid.count);
                v_random_phoneindex := random_number(1, t_smartphoneid.count);
                v_random_websiteindex := random_number(1, t_websiteid.count);

                v_userid := t_userid(v_random_userindex);
                v_phoneid := t_smartphoneid(v_random_phoneindex);
                v_websiteid := t_websiteid(v_random_websiteindex);

                v_releasedate := t_phonereleasedates(v_random_phoneindex);
                v_posteddate := random_date(v_releasedate, to_date('31-12-2023', 'DD-MM-YYYY'));

                v_random_contentindex := random_number(1, v_review_titles.count);
                add_review(v_userid, v_phoneid, v_websiteid,
                           random_date(to_date('01-01-2010', 'DD-MM-YYYY'), to_date('31-12-2023', 'DD-MM-YYYY')),
                           v_review_titles(v_random_contentindex) || v_generated_count,
                           v_review_contents(v_random_contentindex),
                           random_number(0, 100),
                           random_number(1, 5),
                           random_date(v_posteddate, to_date('31-12-2023', 'DD-MM-YYYY'))
                );
                v_generated_count := v_generated_count + 1;
            END LOOP;
        DBMS_OUTPUT.PUT_LINE('Finished procedure tussenReviews with parameters: p_amount: ' || p_amount);
        DBMS_OUTPUT.PUT_LINE('Actual amount of Rows added: ' || (SELECT COUNT(*) FROM REVIEWS));
        DBMS_OUTPUT.PUT_LINE('Duration for tussenreviews: ' ||
                             timestamp_diff(systimestamp, v_start_time_gen) * 1000 || 'ms');
        COMMIT;
    END tussenreviews;

--Bewijs
    PROCEDURE bewijs_milestone_5_S1(p_user_amount IN NUMBER, p_phone_amount IN NUMBER, p_website_amount IN NUMBER,
                                    p_review_amount IN NUMBER) AS
    BEGIN
        generate_random_user(p_user_amount);
        generate_random_smartphone(p_phone_amount);
        generate_random_website(p_website_amount);
        tussenreviews(p_review_amount);
    END bewijs_milestone_5_S1;


END PKG_S1_smartphones;

