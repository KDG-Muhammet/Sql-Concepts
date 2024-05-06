CREATE OR REPLACE PACKAGE PKG_S1_smartphones AS
    PROCEDURE empty_tables_S1;
    PROCEDURE bewijs_milestone_M4_S1;
    FUNCTION lookup_smartphone(p_phonename IN VARCHAR2, p_memory IN NUMBER, p_storage IN NUMBER) RETURN NUMBER;
END PKG_S1_smartphones;