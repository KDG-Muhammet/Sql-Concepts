-- Insert data into HQ_Adresses table
INSERT INTO addresses (zip, city, street_number, street)
VALUES (12345, 'New York', 100, 'Broadway');
INSERT INTO addresses (zip, city, street_number, street)
VALUES (54321, 'Los Angeles', 200, 'Hollywood Blvd');
INSERT INTO addresses (zip, city, street_number, street)
VALUES (98765, 'Chicago', 300, 'Michigan Ave');
INSERT INTO addresses (zip, city, street_number, street)
VALUES (11111, 'Houston', 400, 'Main St');
INSERT INTO addresses (zip, city, street_number, street)
VALUES (22222, 'San Francisco', 500, 'Market St');
INSERT INTO addresses (zip, city, street_number, street)
VALUES (54321, 'Cupertino', 200, 'Apple Avenue 2');
INSERT INTO addresses (zip, city, street_number, street)
VALUES (98765, 'Mountain View', 300, 'Google Drive 3');
INSERT INTO addresses (zip, city, street_number, street)
VALUES (12345, 'Palo Alto', 3500, 'Deer Creek Road');
INSERT INTO addresses (zip, city, street_number, street)
VALUES (67890, 'Seattle', 410, 'Terry Avenue North');
INSERT INTO addresses (zip, city, street_number, street)
VALUES (13579, 'Redmond', 1, 'Microsoft Way');


-- Insert data into Brand table
INSERT INTO brands (brand_name, brand_founder, type, key_people, founding_date, address_id)
VALUES ('Apple', 'Steve Jobs', 'Technology', 'Tim Cook',
        TO_DATE('01-04-1976', 'DD-MM-YYYY'),
        (SELECT address_id FROM addresses WHERE zip = 54321 AND street = 'Apple Avenue 2' AND street_number = 200));

INSERT INTO brands (brand_name, brand_founder, type, key_people, founding_date, address_id)
VALUES ('Google', 'Larry Page', 'Technology', 'Sundar Pichai',
        TO_DATE('04-09-1998', 'DD-MM-YYYY'),
        (SELECT address_id FROM addresses WHERE zip = 98765 AND street = 'Google Drive 3' AND street_number = 300));

INSERT INTO brands (brand_name, brand_founder, type, key_people, founding_date, address_id)
VALUES ('Amazon', 'Jeff Bezos', 'Technology', 'Jeff Bezos',
        TO_DATE('05-07-1994', 'DD-MM-YYYY'),
        (SELECT address_id FROM addresses WHERE zip = 12345 AND street = 'Terry Avenue North' AND street_number = 3500));

INSERT INTO brands (brand_name, brand_founder, type, key_people, founding_date, address_id)
VALUES ('Tesla', 'Elon Musk', 'Automotive', 'Elon Musk',
        TO_DATE('01-07-2003', 'DD-MM-YYYY'),
        (SELECT address_id FROM addresses WHERE zip = 67890 AND street = 'Deer Creek Road' AND street_number = 410));

INSERT INTO brands (brand_name, brand_founder, type, key_people, founding_date, address_id)
VALUES ('Microsoft', 'Bill Gates', 'Technology', 'Satya Nadella',
        TO_DATE('04-04-1975', 'DD-MM-YYYY'),
        (SELECT address_id FROM addresses WHERE zip = 13579 AND street = 'Microsoft Way' AND street_number = 1));

-- Insert data into Brand_store table
INSERT INTO brand_stores (brand_id, opening_date, employee_count, closing_date, address_id)
VALUES ((SELECT brand_id FROM brands WHERE brand_name = 'Apple'), TO_DATE('01-01-2010', 'DD-MM-YYYY'),
        50,
        NULL, (SELECT address_id FROM addresses WHERE zip = 12345 AND street = 'Broadway' AND street_number = 100));

INSERT INTO brand_stores (brand_id, opening_date, employee_count, closing_date, address_id)
VALUES ((SELECT brand_id FROM brands WHERE brand_name = 'Google'), TO_DATE('15-05-2001', 'DD-MM-YYYY'),
        100, NULL,
        (SELECT address_id FROM addresses WHERE zip = 54321 AND street = 'Hollywood Blvd' AND street_number = 200));

INSERT INTO brand_stores (brand_id, opening_date, employee_count, closing_date, address_id)
VALUES ((SELECT brand_id FROM brands WHERE brand_name = 'Amazon'), TO_DATE('20-09-2005', 'DD-MM-YYYY'),
        75,
        NULL, (SELECT address_id FROM addresses WHERE zip = 98765 AND street = 'Michigan Ave' AND street_number = 300));
INSERT INTO brand_stores (brand_id, opening_date, employee_count, closing_date, address_id)
VALUES ((SELECT brand_id FROM brands WHERE brand_name = 'Tesla'), TO_DATE('10-11-1995', 'DD-MM-YYYY'),
        80, NULL,
        (SELECT address_id FROM addresses WHERE zip = 11111 AND street = 'Main St' AND street_number = 400));

INSERT INTO brand_stores (brand_id, opening_date, employee_count, closing_date, address_id)
VALUES ((SELECT brand_id FROM brands WHERE brand_name = 'Microsoft'), TO_DATE('25-03-2012', 'DD-MM-YYYY'),
        60,
        NULL, (SELECT address_id FROM addresses WHERE zip = 22222 AND street = 'Market St' AND street_number = 500));

-- Insert data into Promotion table
INSERT INTO PROMOTIONS (promotion_id, discount, name, start_date, end_date)
VALUES (1001, 10, 'Summer Sale', TO_DATE('01-06-2023', 'DD-MM-YYYY'), TO_DATE('30-06-2023', 'DD-MM-YYYY'));
INSERT INTO PROMOTIONS (promotion_id, discount, name, start_date, end_date)
VALUES (1002, 20, 'Back to School', TO_DATE('15-08-2023', 'DD-MM-YYYY'), TO_DATE('15-09-2023', 'DD-MM-YYYY'));
INSERT INTO PROMOTIONS (promotion_id, discount, name, start_date, end_date)
VALUES (1003, 15, 'Holiday Special', TO_DATE('01-12-2023', 'DD-MM-YYYY'), TO_DATE('31-12-2023', 'DD-MM-YYYY'));
INSERT INTO PROMOTIONS (promotion_id, discount, name, start_date, end_date)
VALUES (1004, 25, 'New Year Discount', TO_DATE('01-01-2024', 'DD-MM-YYYY'), TO_DATE('31-01-2024', 'DD-MM-YYYY'));
INSERT INTO PROMOTIONS (promotion_id, discount, name, start_date, end_date)
VALUES (1005, 30, 'Spring Clearance', TO_DATE('01-04-2024', 'DD-MM-YYYY'), TO_DATE('30-04-2024', 'DD-MM-YYYY'));

-- Insert data into Sale table
INSERT INTO SALES (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
VALUES (TO_DATE('05-08-2024', 'DD-MM-YYYY'), (SELECT phone_ID FROM smartphones WHERE name = 'iPhone 15'), (SELECT promotion_id FROM PROMOTIONS WHERE name = 'Summer Sale'),
        (SELECT store_id
         FROM BRAND_STORES
         WHERE address_id =
               (SELECT address_id FROM ADDRESSES WHERE zip = 12345 AND street = 'Broadway' AND street_number = 100)),
        'John Doe', TO_DATE('15-06-2023', 'DD-MM-YYYY'));
INSERT INTO SALES (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
VALUES (TO_DATE('24-12-2024', 'DD-MM-YYYY'), (SELECT phone_ID FROM smartphones WHERE name = 'iPhone 15'), (SELECT promotion_id FROM PROMOTIONS WHERE name = 'Back to School'),
        (SELECT store_id
         FROM BRAND_STORES
         WHERE address_id =
               (SELECT address_id
                FROM ADDRESSES
                WHERE zip = 54321
                  AND street = 'Hollywood Blvd'
                  AND street_number = 200)),
        'Jane Smith', TO_DATE('05-09-2023', 'DD-MM-YYYY'));
INSERT INTO SALES (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
VALUES (TO_DATE( '10-07-2024', 'DD-MM-YYYY'), (SELECT phone_ID FROM smartphones WHERE name = 'iPhone 15'), (SELECT promotion_id FROM PROMOTIONS WHERE name = 'Holiday Special'),
        (SELECT store_id
         FROM BRAND_STORES
         WHERE address_id =
               (SELECT address_id FROM ADDRESSES WHERE zip = 98765 AND street = 'Michigan Ave' AND street_number = 300)),
        'Alice Johnson', TO_DATE('20-12-2023', 'DD-MM-YYYY'));
INSERT INTO SALES (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
VALUES (TO_DATE('30-12-2024', 'DD-MM-YYYY'), (SELECT phone_ID FROM smartphones WHERE name = 'iPhone 15'),
        (SELECT promotion_id FROM PROMOTIONS WHERE name = 'New Year Discount'),
        (SELECT store_id
         FROM BRAND_STORES
         WHERE address_id =
               (SELECT address_id FROM ADDRESSES WHERE zip = 11111 AND street = 'Main St' AND street_number = 400)),
        'Bob Brown', TO_DATE('10-01-2024', 'DD-MM-YYYY'));
INSERT INTO SALES (due_dates, phone_ID, promotion_id, store_id, name, sale_date)
VALUES (TO_DATE('29-11-2024', 'DD-MM-YYYY'), (SELECT phone_ID FROM smartphones WHERE name = 'iPhone 15'),
        (SELECT promotion_id FROM PROMOTIONS WHERE name = 'Spring Clearance'),
        (SELECT store_id
         FROM BRAND_STORES
         WHERE address_id =
               (SELECT address_id FROM ADDRESSES WHERE zip = 22222 AND street = 'Market St' AND street_number = 500)),
        'Eve Wilson', TO_DATE('10-04-2024', 'DD-MM-YYYY'));
COMMIT ;


