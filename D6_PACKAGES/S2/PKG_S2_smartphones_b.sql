CREATE OR REPLACE PACKAGE BODY PKG_S2_smartphones AS
    PROCEDURE empty_tables_s2 IS
    BEGIN
        -- Leegmaken van de tabellen met DELETE
        DELETE FROM ADDRESSES;
        DELETE FROM BRANDS;
        DELETE FROM BRAND_STORES;
        DELETE FROM SALES;
        DELETE FROM PROMOTIONS;
        COMMIT;
    END empty_tables_s2;

    PROCEDURE add_address(p_zip IN NUMBER, p_city IN VARCHAR2, p_street_number IN NUMBER, p_street IN VARCHAR2) AS
    BEGIN

        INSERT INTO addresses (zip, city, street_number, street)
        VALUES (p_zip, p_city, p_street_number, p_street);
        COMMIT;

    END add_address;

    PROCEDURE add_brand(p_brand_name IN VARCHAR2, p_brand_founder IN VARCHAR2, p_type IN VARCHAR2,
                        p_key_people IN VARCHAR2, p_founding_date IN DATE, p_zip IN NUMBER, p_street IN VARCHAR2,
                        p_street_number IN NUMBER) AS

        ln_address_id INTEGER;

    BEGIN

        ln_address_id := lookup_address_id(p_zip, p_street, p_street_number);

        INSERT INTO brands (brand_name, brand_founder, type, key_people, founding_date, address_id)
        VALUES (p_brand_name, p_brand_founder, p_type, p_key_people, p_founding_date, ln_address_id);
        COMMIT;

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
        COMMIT;

    END add_brand_store;

    PROCEDURE add_promotion(p_promotion_id IN NUMBER, p_discount IN NUMBER, p_name IN VARCHAR2, p_start_date IN DATE,
                            p_end_date IN DATE) IS
    BEGIN

        INSERT INTO promotions (promotion_id, discount, name, start_date, end_date)
        VALUES (p_promotion_id, p_discount, p_name, p_start_date, p_end_date);
        COMMIT;

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
        COMMIT;

    END add_sale;

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


    PROCEDURE bewijs_milestone_M4_S2 AS
    BEGIN





    END bewijs_milestone_M4_S2;


END PKG_S2_smartphones;
/
