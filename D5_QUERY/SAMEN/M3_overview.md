
Milestone 3: Creatie Databank en Security
---

    Identity columns
---
- Mandatory
    - A: players: player_id
    - B/X: computergames: game_id
    - x: brands: brand_id
    - y: brand_stores: store_id
    - z: sales: sale_id
- other:
    - Addresses: address_id

      Table Counts
---
     Tablecounts
![count_result.png](screenshots%2Fcount_result.png)

Queries
--- 
    S1 @query 1: USERS (A) - REVIEWS (D) - SMARTPHONES (B)
![S1_query1_users_reviews_smartphones.png](screenshots%2FS1_query1_users_reviews_smartphones.png)

    S1 @query 2: USERS (A) - REVIEWS (D) - WEBSITES (C)
![S1_query2_users_reviews_websites.png](screenshots%2FS1_query2_users_reviews_websites.png)

    S2 @query 1: brands (X) - brand_stores (Y) - sale (Z) - promotion (W)
![S2_query1_brands_sales.png](screenshots%2FS2_query1_brands_sales.png)

    S2 @query 2: brands (x) - Adresses
![S2_query2_brands_addresses.png](screenshots%2FS2_query2_brands_addresses.png)

Bewijs Domeinen - constraints M2
--- 

    S1
- Website: web_address like www.\***.\***

![S1_bewijs_web_address_format.png](screenshots%2FS1_bewijs_web_address_format.png)

- Reviews: rating: 0-5

![S1_bewijs_rating.png](screenshots%2FS1_bewijs_rating.png)

    S2
- Promotion: discount <= 100

![S2_bewijs_promotion_discount.png](screenshots%2FS2_bewijs_promotion_discount.png)

- Brand: zip < 0

![S2_bewijs_address_zipcode.png](screenshots%2FS2_bewijs_address_zipcode.png)


Security
---
    S1: 
- view 
![S1_view_best3.png](screenshots/S1_view_best3.png)

    S2
- view
![S2_view_WXYZ.png](screenshots/S2_view_WXYZ.png)   

- Username
![username.png](screenshots/username.png)

- overzicht system privileges
![dict_tab_privs.png](screenshots/dict_tab_privs.png)


- S1: 
- Synonym
![S1_bewijs_Syn.png](screenshots/S1_bewijs_Syn.png)
- DML
![S1_bewijs_DML_1.png](screenshots/S1_bewijs_DML_1.png)
![S1_bewijs_DML_2.png](screenshots/S1_bewijs_DML_2.png)
- DDL
![S1_bewijs_DDL_1.png](screenshots/S1_bewijs_DDL_1.png)
![S1_bewijs_DDL_2.png](screenshots/S1_bewijs_DDL_2.png)

- S2:
![S2_bewijs_insertKeyPresserved.png](screenshots/S2_bewijs_insertKeyPresserved.png)