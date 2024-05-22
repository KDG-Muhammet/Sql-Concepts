CREATE OR REPLACE PACKAGE PKG_S1_smartphones AS
    PROCEDURE empty_tables_S1;
    PROCEDURE bewijs_milestone_M4_S1;
    FUNCTION lookup_smartphone(p_phonename IN VARCHAR2, p_memory IN NUMBER, p_storage IN NUMBER) RETURN NUMBER;

    PROCEDURE generate_random_user(p_amount IN NUMBER);
    PROCEDURE generate_random_smartphone(p_amount IN NUMBER);
    PROCEDURE generate_random_website(p_amount IN NUMBER);
    PROCEDURE tussenreviews(p_amount IN NUMBER);

    PROCEDURE bewijs_milestone_5_S1(p_user_amount IN NUMBER, p_phone_amount IN NUMBER, p_website_amount IN NUMBER, p_review_amount IN NUMBER);

END PKG_S1_smartphones;