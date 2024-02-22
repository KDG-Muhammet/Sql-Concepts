**Team:** INF202_18_TDR_joppe_muhammet

 - **Name:** Joppe Dechamps (S1)
 - **Studentnr:** 0153912-70
 - **Class:** INF202A


 - **Name:** Muhammet Murat (S2)
 - **Studentnr:** 0154865-53
 - **Class:** INF202A

**Year:** 2023-2024


S1: Onderwerp: User - Smartphone
------------------------------------
- A: User
- B: Smartphone
- C: Website
- D: Review



S1 Relatietypes:
-------------
- User
    - writes
    - Review
-  Smartphone
    - is talked about in
    - Review
-  Review
    - is posted on
    - Website

S1 Attributen:
-----------
- A: User
    - user_ID (PK)
    - first_name
    - last_name
    - email
    - phone_number
    - birthdate
  
- B: Smartphone
    - phone_ID (PK)
    - release_date
    - screen_diagonal
    - camera_amount
    - processor_cores
    - memory
  
- C: Review
    - user_ID (PK, FK)
    - phone_ID (PK, FK)
    - postedDate (PK)
    - website_ID (FK)
    - title
    - content
    - likes
  
- D: Website
    - website_ID (PK)
    - web_address
    - name


S2: Onderwerp: (2 niveaus diep)
-----------------------------
- W: Sales_promotion
- X: Brand
- Y: Brand_store
- Z: promotion

S2 Relatietypes:
-------------
- Brand
  - owns a
  - brand store
- Brand store
  - makes
  - promotions
- Promotion
  - is part of a  
  - sale
- Promotion
  - belongs to a 
  - smartphone

S2 Attributen:
--------------
- W: Sales_promotion
    - sales_id (PK)
    - sales_name
    - sales_description
- X: Brand
    - brand_id (PK)
    - brand_name
    - hq_number
    - hq_street
    - hq_zip
    - hq_city
    - founding_date
- Y: Brand_store
    - store_id (PK)
    - brand_id (FK)
    - store_location
    - employee_count
    - opening_date
    - closing_date
- Z: promotion
    - promotion_id (PK)
    - store_id (FK)
    - sales_id (FK)
    - smartphone_id (FK)
    - promotion_discount
    - promotion_name
    - promotion_start
    - promotion_end

Samen: Extra Entiteittypes:
--------------
- ~~~~

Relatietypes:
-------------
- 
  - 
  - 

SAMEN Attributen:
--------------

- 
  - 
  - 
