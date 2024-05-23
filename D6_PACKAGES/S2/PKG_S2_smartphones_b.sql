CREATE OR REPLACE PACKAGE BODY PKG_S2_smartphones AS
    TYPE t_address_id_table IS TABLE OF NUMBER INDEX BY PLS_INTEGER;

    --empty tables funtion
    PROCEDURE empty_tables_s2 IS
    BEGIN
        -- Leegmaken van de tabellen met TRUNCATE
        EXECUTE IMMEDIATE 'TRUNCATE TABLE SALES';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE BRAND_STORES';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE BRANDS';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE PROMOTIONS';
        EXECUTE IMMEDIATE 'TRUNCATE TABLE ADDRESSES';
        EXECUTE IMMEDIATE 'ALTER TABLE SALES MODIFY (sale_id GENERATED ALWAYS AS IDENTITY (START WITH 1))';
        EXECUTE IMMEDIATE 'ALTER TABLE BRAND_STORES MODIFY (store_id GENERATED ALWAYS AS IDENTITY (START WITH 1))';
        EXECUTE IMMEDIATE 'ALTER TABLE BRANDS MODIFY (brand_id GENERATED ALWAYS AS IDENTITY (START WITH 1))';
        EXECUTE IMMEDIATE 'ALTER TABLE ADDRESSES MODIFY (address_id GENERATED ALWAYS AS IDENTITY (START WITH 1))';
        EXECUTE IMMEDIATE 'PURGE RECYCLEBIN';


    END empty_tables_s2;

    -- lookup functies
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

    --DDl add single rows into db
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
                              p_closing_date IN DATE,
                              p_zip IN NUMBER, p_street IN VARCHAR2, p_street_number IN NUMBER) AS

        ln_address_id INTEGER;
        ln_brand_id   INTEGER;

    BEGIN

        ln_address_id := lookup_address_id(p_zip, p_street, p_street_number);
        ln_brand_id := lookup_brand_id(p_brand_name);

        INSERT INTO brand_stores (brand_id, opening_date, employee_count, closing_date, address_id)
        VALUES (ln_brand_id, p_opening_date, p_employee_count, p_closing_date, ln_address_id);

    END add_brand_store;

    PROCEDURE add_promotion(p_promotion_id IN NUMBER, p_discount IN NUMBER, p_name IN VARCHAR2, p_start_date IN DATE,
                            p_end_date IN DATE) IS
    BEGIN

        INSERT INTO promotions (promotion_id, discount, name, start_date, end_date)
        VALUES (p_promotion_id, p_discount, p_name, p_start_date, p_end_date);

    END add_promotion;

    PROCEDURE add_sale(p_due_dates IN DATE, p_phonename IN VARCHAR2, p_memory IN NUMBER, p_storage IN NUMBER,
                       p_promotion_name IN VARCHAR2,
                       p_store_address_zip IN NUMBER, p_store_address_street IN VARCHAR2,
                       p_store_address_street_number IN NUMBER, p_name IN VARCHAR2, p_sale_date IN DATE) AS

        ln_promotion_id INTEGER;
        ln_store_id     INTEGER;
        ls_phone_id     INTEGER;

    BEGIN

        ln_promotion_id := lookup_promotion_id(p_promotion_name);
        ln_store_id := lookup_store_id(p_store_address_zip, p_store_address_street, p_store_address_street_number);
        ls_phone_id := PKG_S1_smartphones.lookup_smartphone(p_phonename, p_memory, p_storage);

        INSERT INTO sales (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
        VALUES (p_due_dates, ls_phone_id,
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
        add_brand_store('Apple', TO_DATE('01-01-2010', 'DD-MM-YYYY'), 50, Null, 12345, 'Broadway', 100);

        add_brand_store('Google', TO_DATE('15-05-2001', 'DD-MM-YYYY'), 100, Null, 54321, 'Hollywood Blvd', 200);

        add_brand_store('Samsung', TO_DATE('20-09-2005', 'DD-MM-YYYY'), 75, Null, 98765, 'Michigan Ave', 300);

        add_brand_store('Huawei', TO_DATE('10-11-1995', 'DD-MM-YYYY'), 80, Null, 11111, 'Main St', 400);

        add_brand_store('Microsoft', TO_DATE('25-03-2012', 'DD-MM-YYYY'), 60, Null, 22222, 'Market St', 500);
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
        add_sale(TO_DATE('05-08-2024', 'DD-MM-YYYY'), 'iPhone 15', 32, 512, 'Summer Sale', 12345, 'Broadway', 100,
                 'John Doe',
                 TO_DATE('15-06-2023', 'DD-MM-YYYY'));

        add_sale(TO_DATE('24-12-2024', 'DD-MM-YYYY'), 'iPhone 15', 32, 512, 'Back to School', 12345, 'Broadway', 100,
                 'Jane Smith', TO_DATE('05-09-2023', 'DD-MM-YYYY'));

        add_sale(TO_DATE('10-07-2024', 'DD-MM-YYYY'), 'Samsung A52', 16, 256, 'Holiday Special', 98765, 'Michigan Ave',
                 300,
                 'Alice Johnson', TO_DATE('20-12-2023', 'DD-MM-YYYY'));

        add_sale(TO_DATE('30-12-2024', 'DD-MM-YYYY'), 'Huawei 7', 4, 64, 'New Year Discount', 11111, 'Main St', 400,
                 'Bob Brown', TO_DATE('10-01-2024', 'DD-MM-YYYY'));

        add_sale(TO_DATE('29-11-2024', 'DD-MM-YYYY'), 'iPhone 15', 32, 512, 'Spring Clearance', 12345, 'Broadway', 100,
                 'Eve Wilson', TO_DATE('10-04-2024', 'DD-MM-YYYY'));
        COMMIT;


    END bewijs_milestone_M4_S2;



    FUNCTION get_unused_address_id(used_address_ids IN OUT NOCOPY t_address_id_table,
                                   available_address_ids IN t_address_id_table) RETURN NUMBER IS
        v_random_index PLS_INTEGER;
        v_address_id   NUMBER;
    BEGIN
        LOOP
            v_random_index := PKG_SAMEN_SMARTPHONES.generate_random_number(1, available_address_ids.COUNT);
            v_address_id := available_address_ids(v_random_index);

            -- Controleer of het address_id al gebruikt is
            IF NOT used_address_ids.EXISTS(v_address_id) THEN
                -- Voeg het address_id toe aan de lijst van gebruikte address_ids
                used_address_ids(v_address_id) := v_address_id;
                RETURN v_address_id;
            END IF;
        END LOOP;
    END get_unused_address_id;

    FUNCTION get_ids(available_ids IN OUT NOCOPY t_address_id_table) RETURN NUMBER IS
        v_random_index PLS_INTEGER;
        v_id   NUMBER;
    BEGIN
            v_random_index := PKG_SAMEN_SMARTPHONES.generate_random_number(1, available_ids.COUNT);
            v_id := available_ids(v_random_index);
        return v_id;
    END get_ids;

    PROCEDURE generate_addresses(p_count IN NUMBER) IS
        v_zip             NUMBER;
        v_city            VARCHAR2(50);
        v_street          VARCHAR2(50);
        v_street_number   NUMBER;
        v_start_timestamp TIMESTAMP;
        v_end_timestamp   TIMESTAMP;
        v_duration        NUMBER;

    BEGIN

        v_start_timestamp := SYSTIMESTAMP;

        FOR i IN 1 .. p_count
            LOOP
                v_zip := PKG_SAMEN_SMARTPHONES.generate_random_number(1000, 99999);
                v_city := PKG_SAMEN_SMARTPHONES.GET_RANDOM_LIST_COMBINATION(
                        SYS.ODCIVARCHAR2LIST('New York', 'Los Angeles', 'Chicago', 'Houston', 'San Francisco',
                                             'Cupertino', 'Mountain View', 'Seoul', 'Shenzhen', 'Redmond'), i);
                v_street := PKG_SAMEN_SMARTPHONES.GET_RANDOM_LIST_COMBINATION(
                        SYS.ODCIVARCHAR2LIST('Broadway', 'Hollywood Blvd', 'Main St', 'Market St', 'Apple Avenue 2',
                                             'Google Drive 3', 'Samsung-ro', 'Bantian Street', 'Microsoft Way'), i);
                v_street_number := PKG_SAMEN_SMARTPHONES.generate_random_number(1, 100);

                add_address(v_zip, v_city, v_street_number, v_street);

            END LOOP;

        v_end_timestamp := SYSTIMESTAMP;
        v_duration := PKG_SAMEN_SMARTPHONES.timestamp_diff(v_end_timestamp, v_start_timestamp);

        -- Log de functienaam, parameters, aantal toegevoegde rijen en de duur van de procedure
        DBMS_OUTPUT.PUT_LINE('Procedure generate_addresses_single executed with p_count = ' || p_count ||
                             '. Rows added: ' || p_count || '. Duration: ' || v_duration || ' seconds.');

    END generate_addresses;

    PROCEDURE generate_brands(p_count IN NUMBER) IS
        v_brand_name            VARCHAR2(50);
        v_brand_founder         VARCHAR2(50);
        v_type                  VARCHAR2(50);
        v_key_people            VARCHAR2(50);
        v_founding_date         DATE;
        v_address_id            NUMBER;
        v_used_address_ids      t_address_id_table;
        v_available_address_ids t_address_id_table;
        v_start_timestamp       TIMESTAMP;
        v_end_timestamp         TIMESTAMP;
        v_duration              NUMBER;

    BEGIN-- Haal alle beschikbare address_ids op
        SELECT address_id BULK COLLECT
        INTO v_available_address_ids
        FROM addresses;

        v_start_timestamp := SYSTIMESTAMP;


        FOR i IN 1 .. p_count
            LOOP
                v_brand_name := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Samsung', 'Apple', 'Google', 'Huawei', 'Microsoft'), i);
                v_brand_founder := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Steve Jobs', 'Larry Page', 'Lee Byung-chul', 'Ren Zhengfei',
                                             'Bill Gates'), i);
                v_type := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Electronics', 'Mobile', 'Telecom', 'Gadgets', 'Technology'), i);
                v_key_people := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Tim Cook', 'Sundar Pichai', 'Kim Ki-nam', 'Guo Ping', 'Satya Nadella'),
                        i);
                v_founding_date := PKG_SAMEN_SMARTPHONES.generate_random_date(to_date('1975-04-04', 'YYYY-MM-DD'),
                                                                              to_date('2000-01-01', 'YYYY-MM-DD'));
                v_address_id := get_unused_address_id(v_used_address_ids, v_available_address_ids);

                INSERT INTO brands (brand_name, brand_founder, type, key_people, founding_date, address_id)
                VALUES (v_brand_name, v_brand_founder, v_type, v_key_people, v_founding_date, v_address_id);

                --add_brand(v_brand_name,v_brand_founder,v_type,v_key_people,v_founding_date);

            END LOOP;

        v_end_timestamp := SYSTIMESTAMP;
        v_duration := PKG_SAMEN_SMARTPHONES.timestamp_diff(v_end_timestamp, v_start_timestamp);

        -- Log de functienaam, parameters, aantal toegevoegde rijen en de duur van de procedure
        DBMS_OUTPUT.PUT_LINE('Procedure generate_brands_single executed with p_count = ' || p_count ||
                             '. Rows added: ' || p_count || '. Duration: ' || v_duration || ' seconds.');

    END generate_brands;

    PROCEDURE generate_brands_stores(p_num_stores_per_brand IN NUMBER) IS
        TYPE brand_store_rec IS RECORD
                                (
                                    brand_id       brands.brand_id%TYPE,
                                    opening_date   DATE,
                                    employee_count NUMBER,
                                    closing_date   DATE,
                                    address_id     addresses.address_id%TYPE
                                );
        v_brand_id              brands.brand_id%TYPE;
        v_opening_date          DATE;
        v_closing_date          DATE;
        v_random_address_id     addresses.address_id%TYPE;
        v_employee_count        NUMBER;
        v_used_address_ids      t_address_id_table; -- Associatieve array voor gebruikte address_ids
        v_available_address_ids t_address_id_table;
        v_start_timestamp       TIMESTAMP;
        v_end_timestamp         TIMESTAMP;
        v_duration              NUMBER;
        total_rows_added        NUMBER := 0;
        CURSOR c_brands IS
            SELECT brand_id
            FROM brands;

    BEGIN
        v_start_timestamp := SYSTIMESTAMP;

        SELECT address_id BULK COLLECT
        INTO v_available_address_ids
        FROM addresses;

        -- Haal alle gebruikte address_ids in brands op
        SELECT address_id BULK COLLECT
        INTO v_used_address_ids
        FROM brands;

        FOR r_brand IN c_brands
            LOOP
                FOR i IN 1 .. p_num_stores_per_brand
                    LOOP
                        v_opening_date :=
                                PKG_SAMEN_SMARTPHONES.generate_random_date(TO_DATE('2000-01-01', 'YYYY-MM-DD'),
                                                                           TO_DATE('2020-01-01', 'YYYY-MM-DD'));
                        v_employee_count := PKG_SAMEN_SMARTPHONES.generate_random_number(10, 100);
                        v_closing_date := v_opening_date + PKG_SAMEN_SMARTPHONES.GENERATE_RANDOM_NUMBER(1000, 200000);
                        v_random_address_id := get_unused_address_id(v_used_address_ids, v_available_address_ids);

                        INSERT INTO brand_stores (brand_id, opening_date, employee_count, closing_date, address_id)
                        VALUES (r_brand.brand_id, v_opening_date, v_employee_count, v_closing_date,
                                v_random_address_id);

                        total_rows_added := total_rows_added + 1;
                    END LOOP;
            END LOOP;

        v_end_timestamp := SYSTIMESTAMP;
        v_duration := PKG_SAMEN_SMARTPHONES.timestamp_diff(v_end_timestamp, v_start_timestamp);

        -- Log de functienaam, parameters, aantal toegevoegde rijen en de duur van de procedure
        DBMS_OUTPUT.PUT_LINE('Procedure generateBrandStores_single executed with p_num_stores_per_brand = ' ||
                             p_num_stores_per_brand ||
                             '. Rows added: ' || total_rows_added || '. Duration: ' || v_duration || ' seconds.');
    END generate_brands_stores;

    PROCEDURE generate_promotions(p_count IN NUMBER) IS
        v_discount        NUMBER;
        v_name            VARCHAR2(50);
        v_start_date      DATE;
        v_end_date        DATE;
        v_start_timestamp TIMESTAMP;
        v_end_timestamp   TIMESTAMP;
        v_duration        NUMBER;

    BEGIN

        v_start_timestamp := SYSTIMESTAMP;

        FOR i IN 1 .. p_count
            LOOP
                v_discount := PKG_SAMEN_SMARTPHONES.generate_random_number(5, 90);
                v_name := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Summer Sale', 'Back to School', 'Holiday Special', 'New Year Discount',
                                             'Spring Clearance'), i);
                v_start_date := PKG_SAMEN_SMARTPHONES.generate_random_date(to_date('2023-01-01', 'YYYY-MM-DD'),
                                                                           to_date('2023-04-01', 'YYYY-MM-DD'));
                v_end_date := v_start_date + PKG_SAMEN_SMARTPHONES.generate_random_number(1, 30);

                add_promotion(1005 + i, v_discount, v_name, v_start_date, v_end_date);

            END LOOP;

        v_end_timestamp := SYSTIMESTAMP;
        v_duration := PKG_SAMEN_SMARTPHONES.timestamp_diff(v_end_timestamp, v_start_timestamp);

        -- Log de functienaam, parameters, aantal toegevoegde rijen en de duur van de procedure
        DBMS_OUTPUT.PUT_LINE('Procedure generate_promotions_single executed with p_count = ' || p_count ||
                             '. Rows added: ' || p_count || '. Duration: ' || v_duration || ' seconds.');

    END generate_promotions;

    PROCEDURE generate_sales(s_rows_per_store IN NUMBER) IS
        TYPE sale_rec IS RECORD
                         (
                             DUE_DATES    DATE,
                             PHONE_ID     NUMBER,
                             PROMOTION_ID NUMBER,
                             STORE_ID     NUMBER,
                             NAME         VARCHAR2(50),
                             sale_date    DATE
                         );
        v_name            VARCHAR2(50);
        v_due_dates       DATE;
        v_sale_date       DATE;
        v_promotion_id    NUMBER;
        v_phone_id        NUMBER;
        v_store_id        NUMBER;
        v_start_timestamp TIMESTAMP;
        v_end_timestamp   TIMESTAMP;
        v_duration        NUMBER;
        total_rows_added  NUMBER := 0;
        v_available_promotion_ids t_address_id_table;
        v_available_phone_ids t_address_id_table;
        CURSOR c_brand_stores IS
            SELECT STORE_ID
            FROM BRAND_STORES;

    BEGIN
        v_start_timestamp := SYSTIMESTAMP;

        SELECT PHONE_ID BULK COLLECT
        INTO v_available_phone_ids
        FROM SMARTPHONES;

        SELECT PROMOTION_ID BULK COLLECT
        INTO v_available_promotion_ids
        FROM PROMOTIONS;

        FOR r_brand_store IN c_brand_stores
            LOOP
                FOR i IN 1 .. s_rows_per_store
                    LOOP
                        v_due_dates := PKG_SAMEN_SMARTPHONES.generate_random_date(TO_DATE('2023-01-01', 'YYYY-MM-DD'),
                                                                                  TO_DATE('2024-12-31', 'YYYY-MM-DD'));
                        v_name := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                                SYS.ODCIVARCHAR2LIST('John Doe', 'Jane Smith', 'Alice Johnson', 'Bob Brown',
                                                     'Eve Wilson'), i);
                        v_sale_date := v_due_dates + PKG_SAMEN_SMARTPHONES.generate_random_number(10, 30);
                        v_promotion_id := get_ids(v_available_promotion_ids);
                        v_phone_id := get_ids(v_available_phone_ids);
                        v_store_id := r_brand_store.STORE_ID;

                        INSERT INTO sales (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
                        VALUES (v_due_dates, v_phone_id, v_promotion_id, v_store_id, v_name, v_sale_date);

                        total_rows_added := total_rows_added + 1;
                    END LOOP;
            END LOOP;

        v_end_timestamp := SYSTIMESTAMP;
        v_duration := PKG_SAMEN_SMARTPHONES.timestamp_diff(v_end_timestamp, v_start_timestamp);

        -- Log de functienaam, parameters, aantal toegevoegde rijen en de duur van de procedure
        DBMS_OUTPUT.PUT_LINE('Procedure generate_sales_single executed with s_rows_per_store = ' || s_rows_per_store ||
                             '. Rows added: ' || total_rows_added || '. Duration: ' || v_duration || ' seconds.');
    END generate_sales;


    PROCEDURE bewijs_milestone_M5_S2 AS
    BEGIN

        generate_addresses(1100);

        generate_brands(30);

        generate_brands_stores(30);

        generate_promotions(30);

        generate_sales(600);

    END bewijs_milestone_M5_S2;


    -- funcities bulk

    PROCEDURE generate_addresses_bulk(p_count IN NUMBER) IS
        TYPE address_rec IS RECORD
                            (
                                zip           NUMBER,
                                city          VARCHAR2(50),
                                street        VARCHAR2(50),
                                street_number NUMBER
                            );
        TYPE address_table IS TABLE OF address_rec INDEX BY PLS_INTEGER;
        v_addresses       address_table;
        v_zip             NUMBER;
        v_city            VARCHAR2(50);
        v_street          VARCHAR2(50);
        v_street_number   NUMBER;
        v_start_timestamp TIMESTAMP;
        v_end_timestamp   TIMESTAMP;
        v_duration        NUMBER;

    BEGIN
        v_start_timestamp := SYSTIMESTAMP;

        FOR i IN 1 .. p_count
            LOOP
                v_zip := PKG_SAMEN_SMARTPHONES.generate_random_number(1000, 99999);
                v_city := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('New York', 'Los Angeles', 'Chicago', 'Houston', 'San Francisco',
                                             'Cupertino', 'Mountain View', 'Seoul', 'Shenzhen', 'Redmond'), i);
                v_street := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Broadway', 'Hollywood Blvd', 'Main St', 'Market St', 'Apple Avenue 2',
                                             'Google Drive 3', 'Samsung-ro', 'Bantian Street', 'Microsoft Way'), i);
                v_street_number := PKG_SAMEN_SMARTPHONES.generate_random_number(1, 100);

                v_addresses(i).zip := v_zip;
                v_addresses(i).city := v_city;
                v_addresses(i).street := v_street;
                v_addresses(i).street_number := v_street_number;
            END LOOP;

        FORALL i IN INDICES OF v_addresses
            INSERT INTO addresses (zip, city, street_number, street)
            VALUES (v_addresses(i).zip, v_addresses(i).city, v_addresses(i).street_number, v_addresses(i).street);

        v_end_timestamp := SYSTIMESTAMP;
        v_duration := PKG_SAMEN_SMARTPHONES.timestamp_diff(v_end_timestamp, v_start_timestamp);

        -- Log de functienaam, parameters, aantal toegevoegde rijen en de duur van de procedure
        DBMS_OUTPUT.PUT_LINE('Procedure generate_addresses_bulk executed with p_count = ' || p_count ||
                             '. Rows added: ' || p_count || '. Duration: ' || v_duration || ' seconds.');
    END generate_addresses_bulk;

    PROCEDURE generate_brands_bulk(p_count IN NUMBER) IS
        TYPE brand_rec IS RECORD
                          (
                              BRAND_NAME    VARCHAR2(50),
                              BRAND_FOUNDER VARCHAR2(50),
                              TYPE          VARCHAR2(50),
                              KEY_PEOPLE    VARCHAR2(50),
                              FOUNDING_DATE DATE,
                              ADDRESS_ID    NUMBER
                          );
        TYPE brand_table IS TABLE OF brand_rec INDEX BY PLS_INTEGER;
        v_brands                brand_table;
        v_brand_name            VARCHAR2(50);
        v_brand_founder         VARCHAR2(50);
        v_type                  VARCHAR2(50);
        v_key_people            VARCHAR2(50);
        v_founding_date         DATE;
        v_address_id            NUMBER;
        v_start_timestamp       TIMESTAMP;
        v_end_timestamp         TIMESTAMP;
        v_duration              NUMBER;
        total_rows_added        NUMBER := 0;
        v_used_address_ids      t_address_id_table;
        v_available_address_ids t_address_id_table;

    BEGIN
        v_start_timestamp := SYSTIMESTAMP;

        -- Haal alle beschikbare address_ids op
        SELECT address_id BULK COLLECT INTO v_available_address_ids FROM addresses;

        FOR i IN 1 .. p_count
            LOOP
                v_brand_name := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Samsung', 'Apple', 'Google', 'Huawei', 'Microsoft'), i);
                v_brand_founder := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Steve Jobs', 'Larry Page', 'Lee Byung-chul', 'Ren Zhengfei',
                                             'Bill Gates'), i);
                v_type := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Electronics', 'Mobile', 'Telecom', 'Gadgets', 'Technology'), i);
                v_key_people := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Tim Cook', 'Sundar Pichai', 'Kim Ki-nam', 'Guo Ping', 'Satya Nadella'),
                        i);
                v_founding_date := PKG_SAMEN_SMARTPHONES.generate_random_date(TO_DATE('1975-04-04', 'YYYY-MM-DD'),
                                                                              TO_DATE('2000-01-01', 'YYYY-MM-DD'));
                v_address_id := get_unused_address_id(v_used_address_ids, v_available_address_ids);

                v_brands(i).BRAND_NAME := v_brand_name;
                v_brands(i).BRAND_FOUNDER := v_brand_founder;
                v_brands(i).TYPE := v_type;
                v_brands(i).KEY_PEOPLE := v_key_people;
                v_brands(i).FOUNDING_DATE := v_founding_date;
                v_brands(i).ADDRESS_ID := v_address_id;

                total_rows_added := total_rows_added + 1;
            END LOOP;

        FORALL i IN INDICES OF v_brands
            INSERT INTO brands (brand_name, brand_founder, type, key_people, founding_date, address_id)
            VALUES (v_brands(i).BRAND_NAME, v_brands(i).BRAND_FOUNDER, v_brands(i).TYPE, v_brands(i).KEY_PEOPLE,
                    v_brands(i).FOUNDING_DATE, v_brands(i).ADDRESS_ID);

        v_end_timestamp := SYSTIMESTAMP;
        v_duration := PKG_SAMEN_SMARTPHONES.timestamp_diff(v_end_timestamp, v_start_timestamp);

        -- Log de functienaam, parameters, aantal toegevoegde rijen en de duur van de procedure
        DBMS_OUTPUT.PUT_LINE('Procedure generate_brands_bulk executed with p_count = ' || p_count ||
                             '. Rows added: ' || total_rows_added || '. Duration: ' || v_duration || ' seconds.');
    END generate_brands_bulk;

    PROCEDURE generate_brand_stores_bulk(p_num_stores_per_brand IN NUMBER) IS
        TYPE brand_store_rec IS RECORD
                                (
                                    brand_id       brands.brand_id%TYPE,
                                    opening_date   DATE,
                                    employee_count NUMBER,
                                    closing_date   DATE,
                                    address_id     addresses.address_id%TYPE
                                );
        TYPE brand_store_table IS TABLE OF brand_store_rec INDEX BY PLS_INTEGER;
        v_brand_stores          brand_store_table;
        v_brand_id              brands.brand_id%TYPE;
        v_opening_date          DATE;
        v_closing_date          DATE;
        v_random_address_id     addresses.address_id%TYPE;
        v_employee_count        NUMBER;
        v_used_address_ids      t_address_id_table; -- Associatieve array voor gebruikte address_ids
        v_available_address_ids t_address_id_table;
        v_start_timestamp       TIMESTAMP;
        v_end_timestamp         TIMESTAMP;
        v_duration              NUMBER;
        total_rows_added        NUMBER := 0;
        CURSOR c_brands IS
            SELECT brand_id
            FROM brands;

    BEGIN

        v_start_timestamp := SYSTIMESTAMP;


        SELECT address_id BULK COLLECT
        INTO v_available_address_ids
        FROM addresses;

        -- Haal alle gebruikte address_ids in brands op
        SELECT address_id BULK COLLECT
        INTO v_used_address_ids
        FROM brands;

        FOR r_brand IN c_brands
            LOOP
                FOR i IN 1 .. p_num_stores_per_brand
                    LOOP

                        v_opening_date :=
                                PKG_SAMEN_SMARTPHONES.generate_random_date(to_date('2000-01-01', 'YYYY-MM-DD'),
                                                                           to_date('2020-01-01', 'YYYY-MM-DD'));
                        v_employee_count := PKG_SAMEN_SMARTPHONES.generate_random_number(10, 100);
                        v_closing_date := v_opening_date + PKG_SAMEN_SMARTPHONES.GENERATE_RANDOM_NUMBER(1000, 200000);
                        v_random_address_id := get_unused_address_id(v_used_address_ids, v_available_address_ids);


                        v_brand_stores((r_brand.brand_id - 1) * p_num_stores_per_brand + i).brand_id :=
                                r_brand.brand_id;
                        v_brand_stores((r_brand.brand_id - 1) * p_num_stores_per_brand + i).opening_date :=
                                v_opening_date;
                        v_brand_stores((r_brand.brand_id - 1) * p_num_stores_per_brand + i).employee_count :=
                                v_employee_count;
                        v_brand_stores((r_brand.brand_id - 1) * p_num_stores_per_brand + i).closing_date :=
                                    v_opening_date + PKG_SAMEN_SMARTPHONES.GENERATE_RANDOM_NUMBER(1000, 200000);
                        v_brand_stores((r_brand.brand_id - 1) * p_num_stores_per_brand + i).address_id :=
                                v_random_address_id;

                        total_rows_added := total_rows_added + 1;

                    END LOOP;
            END LOOP;

        -- Bulk insert
        FORALL i IN INDICES OF v_brand_stores
            INSERT INTO brand_stores (brand_id, opening_date, employee_count, closing_date, address_id)
            VALUES (v_brand_stores(i).brand_id, v_brand_stores(i).opening_date, v_brand_stores(i).employee_count,
                    v_brand_stores(i).closing_date, v_brand_stores(i).address_id);


        v_end_timestamp := SYSTIMESTAMP;
        v_duration := PKG_SAMEN_SMARTPHONES.timestamp_diff(v_end_timestamp, v_start_timestamp);

        -- Log de functienaam, parameters, aantal toegevoegde rijen en de duur van de procedure
        DBMS_OUTPUT.PUT_LINE('Procedure generate_brand_stores_bulk executed with p_count = ' ||
                             p_num_stores_per_brand ||
                             '. Rows added: ' || total_rows_added || '. Duration: ' || v_duration || ' seconds.');

    END generate_brand_stores_bulk;

    PROCEDURE generate_promotions_bulk(p_count IN NUMBER) IS
        TYPE promotion_rec IS RECORD
                              (
                                  promotion_id NUMBER,
                                  discount     NUMBER,
                                  name         VARCHAR2(50),
                                  start_date   DATE,
                                  end_date     DATE
                              );
        TYPE promotion_table IS TABLE OF promotion_rec INDEX BY PLS_INTEGER;
        v_promotions      promotion_table;
        v_promotion_id    NUMBER;
        v_discount        NUMBER;
        v_name            VARCHAR2(50);
        v_start_date      DATE;
        v_end_date        DATE;
        v_start_timestamp TIMESTAMP;
        v_end_timestamp   TIMESTAMP;
        v_duration        NUMBER;

    BEGIN
        v_start_timestamp := SYSTIMESTAMP;

        FOR i IN 1 .. p_count
            LOOP
                v_discount := PKG_SAMEN_SMARTPHONES.generate_random_number(5, 90);
                v_name := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                        SYS.ODCIVARCHAR2LIST('Summer Sale', 'Back to School', 'Holiday Special', 'New Year Discount',
                                             'Spring Clearance'), i);
                v_start_date := PKG_SAMEN_SMARTPHONES.generate_random_date(TO_DATE('2023-01-01', 'YYYY-MM-DD'),
                                                                           TO_DATE('2023-04-01', 'YYYY-MM-DD'));
                v_end_date := v_start_date + PKG_SAMEN_SMARTPHONES.generate_random_number(1, 30);
                v_promotion_id := 1005 + i;

                v_promotions(i).promotion_id := v_promotion_id;
                v_promotions(i).discount := v_discount;
                v_promotions(i).name := v_name;
                v_promotions(i).start_date := v_start_date;
                v_promotions(i).end_date := v_end_date;

            END LOOP;

        FORALL i IN INDICES OF v_promotions
            INSERT INTO promotions (promotion_id, discount, name, start_date, end_date)
            VALUES (v_promotions(i).promotion_id, v_promotions(i).discount, v_promotions(i).name,
                    v_promotions(i).start_date, v_promotions(i).end_date);

        v_end_timestamp := SYSTIMESTAMP;
        v_duration := PKG_SAMEN_SMARTPHONES.timestamp_diff(v_end_timestamp, v_start_timestamp);

        -- Log de functienaam, parameters, aantal toegevoegde rijen en de duur van de procedure
        DBMS_OUTPUT.PUT_LINE('Procedure generate_promotions_bulk executed with p_count = ' || p_count ||
                             '. Rows added: ' || p_count || '. Duration: ' || v_duration || ' seconds.');
    END generate_promotions_bulk;

    PROCEDURE generate_sales_bulk(s_rows_per_store IN NUMBER) IS
        TYPE sale_rec IS RECORD
                         (
                             DUE_DATES    DATE,
                             PHONE_ID     NUMBER,
                             PROMOTION_ID NUMBER,
                             STORE_ID     NUMBER,
                             NAME         VARCHAR2(50),
                             sale_date    DATE

                         );
        TYPE sale_table IS TABLE OF sale_rec INDEX BY PLS_INTEGER;
        v_sales           sale_table;
        v_name            VARCHAR2(50);
        v_due_dates       DATE;
        v_sale_date       DATE;
        v_promotion_id    NUMBER;
        v_phone_id        NUMBER;
        v_start_timestamp TIMESTAMP;
        v_end_timestamp   TIMESTAMP;
        v_duration        NUMBER;
        v_available_promotion_ids t_address_id_table;
        v_available_phone_ids t_address_id_table;
        total_rows_added  NUMBER := 0;
        CURSOR c_brand_stores IS
            SELECT STORE_ID
            FROM BRAND_STORES;

    BEGIN

        v_start_timestamp := SYSTIMESTAMP;

        SELECT PHONE_ID BULK COLLECT
        INTO v_available_phone_ids
        FROM SMARTPHONES;

        SELECT PROMOTION_ID BULK COLLECT
        INTO v_available_promotion_ids
        FROM PROMOTIONS;

        FOR r_brand_store IN c_brand_stores
            LOOP

                FOR i IN 1 .. s_rows_per_store
                    LOOP

                        v_due_dates := PKG_SAMEN_SMARTPHONES.generate_random_date(to_date('2023-01-01', 'YYYY-MM_DD'),
                                                                                  to_date('2024-12-31', 'YYYY-MM_DD'));
                        v_name := PKG_SAMEN_SMARTPHONES.get_random_list_combination(
                                SYS.ODCIVARCHAR2LIST('John Doe', 'Jane Smith', 'Alice Johnson', 'Bob Brown',
                                                     'Eve Wilson'),
                                i);
                        v_sale_date := v_due_dates + PKG_SAMEN_SMARTPHONES.generate_random_number(10, 30);
                        v_promotion_id := get_ids(v_available_promotion_ids);
                        v_phone_id := get_ids(v_available_phone_ids);




                        v_sales((r_brand_store.STORE_ID - 1) * s_rows_per_store + i).STORE_ID :=
                                r_brand_store.STORE_ID;
                        v_sales((r_brand_store.STORE_ID - 1) * s_rows_per_store + i).DUE_DATES :=
                                v_due_dates;
                        v_sales((r_brand_store.STORE_ID - 1) * s_rows_per_store + i).NAME :=
                                v_name;
                        v_sales((r_brand_store.STORE_ID - 1) * s_rows_per_store + i).sale_date :=
                                    v_due_dates + PKG_SAMEN_SMARTPHONES.GENERATE_RANDOM_NUMBER(10, 30);
                        v_sales((r_brand_store.STORE_ID - 1) * s_rows_per_store + i).PROMOTION_ID :=
                                v_promotion_id;
                        v_sales((r_brand_store.STORE_ID - 1) * s_rows_per_store + i).PHONE_ID :=
                                v_phone_id;

                        total_rows_added := total_rows_added + 1;

                    END LOOP;
            END LOOP;


        FORALL i IN INDICES OF v_sales
            INSERT INTO sales (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
            VALUES (v_sales(i).DUE_DATES, v_sales(i).PHONE_ID, v_sales(i).PROMOTION_ID,
                    v_sales(i).STORE_ID, v_sales(i).NAME, v_sales(i).sale_date);


        v_end_timestamp := SYSTIMESTAMP;
        v_duration := PKG_SAMEN_SMARTPHONES.timestamp_diff(v_end_timestamp, v_start_timestamp);

        -- Log de functienaam, parameters, aantal toegevoegde rijen en de duur van de procedure
        DBMS_OUTPUT.PUT_LINE('Procedure generate_sales_bulk executed with p_count = ' || s_rows_per_store ||
                             '. Rows added: ' || total_rows_added || '. Duration: ' || v_duration || ' seconds.');

    END generate_sales_bulk;

    PROCEDURE bewijs_milestone_M7_S2 AS
    BEGIN

        empty_tables_s2;
        bewijs_milestone_M4_S2;
        DBMS_OUTPUT.PUT_LINE('comparison single bulk - bewijs_milestone_M5_S2(30,30,30,600)');
        BEWIJS_MILESTONE_M5_S2();

        empty_tables_s2;
        bewijs_milestone_M4_S2;
        DBMS_OUTPUT.PUT_LINE('comparison bulk - bewijs_milestone_M7_S2(30,30,30,600)');
        generate_addresses_bulk(1100);
        generate_brands_bulk(30);
        generate_brand_stores_bulk(30);
        generate_promotions_bulk(30);
        generate_sales_bulk(600);

    END bewijs_milestone_M7_S2;




END PKG_S2_smartphones;
/
