**Team:** INF202_18_TDR_joppe_muhammet

 - **Name:** Tom De Reys (S1)
 - **Studentnr:** 0123456789
 - **Class:** INF207A


 - **Name:** Muhammet Murat (S2)
 - **Studentnr:** 
 - **Class:** INF202A

**Year:** 2023-2024


S1: Onderwerp: (veel op veel)
------------------------------------
- A: Players
- B: Computergames
- C: Game_servers
- D: Game_session



S1 Relatietypes:
-------------
- Player
    - start
    - Game_session
-  Computer game
    - is played in
    - Game_Session
-  Game_session
    - is hosted on
    - Game_Server

S1 Attributen:
-----------
- A: Players
    - Player_id (PK)
    - name
    - email
    - street
    - street number
    - city
    - country
- B: Computergames
    - Game_id (PK)
    - computergame title
    - release_date
    - last updated
    - patch_title
- C: Game_servers
    - Game_server_id
    - Server_name
    - region
- D: Game_session
    - player_ID, game_id, start_date (PK)
    - player_ID (FK)
    - game_ID (FK)
    - game_server_id (FK)
    - high score
    - start_date
    - Version


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
- Y: Brand_store
    - store_id (PK)
    - brand_id (FK)
    - store_location
    - employee_count
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
- 

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
