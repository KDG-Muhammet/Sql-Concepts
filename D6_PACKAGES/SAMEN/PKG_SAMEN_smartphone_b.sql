CREATE OR REPLACE PACKAGE BODY PKG_SAMEN_smartphones AS

    FUNCTION generate_random_number(p_min IN NUMBER, p_max IN NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN FLOOR(DBMS_RANDOM.VALUE(p_min, p_max));
    END generate_random_number;


    FUNCTION generate_random_date(p_start_date IN DATE, p_end_date IN DATE) RETURN DATE IS
        v_days_difference NUMBER;
        v_random_days NUMBER;
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
        v_result VARCHAR2(100);
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






END PKG_SAMEN_smartphones;
/