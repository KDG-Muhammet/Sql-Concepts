CREATE OR REPLACE PACKAGE BODY PKG_S2_smartphones AS
    PROCEDURE empty_tables_s2 IS
    BEGIN
        -- Leegmaken van de tabellen met DELETE
        DELETE FROM SALES;
        DELETE FROM BRAND_STORES;
        DELETE FROM BRANDS;
        DELETE FROM PROMOTIONS;
        DELETE FROM ADDRESSES;
        COMMIT;
    END empty_tables_s2;

    FUNCTION lookup_brand_id(p_brand_name IN VARCHAR2) RETURN NUMBER AS
        v_brand_id NUMBER;
    BEGIN
        SELECT brand_id
        INTO v_brand_id
        FROM brands
        WHERE brand_name = p_brand_name;

        RETURN v_brand_id;

    END lookup_brand_id;

    FUNCTION lookup_promotion_id(p_promotion_name IN VARCHAR2) RETURN NUMBER AS
        v_promotion_id NUMBER;
    BEGIN
        SELECT promotion_id
        INTO v_promotion_id
        FROM promotions
        WHERE name = p_promotion_name;

        RETURN v_promotion_id;

    END lookup_promotion_id;

    FUNCTION lookup_store_id(p_store_address_zip IN NUMBER, p_store_address_street IN VARCHAR2,
                             p_store_address_street_number IN NUMBER) RETURN NUMBER AS
        v_store_id NUMBER;
    BEGIN
        SELECT store_id
        INTO v_store_id
        FROM brand_stores bs
                 JOIN addresses a ON bs.address_id = a.address_id
        WHERE a.zip = p_store_address_zip
          AND a.street = p_store_address_street
          AND a.street_number = p_store_address_street_number;

        RETURN v_store_id;

    END lookup_store_id;

    FUNCTION lookup_address_id(p_address_zip IN NUMBER, p_address_street IN VARCHAR2,
                               p_address_street_number IN NUMBER) RETURN NUMBER AS
        v_address_id NUMBER;
    BEGIN
        SELECT address_id
        INTO v_address_id
        FROM addresses
        WHERE zip = p_address_zip
          AND street = p_address_street
          AND street_number = p_address_street_number;

        RETURN v_address_id;

    END lookup_address_id;

    PROCEDURE add_address(p_zip IN NUMBER, p_city IN VARCHAR2, p_street_number IN NUMBER, p_street IN VARCHAR2) AS
    BEGIN

        INSERT INTO addresses (zip, city, street_number, street)
        VALUES (p_zip, p_city, p_street_number, p_street);

    END add_address;

    PROCEDURE add_brand(p_brand_name IN VARCHAR2, p_brand_founder IN VARCHAR2, p_type IN VARCHAR2,
                        p_key_people IN VARCHAR2, p_founding_date IN DATE, p_zip IN NUMBER, p_street IN VARCHAR2,
                        p_street_number IN NUMBER) AS

        ln_address_id INTEGER;

    BEGIN

        ln_address_id := lookup_address_id(p_zip, p_street, p_street_number);

        INSERT INTO brands (brand_name, brand_founder, type, key_people, founding_date, address_id)
        VALUES (p_brand_name, p_brand_founder, p_type, p_key_people, p_founding_date, ln_address_id);

    END add_brand;

    PROCEDURE add_brand_store(p_brand_name IN VARCHAR2, p_opening_date IN DATE, p_employee_count IN NUMBER,
                              p_zip IN NUMBER, p_street IN VARCHAR2, p_street_number IN NUMBER) AS

        ln_address_id INTEGER;
        ln_brand_id   INTEGER;

    BEGIN

        ln_address_id := lookup_address_id(p_zip, p_street, p_street_number);
        ln_brand_id := lookup_brand_id(p_brand_name);

        INSERT INTO brand_stores (brand_id, opening_date, employee_count, address_id)
        VALUES (ln_brand_id, p_opening_date, p_employee_count, ln_address_id);

    END add_brand_store;

    PROCEDURE add_promotion(p_promotion_id IN NUMBER, p_discount IN NUMBER, p_name IN VARCHAR2, p_start_date IN DATE,
                            p_end_date IN DATE) IS
    BEGIN

        INSERT INTO promotions (promotion_id, discount, name, start_date, end_date)
        VALUES (p_promotion_id, p_discount, p_name, p_start_date, p_end_date);

    END add_promotion;

    PROCEDURE add_sale(p_due_dates IN DATE, p_phone_name IN VARCHAR2, p_promotion_name IN VARCHAR2,
                       p_store_address_zip IN NUMBER, p_store_address_street IN VARCHAR2,
                       p_store_address_street_number IN NUMBER, p_name IN VARCHAR2, p_sale_date IN DATE) AS

        ln_promotion_id INTEGER;
        ln_store_id     INTEGER;

    BEGIN

        ln_promotion_id := lookup_promotion_id(p_promotion_name);
        ln_store_id := lookup_store_id(p_store_address_zip, p_store_address_street, p_store_address_street_number);

        INSERT INTO sales (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
        VALUES (p_due_dates, (SELECT phone_ID FROM smartphones WHERE name = p_phone_name),
                ln_promotion_id,
                ln_store_id,
                p_name, p_sale_date);

    END add_sale;


    PROCEDURE bewijs_milestone_M4_S2 AS
    BEGIN

        -- Insert data into HQ_Adresses table
        add_address(12345, 'New York', 100, 'Broadway');
        add_address(54321, 'Los Angeles', 200, 'Hollywood Blvd');
        add_address(98765, 'Chicago', 300, 'Michigan Ave');
        add_address(11111, 'Houston', 400, 'Main St');
        add_address(22222, 'San Francisco', 500, 'Market St');
        add_address(54321, 'Cupertino', 200, 'Apple Avenue 2');
        add_address(98765, 'Mountain View', 300, 'Google Drive 3');
        add_address(13509, 'Seoul', 129, 'Samsung-ro');
        add_address(51812, 'Shenzhen', 1, 'Bantian Street');
        add_address(13579, 'Redmond', 1, 'Microsoft Way');
        COMMIT;

        -- Insert data into Brand table
        add_brand('Apple', 'Steve Jobs', 'Technology', 'Tim Cook',
                  TO_DATE('01-04-1976', 'DD-MM-YYYY'), 54321, 'Apple Avenue 2', 200);

        add_brand('Google', 'Larry Page', 'Technology', 'Sundar Pichai',
                  TO_DATE('04-09-1998', 'DD-MM-YYYY'), 98765, 'Google Drive 3', 300);

        add_brand('Samsung', 'Lee Byung-chul', 'Technology', 'Kim Ki-nam',
                  TO_DATE('01-03-1983', 'DD-MM-YYYY'), 13509, 'Samsung-ro', 129);

        add_brand('Huawei', 'Ren Zhengfei', 'Technology', 'Guo Ping',
                  TO_DATE('15-09-1987', 'DD-MM-YYYY'), 51812, 'Bantian Street', 1);

        add_brand('Microsoft', 'Bill Gates', 'Technology', 'Satya Nadella',
                  TO_DATE('04-04-1975', 'DD-MM-YYYY'), 13579, 'Microsoft Way', 1);
        COMMIT;

        -- Insert data into Brand_store table
        add_brand_store('Apple', TO_DATE('01-01-2010', 'DD-MM-YYYY'), 50, 12345, 'Broadway', 100);

        add_brand_store('Google', TO_DATE('15-05-2001', 'DD-MM-YYYY'), 100, 54321, 'Hollywood Blvd', 200);

        add_brand_store('Samsung', TO_DATE('20-09-2005', 'DD-MM-YYYY'), 75, 98765, 'Michigan Ave', 300);

        add_brand_store('Huawei', TO_DATE('10-11-1995', 'DD-MM-YYYY'), 80, 11111, 'Main St', 400);

        add_brand_store('Microsoft', TO_DATE('25-03-2012', 'DD-MM-YYYY'), 60, 22222, 'Market St', 500);
        COMMIT;

        -- Insert data into Promotion table
        add_promotion(1001, 10, 'Summer Sale', TO_DATE('01-06-2023', 'DD-MM-YYYY'),
                      TO_DATE('30-06-2023', 'DD-MM-YYYY'));

        add_promotion(1002, 20, 'Back to School', TO_DATE('15-08-2023', 'DD-MM-YYYY'),
                      TO_DATE('15-09-2023', 'DD-MM-YYYY'));

        add_promotion(1003, 15, 'Holiday Special', TO_DATE('01-12-2023', 'DD-MM-YYYY'),
                      TO_DATE('31-12-2023', 'DD-MM-YYYY'));

        add_promotion(1004, 25, 'New Year Discount', TO_DATE('01-01-2024', 'DD-MM-YYYY'),
                      TO_DATE('31-01-2024', 'DD-MM-YYYY'));

        add_promotion(1005, 30, 'Spring Clearance', TO_DATE('01-04-2024', 'DD-MM-YYYY'),
                      TO_DATE('30-04-2024', 'DD-MM-YYYY'));
        COMMIT;

        -- Insert data into Sale table
        add_sale(TO_DATE('05-08-2024', 'DD-MM-YYYY'), 'iPhone 15', 'Summer Sale', 12345, 'Broadway', 100, 'John Doe',
                 TO_DATE('15-06-2023', 'DD-MM-YYYY'));

        add_sale(TO_DATE('24-12-2024', 'DD-MM-YYYY'), 'iPhone 15', 'Back to School', 12345, 'Broadway', 100,
                 'Jane Smith', TO_DATE('05-09-2023', 'DD-MM-YYYY'));

        add_sale(TO_DATE('10-07-2024', 'DD-MM-YYYY'), 'Samsung A52', 'Holiday Special', 98765, 'Michigan Ave', 300,
                 'Alice Johnson', TO_DATE('20-12-2023', 'DD-MM-YYYY'));

        add_sale(TO_DATE('30-12-2024', 'DD-MM-YYYY'), 'Huawei 7', 'New Year Discount', 11111, 'Main St', 400,
                 'Bob Brown', TO_DATE('10-01-2024', 'DD-MM-YYYY'));

        add_sale(TO_DATE('29-11-2024', 'DD-MM-YYYY'), 'iPhone 15', 'Spring Clearance', 12345, 'Broadway', 100,
                 'Eve Wilson', TO_DATE('10-04-2024', 'DD-MM-YYYY'));
        COMMIT;


    END bewijs_milestone_M4_S2;


END PKG_S2_smartphones;
/
