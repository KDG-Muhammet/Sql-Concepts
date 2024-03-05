Team: 18

Name: Joppe Dechamps (S1)
Studentnr: 0153912-70
Class: INF202A

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
- A: users ( **user_ID**, first_name, last_name, email, phone_number, birthdate)
- B: smartphones ( **phone_ID**, release_date, screen_diagonal, camera_amount, processor_cores, memory)
- C: reviews ( **user_ID**, **phone_ID**, **postedDate**, **website_ID**, lastEditedDate, title)
- D: websites ( **website_ID**, website_name, website_url)


    S2
- W: sales_promotions ( **sales_id**, sales_name, sales_description)
- X: brands ( **brand_id**, brand_name,hq_number ,hq_street ,hq_zip ,hq_city ,founding_date)
- Y: brand_stores (**store_id**, brand_id, store_location, employee_count, opening_date, closing_date)
- Z: promotion(**promotion_id**, store_id, sales_id, smartphone_id, promotion_discount, promotion_name, promotion_start, promotion_end)


Domeinen - constraints
--- 
    S1
- User: 
- Website: format: www.\***.\*** / https\://www.\***.\***


    S2
- Promotion: discount <= 100 
- Brand: Hq_ip < 0

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
![S1_logisch.png](../S1/S1_ERD_Joppe_Dechamps.png)

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

