drop table Brand;
drop table HQ_Adresses;
drop table Brand_store;
drop table Promotion;
drop table Sale;


CREATE TABLE Brand
(
    brand_id      NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    brand_name    VARCHAR(50)                         NOT NULL,
    founding_date DATE                                NOT NULL,
    CONSTRAINT BRAND_PK PRIMARY KEY (brand_id)
);


CREATE TABLE HQ_Adresses
(
    hq_zip    NUMBER(5) NOT NULL,
    brand_id  NUMBER NOT NULL,
    hq_number NUMBER NOT NULL,
    hq_city   CHAR   NOT NULL,
    hq_street CHAR   NOT NULL,
    CONSTRAINT HQ_ADRESSES_PK PRIMARY KEY (hq_zip, brand_id),
    CONSTRAINT hq_zipcode_check check (hq_zip < 100)
);


CREATE TABLE Brand_store
(
    store_id       NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    brand_id       NUMBER                              NOT NULL,
    store_location CHAR                                NOT NULL,
    opening_date   DATE                                NOT NULL,
    employee_count NUMBER                              NOT NULL,
    closing_date   DATE,
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
    sale_id      CHAR GENERATED ALWAYS AS IDENTITY NOT NULL,
    phone_ID     NUMBER   NOT NULL,
    promotion_id NUMBER   NOT NULL,
    store_id     NUMBER   NOT NULL,
    name         CHAR NOT NULL,
    sale_date       DATE NOT NULL,
    CONSTRAINT SALE_PK PRIMARY KEY (sale_id)
);


ALTER TABLE Brand_store
    ADD CONSTRAINT BRAND_BRAND_STORE_FK
        FOREIGN KEY (brand_id)
            REFERENCES Brand (brand_id)
            NOT DEFERRABLE;

ALTER TABLE HQ_Adresses
    ADD CONSTRAINT BRAND_HQ_ADRESSES_FK
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

ALTER TABLE Sale
    ADD CONSTRAINT SMARTPHONES_SALE_FK
        FOREIGN KEY (phone_ID)
            REFERENCES smartphones (phone_ID)
            NOT DEFERRABLE;
