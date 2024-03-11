-- Insert data into Brand table
INSERT INTO Brand (brand_name, founding_date)
VALUES ('Samsung', TO_DATE('1969-03-01', 'YYYY-MM-DD'));
INSERT INTO Brand (brand_name, founding_date)
VALUES ('Apple', TO_DATE('1976-04-01', 'YYYY-MM-DD'));
INSERT INTO Brand (brand_name, founding_date)
VALUES ('Google', TO_DATE('1998-09-04', 'YYYY-MM-DD'));
INSERT INTO Brand (brand_name, founding_date)
VALUES ('Huawei', TO_DATE('1987-09-15', 'YYYY-MM-DD'));
INSERT INTO Brand (brand_name, founding_date)
VALUES ('Xiaomi', TO_DATE('2010-04-06', 'YYYY-MM-DD'));

-- Insert data into HQ_Adresses table
INSERT INTO HQ_Adresses (hq_zip, brand_id, hq_number, hq_city, hq_street)
VALUES (12345, (SELECT brand_id FROM Brand WHERE brand_name = 'Samsung'), 100, 'Seoul', 'Samsung Street 1');
INSERT INTO HQ_Adresses (hq_zip, brand_id, hq_number, hq_city, hq_street)
VALUES (54321, (SELECT brand_id FROM Brand WHERE brand_name = 'Apple'), 200, 'Cupertino', 'Apple Avenue 2');
INSERT INTO HQ_Adresses (hq_zip, brand_id, hq_number, hq_city, hq_street)
VALUES (98765, (SELECT brand_id FROM Brand WHERE brand_name = 'Google'), 300, 'Mountain View', 'Google Drive 3');
INSERT INTO HQ_Adresses (hq_zip, brand_id, hq_number, hq_city, hq_street)
VALUES (67890, (SELECT brand_id FROM Brand WHERE brand_name = 'Huawei'), 400, 'Shenzhen', 'Huawei Road 4');
INSERT INTO HQ_Adresses (hq_zip, brand_id, hq_number, hq_city, hq_street)
VALUES (13579, (SELECT brand_id FROM Brand WHERE brand_name = 'Xiaomi'), 500, 'Beijing', 'Xiaomi Lane 5');

-- Insert data into Brand_store table
INSERT INTO Brand_store (brand_id, store_location, opening_date, employee_count, closing_date)
VALUES ((SELECT brand_id FROM Brand WHERE brand_name = 'Samsung'), 'Gangnam', TO_DATE('2010-01-01', 'YYYY-MM-DD'), 50,
        NULL);
INSERT INTO Brand_store (brand_id, store_location, opening_date, employee_count, closing_date)
VALUES ((SELECT brand_id FROM Brand WHERE brand_name = 'Apple'), 'Fifth Avenue', TO_DATE('2001-05-15', 'YYYY-MM-DD'),
        100, NULL);
INSERT INTO Brand_store (brand_id, store_location, opening_date, employee_count, closing_date)
VALUES ((SELECT brand_id FROM Brand WHERE brand_name = 'Google'), 'Palo Alto', TO_DATE('2005-09-20', 'YYYY-MM-DD'), 75,
        NULL);
INSERT INTO Brand_store (brand_id, store_location, opening_date, employee_count, closing_date)
VALUES ((SELECT brand_id FROM Brand WHERE brand_name = 'Huawei'), 'Huaqiangbei', TO_DATE('1995-11-10', 'YYYY-MM-DD'),
        80, NULL);
INSERT INTO Brand_store (brand_id, store_location, opening_date, employee_count, closing_date)
VALUES ((SELECT brand_id FROM Brand WHERE brand_name = 'Xiaomi'), 'Wangfujing', TO_DATE('2012-03-25', 'YYYY-MM-DD'), 60,
        NULL);

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
INSERT INTO Sale (phone_ID, promotion_id, store_id, name, date)
VALUES (10001, (SELECT promotion_id FROM Promotion WHERE name = 'Summer Sale'),
        (SELECT store_id FROM Brand_store WHERE brand_id = (SELECT brand_id FROM Brand WHERE brand_name = 'Samsung')),
        'John Doe', TO_DATE('2023-06-15', 'YYYY-MM-DD'));
INSERT INTO Sale (, phone_ID, promotion_id, store_id, name, date)
VALUES (10002, (SELECT promotion_id FROM Promotion WHERE name = 'Back to School'),
        (SELECT store_id FROM Brand_store WHERE brand_id = (SELECT brand_id FROM Brand WHERE brand_name = 'Apple')),
        'Jane Smith', TO_DATE('2023-09-05', 'YYYY-MM-DD'));
INSERT INTO Sale (, phone_ID, promotion_id, store_id, name, date)
VALUES (10003, (SELECT promotion_id FROM Promotion WHERE name = 'Holiday Special'),
        (SELECT store_id FROM Brand_store WHERE brand_id = (SELECT brand_id FROM Brand WHERE brand_name = 'Google')),
        'Alice Johnson', TO_DATE('2023-12-20', 'YYYY-MM-DD'));
INSERT INTO Sale (, phone_ID, promotion_id, store_id, name, date)
VALUES (10004, (SELECT promotion_id FROM Promotion WHERE name = 'New Year Discount'),
        (SELECT store_id FROM Brand_store WHERE brand_id = (SELECT brand_id FROM Brand WHERE brand_name = 'Huawei')),
        'Bob Brown', TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO Sale (, phone_ID, promotion_id, store_id, name, date)
VALUES (10005, (SELECT promotion_id FROM Promotion WHERE name = 'Spring Clearance'),
        (SELECT store_id FROM Brand_store WHERE brand_id = (SELECT brand_id FROM Brand WHERE brand_name = 'Xiaomi')),
        'Eve Wilson', TO_DATE('2024-04-10', 'YYYY-MM-DD'));