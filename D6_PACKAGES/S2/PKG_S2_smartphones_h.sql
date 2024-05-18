CREATE OR REPLACE PACKAGE PKG_S2_smartphones AS
    PROCEDURE empty_tables_s2;
    PROCEDURE bewijs_milestone_M4_S2;


    PROCEDURE generate_addresses(p_count IN NUMBER);
    PROCEDURE generate_brands(p_count IN NUMBER);
   -- PROCEDURE generate_brand_stores(p_count IN NUMBER);
    PROCEDURE generate_promotions(p_count IN NUMBER);
    PROCEDURE generate_sales(p_count IN NUMBER);
    PROCEDURE generateBrandStores(p_num_stores_per_brand IN NUMBER);

END PKG_S2_smartphones;
/