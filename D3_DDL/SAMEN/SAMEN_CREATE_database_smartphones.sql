DROP TABLE websites CASCADE CONSTRAINTS;
DROP TABLE smartphones CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE reviews CASCADE CONSTRAINTS;

DROP TABLE brands CASCADE CONSTRAINTS;
DROP TABLE addresses CASCADE CONSTRAINTS;
DROP TABLE brand_stores CASCADE CONSTRAINTS;
DROP TABLE promotions CASCADE CONSTRAINTS;
DROP TABLE sales CASCADE CONSTRAINTS;

CREATE TABLE websites (
                          website_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
                          web_address VARCHAR2(40) NOT NULL,
                          name VARCHAR2(20) NOT NULL,
                          yearly_users NUMBER,
                          mobile_app CHAR(1), --Boolean
                          server_country VARCHAR2(25),
                          CONSTRAINT WEBSITE_ID PRIMARY KEY (website_ID),
                          CONSTRAINT WEB_ADDRESS CHECK (REGEXP_LIKE(web_address, '^www\.[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'))
);


CREATE TABLE smartphones (
                             phone_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
                             name VARCHAR2(30) NOT NULL,
                             release_date DATE,
                             screen_diagonal NUMBER(3,2),
                             camera_amount NUMBER,
                             processor_cores NUMBER,
                             memory NUMBER,
                             storage NUMBER,
                             CONSTRAINT SMARTPHONE_ID PRIMARY KEY (phone_ID)
);


CREATE TABLE users (
                       user_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
                       first_name VARCHAR2(20) NOT NULL,
                       last_name VARCHAR2(40) NOT NULL,
                       email VARCHAR2(40) NOT NULL,
                       phone_number VARCHAR2(15),
                       birthdate DATE,
                       CONSTRAINT USER_ID PRIMARY KEY (user_ID)
);


CREATE TABLE reviews (
                         review_user_ID NUMBER NOT NULL,
                         review_phone_ID NUMBER NOT NULL,
                         postedDate DATE NOT NULL,
                         website_ID NUMBER NOT NULL,
                         title VARCHAR2(125) NOT NULL,
                         content VARCHAR2(500) NOT NULL,
                         likes NUMBER,
                         rating NUMBER NOT NULL,
                         last_edited_date DATE,
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

--------------------------- Student 2

CREATE TABLE addresses
(
    address_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    zip        NUMBER(5)   NOT NULL,
    city       VARCHAR(50) NOT NULL,
    street_number    NUMBER      NOT NULL,
    street     VARCHAR(50)        NOT NULL,
    CONSTRAINT ADDRESS_PK PRIMARY KEY (address_id),
    CONSTRAINT zipcode_check check (zip > 0)
);


CREATE TABLE brands
(
    brand_id       NUMBER GENERATED BY DEFAULT AS IDENTITY,
    brand_name     VARCHAR(50) NOT NULL,
    brand_founder VARCHAR(50)        NOT NULL,
    type          VARCHAR(50)        NOT NULL,
    key_people    VARCHAR(50)        NOT NULL,
    founding_date  DATE        NOT NULL,
    address_id     NUMBER,
    CONSTRAINT BRAND_PK PRIMARY KEY (brand_id)
);


CREATE TABLE brand_stores
(
    store_id       NUMBER GENERATED BY DEFAULT AS IDENTITY,
    brand_id       NUMBER NOT NULL,
    opening_date   DATE   NOT NULL,
    employee_count NUMBER NOT NULL,
    closing_date   DATE,
    address_id     NUMBER NOT NULL,
    CONSTRAINT BRAND_STORE_PK PRIMARY KEY (store_id)
);


CREATE TABLE promotions
(
    promotion_id NUMBER      NOT NULL,
    discount     NUMBER      NOT NULL,
    name         VARCHAR(50) NOT NULL,
    start_date   DATE        NOT NULL,
    end_date     DATE        NOT NULL,
    CONSTRAINT PROMOTION_PK PRIMARY KEY (promotion_id),
    CONSTRAINT promotion_discount_check check (discount <= 100)
);


CREATE TABLE sales
(
    sale_id      NUMBER GENERATED BY DEFAULT AS IDENTITY,
    due_dates    DATE   NOT NULL,
    phone_ID     NUMBER NOT NULL,
    promotion_id NUMBER NOT NULL,
    store_id     NUMBER NOT NULL,
    name         VARCHAR(50)   NOT NULL,
    sale_date       Date   NOT NULL,
    CONSTRAINT SALE_PK PRIMARY KEY (sale_id)
);


ALTER TABLE brands
    ADD CONSTRAINT BRAND_ADDRESS_FK
        FOREIGN KEY (address_id)
            REFERENCES addresses (address_id)
                NOT DEFERRABLE;

ALTER TABLE brand_stores
    ADD CONSTRAINT ADDRESS_BRAND_STORE_FK
        FOREIGN KEY (address_id)
            REFERENCES addresses (address_id)
                NOT DEFERRABLE;

ALTER TABLE brand_stores
    ADD CONSTRAINT BRAND_BRAND_STORE_FK
        FOREIGN KEY (brand_id)
            REFERENCES brands (brand_id)
                NOT DEFERRABLE;

ALTER TABLE sales
    ADD CONSTRAINT BRAND_STORE_SALE_FK
        FOREIGN KEY (store_id)
            REFERENCES brand_stores (store_id)
                NOT DEFERRABLE;

ALTER TABLE sales ADD CONSTRAINT SMARTPHONES_SALE_FK
    FOREIGN KEY (phone_ID)
        REFERENCES smartphones (phone_ID)
            NOT DEFERRABLE;

ALTER TABLE sales
    ADD CONSTRAINT PROMOTION_SALE_FK
        FOREIGN KEY (promotion_id)
            REFERENCES promotions (promotion_id)
                NOT DEFERRABLE;