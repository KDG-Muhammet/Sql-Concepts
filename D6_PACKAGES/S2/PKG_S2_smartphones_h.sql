CREATE OR REPLACE PACKAGE PKG_S2_smartphones AS
    PROCEDURE empty_tables_s2;

    PROCEDURE bewijs_milestone_M4_S2;

    PROCEDURE bewijs_milestone_M5_S2;

    PROCEDURE bewijs_milestone_M7_S2;


    PROCEDURE generate_addresses(p_count IN NUMBER);
    PROCEDURE generate_brands(p_count IN NUMBER);
    PROCEDURE generate_brands_stores(p_num_stores_per_brand IN NUMBER);
    PROCEDURE generate_promotions(p_count IN NUMBER);
    PROCEDURE generate_sales(s_rows_per_store IN NUMBER);

    PROCEDURE generate_addresses_bulk(p_count IN NUMBER);
    PROCEDURE generate_brands_bulk(p_count IN NUMBER);
    PROCEDURE generate_brand_stores_bulk(p_num_stores_per_brand IN NUMBER);
    PROCEDURE generate_promotions_bulk(p_count IN NUMBER);
    PROCEDURE generate_sales_bulk(s_rows_per_store IN NUMBER);

END PKG_S2_smartphones;
/