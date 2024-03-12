DROP TABLE websites CASCADE CONSTRAINTS;
DROP TABLE smartphones CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE reviews CASCADE CONSTRAINTS;

CREATE TABLE websites (
                website_ID NUMBER NOT NULL,
                web_address VARCHAR2 NOT NULL,
                name VARCHAR2 NOT NULL,
                yearly_users NUMBER,
                mobile_app BOOLEAN,
                server_country VARCHAR2,
                CONSTRAINT WEBSITE_ID PRIMARY KEY (website_ID)
);


CREATE TABLE smartphones (
                phone_ID NUMBER NOT NULL,
                phone_name VARCHAR2 NOT NULL,
                release_date DATE,
                screen_diagonal NUMBER(2),
                camera_amount NUMBER,
                processor_cores NUMBER,
                memory NUMBER,
                storage NUMBER,
                CONSTRAINT SMARTPHONE_ID PRIMARY KEY (phone_ID)
);


CREATE TABLE users (
                user_ID NUMBER NOT NULL,
                first_name VARCHAR2 NOT NULL,
                last_name VARCHAR2 NOT NULL,
                email VARCHAR2 NOT NULL,
                phone_number VARCHAR2,
                birthdate DATE,
                CONSTRAINT USER_ID PRIMARY KEY (user_ID)
);


CREATE TABLE reviews (
                review_user_ID NUMBER NOT NULL,
                review_phone_ID NUMBER NOT NULL,
                postedDate DATE NOT NULL,
                website_ID NUMBER NOT NULL,
                title VARCHAR2 NOT NULL,
                content VARCHAR2 NOT NULL,
                likes NUMBER,
                rating NUMBER NOT NULL,
                last_edited_date DATE NOT NULL,
                CONSTRAINT REVIEW_ID PRIMARY KEY (review_user_ID, review_phone_ID, postedDate),
                CONSTRAINT RATING CHECK (rating between 0 AND 5)
);


ALTER TABLE reviews ADD CONSTRAINT WEBSITES_REVIEWS_FK
FOREIGN KEY (website_ID)
REFERENCES websites (website_ID)
NOT DEFERRABLE;

ALTER TABLE reviews ADD CONSTRAINT SMARTPHONES_REVIEWS_FK
FOREIGN KEY (review_phone_ID)
REFERENCES smartphones (phone_ID)
NOT DEFERRABLE;

ALTER TABLE reviews ADD CONSTRAINT USERS_REVIEWS_FK
FOREIGN KEY (review_user_ID)
REFERENCES users (user_ID)
NOT DEFERRABLE;

--Check web_address formatting (constraint)
CREATE OR REPLACE TRIGGER validate_web_address_format
BEFORE INSERT OR UPDATE OF web_address ON websites
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.web_address, '^www\.[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$') THEN
        RAISE_APPLICATION_ERROR(-20001, 'URL format is invalid. URL must be in the format: www.****.**');
    END IF;
END;

--GENERATION WEBSITE DATA
CREATE OR REPLACE FUNCTION generate_website_id RETURN NUMBER IS
    website_id NUMBER;
BEGIN
    SELECT NVL(MAX(website_ID), 0) + 1 INTO website_id FROM WEBSITES;
    RETURN website_id;
END generate_website_id;
--TODO CHECK ID GENERATION
INSERT INTO websites VALUES (ID, 'www.tweakers.net', 'Tweakers', 726511, false, 'Netherlands');
INSERT INTO websites VALUES (ID, 'www.samsung.be', 'Samsung Belgium', 278309, true, 'Japan');
INSERT INTO websites VALUES (ID, 'www.bol.com', 'Bol', 762579, true, 'Netherlands');
INSERT INTO websites VALUES (ID, 'www.mediamarkt.be', 'Mediamarkt', 202813, false, 'Belgium');
INSERT INTO websites VALUES (ID, 'www.coolblue.be', 'Coolblue', 625138, true, 'Belgium');

--GENERATION SMARTPHONE DATA
INSERT INTO smartphones VALUES (ID, 'Samsung A52', to_date('18-08-2021','DD-MM-YYYY'), 6.3, 3, 8, 16, 256);
INSERT INTO smartphones VALUES (ID, 'iPhone 15', to_date('09-10-2022','DD-MM-YYYY'), 6.8, 5, 16, 32, 512);
INSERT INTO smartphones VALUES (ID, 'Samsung Note 7', to_date('27-04-2017','DD-MM-YYYY'), 5.9, 3, 8, 8, 128);
INSERT INTO smartphones VALUES (ID, 'Huawei 7', to_date('14-05-2015','DD-MM-YYYY'), 5.7, 2, 4, 4, 64);
INSERT INTO smartphones VALUES (ID, 'Samsung Fold 2', to_date('02-02-2023','DD-MM-YYYY'), 6.8, 5, 16, 32, 512);