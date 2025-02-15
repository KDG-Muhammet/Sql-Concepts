drop table Brand;
drop table Address;
drop table Brand_store;
drop table Promotion;
drop table Sale;


CREATE TABLE Brand
(
    brand_id       NUMBER GENERATED BY DEFAULT AS IDENTITY,
    brand_name     VARCHAR(50) NOT NULL,
    brand_founder CHAR        NOT NULL,
    type          CHAR        NOT NULL,
    key_people    CHAR        NOT NULL,
    founding_date  DATE        NOT NULL,
    address_id     NUMBER      NOT NULL,
    CONSTRAINT BRAND_PK PRIMARY KEY (brand_id)
);


CREATE TABLE Address
(
    address_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    zip        NUMBER(5)   NOT NULL,
    city       VARCHAR(50) NOT NULL,
    street_number    NUMBER      NOT NULL,
    street     CHAR        NOT NULL,
    CONSTRAINT ADDRESS_PK PRIMARY KEY (address_id),
    CONSTRAINT zipcode_check check (zip < 0)
);


CREATE TABLE Brand_store
(
    store_id       NUMBER GENERATED BY DEFAULT AS IDENTITY,
    brand_id       NUMBER NOT NULL,
    opening_date   DATE   NOT NULL,
    employee_count NUMBER NOT NULL,
    closing_date   DATE,
    address_id     NUMBER NOT NULL,
    CONSTRAINT BRAND_STORE_PK PRIMARY KEY (store_id)
);


CREATE TABLE Promotion
(
    promotion_id NUMBER      NOT NULL,
    discount     NUMBER      NOT NULL,
    name         VARCHAR(50) NOT NULL,
    start_date   DATE        NOT NULL,
    end_date     DATE        NOT NULL,
    CONSTRAINT PROMOTION_PK PRIMARY KEY (promotion_id),
    CONSTRAINT promotion_discount_check check (discount <= 100)
);


CREATE TABLE Sale
(
    sale_id      NUMBER GENERATED BY DEFAULT AS IDENTITY,
    due_dates    DATE   NOT NULL,
    phone_ID     NUMBER NOT NULL,
    promotion_id NUMBER NOT NULL,
    store_id     NUMBER NOT NULL,
    name         CHAR   NOT NULL,
    sale_date       Date   NOT NULL,
    CONSTRAINT SALE_PK PRIMARY KEY (sale_id)
);


ALTER TABLE Brand
    ADD CONSTRAINT BRAND_ADDRESS_FK
        FOREIGN KEY (address_id)
            REFERENCES Address (address_id)
                NOT DEFERRABLE;

ALTER TABLE Brand_store
    ADD CONSTRAINT ADDRESS_BRAND_STORE_FK
        FOREIGN KEY (address_id)
            REFERENCES Address (address_id)
                NOT DEFERRABLE;

ALTER TABLE Brand_store
    ADD CONSTRAINT BRAND_BRAND_STORE_FK
        FOREIGN KEY (brand_id)
            REFERENCES Brand (brand_id)
                NOT DEFERRABLE;

ALTER TABLE Sale
    ADD CONSTRAINT BRAND_STORE_SALE_FK
        FOREIGN KEY (store_id)
            REFERENCES Brand_store (store_id)
                NOT DEFERRABLE;

ALTER TABLE Sale
    ADD CONSTRAINT PROMOTION_SALE_FK
        FOREIGN KEY (promotion_id)
            REFERENCES Promotion (promotion_id)
                NOT DEFERRABLE;


