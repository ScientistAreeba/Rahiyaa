INSERT INTO Users (name, email, password, phone_number, role, profile_photo_url, date_of_birth, address)
VALUES 
('Fatima Ahmed', 'fatima.ahmed@example.com', '0123', '03001234567', 'rider', 'https://example.com/fatima.jpg', '2001-02-20', 'Lahore, Pakistan'),
('Sara Zain', 'sara.zain@example.com', '0456', '03007654321', 'driver', NULL, '2000-10-15', 'Lahore, Pakistan'),
('Ayesha Atif', 'ayesha.atif@example.com', '0789', '03009876543', 'rider', NULL, '2003-07-12', 'Lahore, Pakistan'),
('Amna Musa', 'amna.musa@example.com', '0111', '03111234567', 'driver', 'https://example.com/amna.png', '1999-03-25', 'Lahore, Pakistan');


INSERT INTO Drivers (driver_id, license_number, vehicle_id, rating, status)
VALUES 
(2, 'PK12345', NULL, 4.2, 'available'),
(4, 'PK65400', NULL, 4.5, 'on_ride');


INSERT INTO Vehicles (driver_id, vehicle_type, vehicle_model, license_plate, color, year_of_manufacture)
VALUES 
(2, 'Car', 'Suzuki Wagon R', 'ABC200', 'White', 2016),
(4, 'Bike', 'Honda CD-70', 'XYZ890', 'Grey', 2018);


INSERT INTO Rides (rider_id, driver_id, start_location, end_location, distance, ride_status, fare, ride_start_time, ride_end_time)
VALUES 
(1, 2, 'Askari 10, Lahore', 'Airpot, Lahore', 15.5, 'completed', 400.00, '2024-10-8 10:40:07', '2024-10-08 11:10:33'),
(3, 4, 'Cantt, Lahore', 'Dha Phase2, Lahore', 7.0, 'completed', 500.00, '2024-08-23 13:22:40', '2024-08-23 13:56:30');


INSERT INTO Payments (ride_id, amount, payment_status, payment_method)
VALUES 
(1, 400.00, 'paid', 'cash'),
(2, 500.00, 'paid', 'mobile_wallet');


INSERT INTO Ratings_Reviews (ride_id, rider_id, driver_id, rating, review_text)
VALUES 
(1, 1, 2, 4.9, 'Very smooth and professional ride!'),
(2, 3, 4, 3.2, 'Good ride, but slight delay.');


INSERT INTO Location_History (driver_id, latitude, longitude)
VALUES 
(2, 24.8607, 67.0011),
(4, 33.6844, 73.0479);


INSERT INTO Ride_Requests (rider_id, pickup_location, dropoff_location)
VALUES 
(1, 'Cantt, Lahore', 'Dha Phase4, Lahore'),
(3, 'State Life Society, Lahore', 'ShopXYZ, Lahore');

INSERT INTO Notifications (user_id, message)
VALUES 
(1, 'Your ride has been completed.'),
(3, 'Your ride request has been matched.');


INSERT INTO Driver_Documents (driver_id, document_type, document_url)
VALUES 
(2, 'license', 'https://example.com/license_sara.jpg'),
(4, 'identity_card', 'https://example.com/cnic_amna.jpg');


INSERT INTO Emergency_Contacts (rider_id, contact_name, contact_phone, relationship)
VALUES 
(1, 'Marium Mehmood', '03211234567', 'Sister'),
(3, 'Anisa Shoaib', '03001234888', 'Mother');


INSERT INTO Support_Tickets (user_id, subject, description)
VALUES 
(1, 'Ride Fare Issue', 'The fare charged was incorrect.'),
(3, 'App Bug', 'The app crashed during my ride.');


INSERT INTO Promotions (code, discount_percentage, valid_until)
VALUES 
('Rah10', 10, '2024-11-31'),
('Rah20', 20, '2024-12-25');


INSERT INTO Ride_Promotions (ride_id, promo_id)
VALUES 
(1, 2),
(2, 1);


INSERT INTO ScheduleRides (ride_id, driver_id, schedule_pickupLocation, schedule_dropoffLocation, schedule_Date_Time)
VALUES 
(1, 2, 'Arfa Tower, Lahore', 'Packages Mall, Lahore', '2024-08-12 15:04:73'),
(2, 4, 'SchoolABC, Lahore', 'Dha Phase1 Masjid, Lahore', '2024-07-18 14:03:20');


INSERT INTO CARPOOLING (ride_id, maxCap, CurrentRiders)
VALUES 
(1, 4, 0),
(2, 3, 1);
