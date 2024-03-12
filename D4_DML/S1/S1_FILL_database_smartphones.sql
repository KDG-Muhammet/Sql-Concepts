--GENERATION WEBSITE DATA
INSERT INTO websites (web_address,name,yearly_users,mobile_app,server_country)
VALUES ('www.tweakers.net', 'Tweakers', 726511, 'N', 'Netherlands');
INSERT INTO websites (web_address,name,yearly_users,mobile_app,server_country)
VALUES ('www.samsung.be', 'Samsung Belgium', 278309, 'Y', 'Japan');
INSERT INTO websites (web_address,name,yearly_users,mobile_app,server_country)
VALUES ('www.bol.com', 'Bol', 762579, 'Y', 'Netherlands');
INSERT INTO websites (web_address,name,yearly_users,mobile_app,server_country)
VALUES ('www.mediamarkt.be', 'Mediamarkt', 202813, 'N', 'Belgium');
INSERT INTO websites (web_address,name,yearly_users,mobile_app,server_country)
VALUES ('www.coolblue.be', 'Coolblue', 625138, 'Y', 'Belgium');

--GENERATION SMARTPHONE DATA
INSERT INTO smartphones (name,release_date,screen_diagonal,camera_amount, processor_cores,memory,storage)
VALUES ('Samsung A52', to_date('18-08-2021','DD-MM-YYYY'), 6.3, 3, 8, 16, 256);
INSERT INTO smartphones (name,release_date,screen_diagonal,camera_amount, processor_cores,memory,storage)
VALUES ('iPhone 15', to_date('09-10-2022','DD-MM-YYYY'), 6.8, 5, 16, 32, 512);
INSERT INTO smartphones (name,release_date,screen_diagonal,camera_amount, processor_cores,memory,storage)
VALUES ('Samsung Note 7', to_date('27-04-2017','DD-MM-YYYY'), 5.9, 3, 8, 8, 128);
INSERT INTO smartphones (name,release_date,screen_diagonal,camera_amount, processor_cores,memory,storage)
VALUES ('Huawei 7', to_date('14-05-2015','DD-MM-YYYY'), 5.7, 2, 4, 4, 64);
INSERT INTO smartphones (name,release_date,screen_diagonal,camera_amount, processor_cores,memory,storage)
VALUES ('Samsung Fold 2', to_date('02-02-2023','DD-MM-YYYY'), 6.8, 5, 16, 32, 512);

--GENERATION USER DATA
INSERT INTO users (first_name,last_name,email,phone_number,birthdate)
VALUES('Joppe', 'Dechamps', 'joppedechamps@gmail.com', 0473138096, to_date('14-08-2003','DD-MM-YYYY'));
INSERT INTO users (first_name,last_name,email,phone_number,birthdate)
VALUES('Gloria', 'Mihaylova', 'gloria.mihaylova@telenet.be', 0465328666, to_date('04-04-2005','DD-MM-YYYY'));
INSERT INTO users (first_name,last_name,email,phone_number,birthdate)
VALUES('Olivier', 'Christiaens', 'olivier.christiaens@gmail.com', 0483660137, to_date('12-08-2003','DD-MM-YYYY'));
INSERT INTO users (first_name,last_name,email,phone_number,birthdate)
VALUES('Kristof', 'Van de Walle', 'kristofvdwalle@hotmail.com', 0470534458, to_date('21-12-2002','DD-MM-YYYY'));
INSERT INTO users (first_name,last_name,email,phone_number,birthdate)
VALUES('Michiel', 'Gilissen', 'michiel.gilissen@gmail.com', 0493089725, to_date('08-08-2003','DD-MM-YYYY'));

--GENERATION REVIEW DATA
INSERT INTO reviews VALUES (
                               (SELECT user_ID FROM users WHERE first_name = 'Gloria'),
                               (SELECT phone_ID FROM smartphones WHERE name = 'Samsung A52'),
                               to_date('12-04-2019','DD-MM-YYYY'),
                               (SELECT website_ID FROM websites WHERE name = 'Tweakers'),
                               'Very glad this one has not blown up yet!',
                               'I bought this phone very recently after my other one blew up and did not trust smartphones for a while, I will keep this one in a safe place, so it does not happen again!',
                               5, 5, NULL);
INSERT INTO reviews VALUES (
                               (SELECT user_ID FROM users WHERE first_name = 'Gloria'),
                               (SELECT phone_ID FROM smartphones WHERE name = 'Samsung Note 7'),
                               to_date('25-08-2017','DD-MM-YYYY'),
                               (SELECT website_ID FROM websites WHERE name = 'Mediamarkt'),
                               'Very dangerous phone, blew up on my nightstand!',
                               'WTH, I just got this phone a few days ago, and while it was charging on my nightstand it just BLEW UP?! I cannot believe this, very unhappy, will probably stay away from these devices for a while.',
                               2837, 1, to_date('27-08-2017','DD-MM-YYYY'));
INSERT INTO reviews VALUES (
                               (SELECT user_ID FROM users WHERE first_name = 'Joppe'),
                               (SELECT phone_ID FROM smartphones WHERE name = 'iPhone 15'),
                               to_date('05-10-2020','DD-MM-YYYY'),
                               (SELECT website_ID FROM websites WHERE name = 'Tweakers'),
                               'Clean, well working iPhone',
                               'First iPhone I have ever bought, a bit of a hassle to get it working and transfer some things, but got it up and running after a while, will edit if anything changes',
                               34, 4, NULL);
INSERT INTO reviews VALUES (
                               (SELECT user_ID FROM users WHERE first_name = 'Kristof'),
                               (SELECT phone_ID FROM smartphones WHERE name = 'iPhone 15'),
                               to_date('18-06-2022','DD-MM-YYYY'),
                               (SELECT website_ID FROM websites WHERE name = 'Coolblue'),
                               'Very happy about the purchase of the newest hardware!',
                               'Just bought the newest iPhone, very happy as transfers from my iPhone 14 were flawless. Edit: After a year and a half of usage it is due for an upgrade, as it is already slowing down',
                               124, 5, to_date('23-12-2023','DD-MM-YYYY'));
INSERT INTO reviews VALUES (
                               (SELECT user_ID FROM users WHERE first_name = 'Olivier'),
                               (SELECT phone_ID FROM smartphones WHERE name = 'Samsung A52'),
                               to_date('29-11-2023','DD-MM-YYYY'),
                               (SELECT website_ID FROM websites WHERE name = 'Bol'),
                               'Happy',
                               'Very happy about this device, thanks for coming to my review talk!',
                               0, 4, NULL);