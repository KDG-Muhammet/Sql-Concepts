Team: 99

Name: Tom De Reys (S1)
Studentnr: 0123456789
Class: INF207A

Name: Anniek Cornelis (S2)
Studentnr: 0123456789
Class: INF207B

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
- W: video_categories ( **category_id**, category_name, category_description)
- X: computergames (S1 Tabel B)
- Y: Influencer_youtubechannel(**channel_id**, game_id, channel_name, channel_url, subscriber_count, creation_date)
- Z: Influencer_youtubevideo(**video_id**, channel_id, category_id, players_id,video_title, view_count, video_url, video_duration, creation_date)


Domeinen - constraints
--- 
    S1
- Player: zipcodes - minimum 4 characters
- Computergame: release_date < last_updated


    S2
- Influencer_youtubevideo duration between 1 minute and 24 hours
- Videos category name must start with a capital.


Tijd 
---
- S1: Game_session: De gamesession start_date en end_date houdt de historiek bij.
- S2: Influencer_youtubechannel has a creation date. All child videos are created after this date. 


Intermediërende  entiteiten
---
- Player_locations: Players - Location
- Game_sessions: Players - Computergames


Logisch ERD 
---
    S1: ERD
![S1_logisch.png](../S1/S1_logisch.png)

    S2: ERD

![S1_logisch.png](../S2/S2_logisch.png)

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

