-- Insert data into Brand table
INSERT INTO Brand (brand_name, brand_founder, type, key_people, founding_date, address_id)
VALUES ('Apple', 'Steve Jobs', 'Technology', 'Tim Cook',
        TO_DATE('1976-04-01', 'YYYY-MM-DD'),
        (SELECT address_id FROM Address WHERE zip = 54321 AND street = 'Apple Avenue 2' AND street_number = 200));

INSERT INTO Brand (brand_name, brand_founder, type, key_people, founding_date, address_id)
VALUES ('Google', 'Larry Page', 'Technology', 'Sundar Pichai',
        TO_DATE('1998-09-04', 'YYYY-MM-DD'),
        (SELECT address_id FROM Address WHERE zip = 98765 AND street = 'Google Drive 3' AND street_number = 300));

INSERT INTO Brand (brand_name, brand_founder, type, key_people, founding_date, address_id)
VALUES ('Amazon', 'Jeff Bezos', 'Technology', 'Jeff Bezos',
        TO_DATE('1994-07-05', 'YYYY-MM-DD'),
        (SELECT address_id FROM Address WHERE zip = 12345 AND street = 'Terry Avenue North' AND street_number = 410));

INSERT INTO Brand (brand_name, brand_founder, type, key_people, founding_date, address_id)
VALUES ('Tesla', 'Elon Musk', 'Automotive', 'Elon Musk',
        TO_DATE('2003-07-01', 'YYYY-MM-DD'),
        (SELECT address_id FROM Address WHERE zip = 67890 AND street = 'Deer Creek Road' AND street_number = 3500));

INSERT INTO Brand (brand_name, brand_founder, type, key_people, founding_date, address_id)
VALUES ('Microsoft', 'Bill Gates', 'Technology', 'Satya Nadella',
        TO_DATE('1975-04-04', 'YYYY-MM-DD'),
        (SELECT address_id FROM Address WHERE zip = 13579 AND street = 'Microsoft Way' AND street_number = 1));

-- Insert data into HQ_Adresses table
INSERT INTO Address (zip, city, street_number, street)
VALUES (12345, 'New York', 100, 'Broadway');
INSERT INTO Address (zip, city, street_number, street)
VALUES (54321, 'Los Angeles', 200, 'Hollywood Blvd');
INSERT INTO Address (zip, city, street_number, street)
VALUES (98765, 'Chicago', 300, 'Michigan Ave');
INSERT INTO Address (zip, city, street_number, street)
VALUES (11111, 'Houston', 400, 'Main St');
INSERT INTO Address (zip, city, street_number, street)
VALUES (22222, 'San Francisco', 500, 'Market St');
INSERT INTO Address (zip, city, street_number, street)
VALUES (54321, 'Cupertino', 200, 'Apple Avenue 2');
INSERT INTO Address (zip, city, street_number, street)
VALUES (98765, 'Mountain View', 300, 'Google Drive 3');
INSERT INTO Address (zip, city, street_number, street)
VALUES (12345, 'Palo Alto', 3500, 'Deer Creek Road');
INSERT INTO Address (zip, city, street_number, street)
VALUES (67890, 'Seattle', 410, 'Terry Avenue North');
INSERT INTO Address (zip, city, street_number, street)
VALUES (13579, 'Redmond', 1, 'Microsoft Way');


-- Insert data into Brand_store table
INSERT INTO Brand_store (brand_id, opening_date, employee_count, closing_date, address_id)
VALUES ((SELECT brand_id FROM Brand WHERE brand_name = 'Apple'), TO_DATE('2010-01-01', 'YYYY-MM-DD'),
        50,
        NULL, (SELECT address_id FROM Address WHERE zip = 12345 AND street = 'Broadway' AND street_number = 100));

INSERT INTO Brand_store (brand_id, opening_date, employee_count, closing_date, address_id)
VALUES ((SELECT brand_id FROM Brand WHERE brand_name = 'Google'), TO_DATE('2001-05-15', 'YYYY-MM-DD'),
        100, NULL,
        (SELECT address_id FROM Address WHERE zip = 54321 AND street = 'Hollywood Blvd' AND street_number = 200));

INSERT INTO Brand_store (brand_id, opening_date, employee_count, closing_date, address_id)
VALUES ((SELECT brand_id FROM Brand WHERE brand_name = 'Amazon'), TO_DATE('2005-09-20', 'YYYY-MM-DD'),
        75,
        NULL, (SELECT address_id FROM Address WHERE zip = 98765 AND street = 'Michigan Ave' AND street_number = 300));
INSERT INTO Brand_store (brand_id, opening_date, employee_count, closing_date, address_id)
VALUES ((SELECT brand_id FROM Brand WHERE brand_name = 'Tesla'), TO_DATE('1995-11-10', 'YYYY-MM-DD'),
        80, NULL,
        (SELECT address_id FROM Address WHERE zip = 11111 AND street = 'Main St' AND street_number = 400));

INSERT INTO Brand_store (brand_id, opening_date, employee_count, closing_date, address_id)
VALUES ((SELECT brand_id FROM Brand WHERE brand_name = 'Microsoft'), TO_DATE('2012-03-25', 'YYYY-MM-DD'),
        60,
        NULL, (SELECT address_id FROM Address WHERE zip = 22222 AND street = 'Market St' AND street_number = 500));

-- Insert data into Promotion table
INSERT INTO Promotion (promotion_id, discount, name, start_date, end_date)
VALUES (1001, 10, 'Summer Sale', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'));
INSERT INTO Promotion (promotion_id, discount, name, start_date, end_date)
VALUES (1002, 20, 'Back to School', TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-09-15', 'YYYY-MM-DD'));
INSERT INTO Promotion (promotion_id, discount, name, start_date, end_date)
VALUES (1003, 15, 'Holiday Special', TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO Promotion (promotion_id, discount, name, start_date, end_date)
VALUES (1004, 25, 'New Year Discount', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-31', 'YYYY-MM-DD'));
INSERT INTO Promotion (promotion_id, discount, name, start_date, end_date)
VALUES (1005, 30, 'Spring Clearance', TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-30', 'YYYY-MM-DD'));

-- Insert data into Sale table
INSERT INTO Sale (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
VALUES (TO_DATE('2024-08-05', 'YYYY-MM-DD'), 10001, (SELECT promotion_id FROM Promotion WHERE name = 'Summer Sale'),
        (SELECT store_id
         FROM Brand_store
         WHERE address_id =
               (SELECT address_id FROM Address WHERE zip = 12345 AND street = 'Broadway' AND street_number = 100)),
        'John Doe', TO_DATE('2023-06-15', 'YYYY-MM-DD'));
INSERT INTO Sale (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
VALUES (TO_DATE('2024-12-24', 'YYYY-MM-DD'), 10002, (SELECT promotion_id FROM Promotion WHERE name = 'Back to School'),
        (SELECT store_id
         FROM Brand_store
         WHERE address_id =
               (SELECT address_id
                FROM Address
                WHERE zip = 54321
                  AND street = 'Hollywood Blvd'
                  AND street_number = 200)),
        'Jane Smith', TO_DATE('2023-09-05', 'YYYY-MM-DD'));
INSERT INTO Sale (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
VALUES (TO_DATE('2024-07-10', 'YYYY-MM-DD'), 10003, (SELECT promotion_id FROM Promotion WHERE name = 'Holiday Special'),
        (SELECT store_id
         FROM Brand_store
         WHERE address_id =
               (SELECT address_id FROM Address WHERE zip = 98765 AND street = 'Michigan Ave' AND street_number = 300)),
        'Alice Johnson', TO_DATE('2023-12-20', 'YYYY-MM-DD'));
INSERT INTO Sale (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
VALUES (TO_DATE('2024-12-30', 'YYYY-MM-DD'), 10004,
        (SELECT promotion_id FROM Promotion WHERE name = 'New Year Discount'),
        (SELECT store_id
         FROM Brand_store
         WHERE address_id =
               (SELECT address_id FROM Address WHERE zip = 11111 AND street = 'Main St' AND street_number = 400)),
        'Bob Brown', TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO Sale (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
VALUES (TO_DATE('2024-11-29', 'YYYY-MM-DD'), 10005,
        (SELECT promotion_id FROM Promotion WHERE name = 'Spring Clearance'),
        (SELECT store_id
         FROM Brand_store
         WHERE address_id =
               (SELECT address_id FROM Address WHERE zip = 22222 AND street = 'Market St' AND street_number = 500)),
        'Eve Wilson', TO_DATE('2024-04-10', 'YYYY-MM-DD'));


