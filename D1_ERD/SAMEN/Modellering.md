Team: 99

Name: Tom De Reys (S1)
Studentnr: 0123456789
Class: INF207A

Name: Muhammet Murat (S2)
Studentnr: 0154865-53
Class: INF202A

Year: 2023-2024

Milestone 2: Modellering

TOP DOWN MODELERING
---

Entiteittypes + Attributen + PK
---
    S1
- A: players ( **player_id**, player_name, email, dob, street, house_number, zip_code, city, country )
- B: computergames ( **game_id**, game_title, release_date, last_updated, patch_title, game_studio_id)
- C: game_servers (**game_server_id**, server_name, region, next_maintenance)
- D: Game_session(**player_id**, **game_id**, **start_date**, game_server_id, high_score, end_date, version)
- Game_studio(**game_studio_id**, game_studio_name , game_studio_address)


    S2
- W: sales_promotions ( **sales_id**, sales_name, sales_description)
- X: brands ( **brand_id**, brand_name,hq_number ,hq_street ,hq_zip ,hq_city ,founding_date)
- Y: brand_stores (**store_id**, brand_id, store_location, employee_count, opening_date, closing_date)
- Z: promotion(**promotion_id**, store_id, sales_id, smartphone_id, promotion_discount, promotion_name, promotion_start, promotion_end)


Domeinen - constraints
--- 
    S1
- Player: zipcodes - minimum 4 characters
- Computergame: release_date < last_updated


    S2
- Promotion: discount > 100 
- Videos category name must start with a capital.


Tijd 
---
- S1: Game_session: De gamesession start_date en end_date houdt de historiek bij.
- S2: Brand has a founding date. All child stores are created after this date. 


Intermediërende  entiteiten
---
- Player_locations: Players - Location
- Game_sessions: Players - Computergames


Logisch ERD 
---
    S1: ERD
![S1_logisch.png](../S1/S1_logisch.png)

    S2: ERD

![S2_logisch.png](../S2/S2_logisch.png)

informatiebehoefte + Normalisatie
---
    S1:
[informatiebehoefte S1.pdf](..%2F..%2FD2_NORMALISATIE%2FS1_normalisatie%2Finformatiebehoefte%20S1.pdf)

[S1_normalisatie_computergames.pdf](..%2F..%2FD2_NORMALISATIE%2FS1_normalisatie%2FS1_normalisatie_computergames.pdf)

    S2:
[Informatiebehoefte S2.pdf](..%2F..%2FD2_NORMALISATIE%2FS2_normalisatie%2FInformatiebehoefte%20S2.pdf)

[S2_normalisatie_computergames.pdf](..%2F..%2FD2_NORMALISATIE%2FS2_normalisatie%2FS2_normalisatie_computergames.pdf)

    SAMEN:
[S1S2_computergames_Integration.pdf](..%2F..%2FD2_NORMALISATIE%2FSAMEN_integratie%2FS1S2_computergames_Integration.pdf)



Verschillen na Normalisatie (SAMEN)
-----------------------------------
- name --> first_name, last_name
- city: repeated --> Zipcodes, added location ID
- address --> location
- We only keep the current player address in our system
- game session - added high score description
- added attributes like highscore_description, channel_description
- changed some datatypes

![Finaal_ERD_M2.png](Finaal_ERD_M2.png)

