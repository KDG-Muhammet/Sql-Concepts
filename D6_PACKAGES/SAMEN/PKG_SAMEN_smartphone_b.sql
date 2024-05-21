CREATE OR REPLACE PACKAGE BODY PKG_SAMEN_smartphones AS

    -- Random data functions

    FUNCTION generate_random_number(p_min IN NUMBER, p_max IN NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN FLOOR(DBMS_RANDOM.VALUE(p_min, p_max));
    END generate_random_number;


    FUNCTION generate_random_date(p_start_date IN DATE, p_end_date IN DATE) RETURN DATE IS
        v_days_difference NUMBER;
        v_random_days     NUMBER;
    BEGIN

        v_days_difference := p_end_date - p_start_date;
        v_random_days := generate_random_number(0, v_days_difference);
        RETURN p_start_date + v_random_days;
    END generate_random_date;


    FUNCTION get_random_element(p_list IN SYS.ODCIVARCHAR2LIST) RETURN VARCHAR2 IS
    BEGIN
        RETURN p_list(FLOOR(DBMS_RANDOM.VALUE(1, p_list.COUNT)));
    END get_random_element;


    FUNCTION get_random_list_combination(p_list IN SYS.ODCIVARCHAR2LIST, p_counter IN NUMBER) RETURN VARCHAR2 IS
        v_random_element VARCHAR2(100);
        v_result         VARCHAR2(100);
    BEGIN
        v_random_element := get_random_element(p_list);
        v_result := v_random_element || p_counter;
        RETURN v_result;
    END get_random_list_combination;


    FUNCTION timestamp_diff(a TIMESTAMP, b TIMESTAMP) RETURN NUMBER IS
    BEGIN
        RETURN EXTRACT(DAY FROM (a - b)) * 24 * 60 * 60 +
               EXTRACT(HOUR FROM (a - b)) * 60 * 60 +
               EXTRACT(MINUTE FROM (a - b)) * 60 +
               EXTRACT(SECOND FROM (a - b));
    END timestamp_diff;


    PROCEDURE bewijs_Random_M5 AS

        v_random_date     DATE;
        v_random_number   NUMBER;
        v_random_name     VARCHAR2(100);
        v_random_element  VARCHAR2(100);
        v_start_timestamp TIMESTAMP;
        v_end_timestamp   TIMESTAMP;
        v_duration        NUMBER;

    BEGIN
        v_start_timestamp := SYSTIMESTAMP;


        v_random_date := generate_random_date(TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'));
        v_random_number := generate_random_number(1, 100);
        v_random_name := get_random_list_combination(
                SYS.ODCIVARCHAR2LIST('John Doe', 'Jane Smith', 'Alice Johnson', 'Bob Brown', 'Eve Wilson'), 1);
        v_random_element :=
                get_random_element(SYS.ODCIVARCHAR2LIST('John Doe', 'Jane Smith', 'Alice Johnson', 'Bob Brown',
                                                        'Eve Wilson'));

        DBMS_OUTPUT.PUT_LINE('Random datum binnen een bereik: ' || TO_CHAR(v_random_date, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE('Random nummer binnen een bereik: ' || v_random_number);
        DBMS_OUTPUT.PUT_LINE('Random Element van een list met een counter: ' || v_random_name);
        DBMS_OUTPUT.PUT_LINE('Random Element van een list zonder een counter: ' || v_random_element);
        DBMS_OUTPUT.PUT_LINE('---------------------------');


        v_end_timestamp := SYSTIMESTAMP;
        v_duration := timestamp_diff(v_end_timestamp, v_start_timestamp);

        DBMS_OUTPUT.PUT_LINE('Procedure bewijs_Random_M5 executed in ' || v_duration || ' seconds.');


    END bewijs_Random_M5;

END PKG_SAMEN_smartphones;
/