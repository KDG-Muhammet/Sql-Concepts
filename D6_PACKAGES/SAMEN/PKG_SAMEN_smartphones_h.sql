CREATE OR REPLACE PACKAGE PKG_SAMEN_smartphones AS
    FUNCTION generate_random_number(p_min IN NUMBER, p_max IN NUMBER) RETURN NUMBER;
    FUNCTION generate_random_date(p_start_date IN DATE, p_end_date IN DATE) RETURN DATE;
    FUNCTION get_random_element(p_list IN SYS.ODCIVARCHAR2LIST) RETURN VARCHAR2;
    FUNCTION get_random_list_combination(p_list IN SYS.ODCIVARCHAR2LIST, p_counter IN NUMBER) RETURN VARCHAR2;
    FUNCTION timestamp_diff(a TIMESTAMP, b TIMESTAMP) RETURN NUMBER;
END PKG_SAMEN_smartphones;
/