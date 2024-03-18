
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
    S1 @query 1: GAMESTUDIO - COMPUTERGAMES (B/X) - PLAYERS (A) - GAMESESSIONS (D) 
![S1_query1_studios_games_players.png](screenshots%2FS1_query1_studios_games_players.png)

    S1 @query 2: PLAYER (A) - GAMESERVERS (C)
![S1_query3_gameservers.png](screenshots%2FS1_query3_gameservers.png)

    S2 @query 1: brands (X) - brand_stores (Y) - sale (Z) - promotion (W)
![S2_query1_brands_sales.png](screenshots%2FS2_query1_brands_sales.png)

    S2 @query 2: brands (x) - Adresses
![S1_query2_player_locations.png](screenshots%2FS1_query2_player_locations.png)

Bewijs Domeinen - constraints M2
--- 

    S1
- Player: zipcodes - minimum 4 characters

![S1_bewijs_zipcodes.png](screenshots%2FS1_bewijs_zipcodes.png)

- Computergame: release_date < last_updated

![S1_bewijs_computergames_date.png](screenshots%2FS1_bewijs_computergames_date.png)

    S2
- Promotion: discount <= 100

![S2_bewijs_promotion_discount.png](screenshots%2FS2_bewijs_promotion_discount.png)

- Brand: zip < 0

![S2_bewijs_address_zipcode.png](screenshots%2FS2_bewijs_address_zipcode.png)


Security
---
    S1: 
- view 
![1_view_top3.png](screenshots/S1_view_top3.png)

    S2
- view
![S2_view_WXYZ.png](screenshots/S2_view_WXYZ.png)   

- overzicht system privileges
![dict_tab_privs.png](screenshots/dict_tab_privs.png)

- S1: 
![S1_bewijs_syn_DML_DDL.png](screenshots/S1_bewijs_syn_DML_DDL.png)

- S2:
![S2_bewijs_insertKeyPresserved.png](screenshots/S2_bewijs_insertKeyPresserved.png)