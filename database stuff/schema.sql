-- Ride Hailing App Database Schema

-- Create Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    role ENUM('rider', 'driver') NOT NULL,
    profile_photo_url VARCHAR(255),
    date_of_birth DATE,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Drivers Table
CREATE TABLE Drivers (
    driver_id INT PRIMARY KEY,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    vehicle_id INT,
    rating DECIMAL(2,1) DEFAULT 0.0,
    status ENUM('available','on_ride','inactive') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (driver_id) REFERENCES Users(user_id)
);

-- Create Vehicles Table
CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    driver_id INT,
    vehicle_type VARCHAR(50),
    vehicle_model VARCHAR(50),
    license_plate VARCHAR(50) UNIQUE,
    color VARCHAR(20),
    year_of_manufacture YEAR,
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

-- Create Rides Table
CREATE TABLE Rides (
    ride_id INT PRIMARY KEY AUTO_INCREMENT,
    rider_id INT NOT NULL,
    driver_id INT,
    start_location VARCHAR(255),
    end_location VARCHAR(255),
    distance DECIMAL(5,2),
    ride_status ENUM('pending','accepted','completed','cancelled') DEFAULT 'pending',
    fare DECIMAL(10,2),
    ride_start_time TIMESTAMP,
    ride_end_time TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rider_id) REFERENCES Users(user_id),
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

-- Create Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    ride_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('paid','pending','failed') DEFAULT 'pending',
    payment_method ENUM('credit_card','debit_card','cash','mobile_wallet') NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ride_id) REFERENCES Rides(ride_id)
);

-- Create Ratings and Reviews Table
CREATE TABLE Ratings_Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    ride_id INT NOT NULL,
    rider_id INT NOT NULL,
    driver_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ride_id) REFERENCES Rides(ride_id),
    FOREIGN KEY (rider_id) REFERENCES Users(user_id),
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

-- Create Location History Table
CREATE TABLE Location_History (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    driver_id INT NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

-- Create Ride Requests Table
CREATE TABLE Ride_Requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    rider_id INT NOT NULL,
    pickup_location VARCHAR(255) NOT NULL,
    dropoff_location VARCHAR(255) NOT NULL,
    status ENUM('requested','matched','cancelled') DEFAULT 'requested',
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(rider_id) REFERENCES Users(user_id)
);

-- Create Notifications Table
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

-- Create Driver Documents Table
CREATE TABLE Driver_Documents (
    document_id INT PRIMARY KEY AUTO_INCREMENT,
    driver_id INT NOT NULL,
    document_type ENUM('license','identity_card','vehicle_registration') NOT NULL,
    document_url VARCHAR(255),
    is_verified BOOLEAN DEFAULT FALSE,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(driver_id) REFERENCES Drivers(driver_id)
);

-- Create Emergency Contacts Table
CREATE TABLE Emergency_Contacts (
    contact_id INT PRIMARY KEY AUTO_INCREMENT,
    rider_id INT NOT NULL,
    contact_name VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(15) NOT NULL,
    relationship VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rider_id) REFERENCES Users(user_id)
);

-- Create Support Tickets Table
CREATE TABLE Support_Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    subject VARCHAR(255) NOT NULL,
    description TEXT,
    status ENUM('open','in_progress','resolved','closed') DEFAULT 'open',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

-- Create Promotions Table
CREATE TABLE Promotions (
    promo_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) UNIQUE NOT NULL,
    discount_percentage DECIMAL(5,2) NOT NULL,
    valid_until DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- Create Ride Promotions Table
CREATE TABLE Ride_Promotions (
    ride_promo_id INT PRIMARY KEY AUTO_INCREMENT,
    ride_id INT NOT NULL,
    promo_id INT NOT NULL,
    FOREIGN KEY (ride_id) REFERENCES Rides(ride_id),
    FOREIGN KEY (promo_id) REFERENCES Promotions(promo_id)
);

-- Create Scheduled Rides Table
CREATE TABLE ScheduleRides (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    ride_id INT NOT NULL,
    driver_id INT NOT NULL,
    schedule_pickupLocation VARCHAR(255) NOT NULL,
    schedule_dropoffLocation VARCHAR(255) NOT NULL,
    schedule_Date_Time DATETIME NOT NULL,
    Schedule_status ENUM('confirmed', 'pending', 'denied') DEFAULT 'pending',
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ride_id) REFERENCES Rides(ride_id),
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

-- Create Carpooling Table
CREATE TABLE CARPOOLING (
    carpool_id INT PRIMARY KEY AUTO_INCREMENT,
    ride_id INT NOT NULL,
    max_capacity INT NOT NULL,
    current_riders INT NOT NULL,
    FOREIGN KEY (ride_id) REFERENCES Rides(ride_id)
);

-- Performance Indexes
CREATE INDEX idx_rides_rider ON Rides(rider_id);
CREATE INDEX idx_rides_driver ON Rides(driver_id);
CREATE INDEX idx_rides_status ON Rides(ride_status);
CREATE INDEX idx_payments_ride ON Payments(ride_id);
CREATE INDEX idx_location_history_driver ON Location_History(driver_id, timestamp);

-- View for Active Drivers
CREATE OR REPLACE VIEW Active_Drivers AS
SELECT 
    d.driver_id,
    u.name,
    u.email,
    d.rating,
    d.status,
    v.vehicle_type,
    v.vehicle_model,
    v.license_plate
FROM 
    Drivers d
JOIN 
    Users u ON d.driver_id = u.user_id
LEFT JOIN 
    Vehicles v ON d.vehicle_id = v.vehicle_id
WHERE 
    d.status = 'available';

-- View for Ride History
CREATE OR REPLACE VIEW Ride_History AS
SELECT 
    r.ride_id,
    r.ride_status,
    r.distance,
    r.fare,
    r.ride_start_time,
    r.ride_end_time,
    rider.name AS rider_name,
    driver.name AS driver_name,
    rr.rating,
    rr.review_text,
    p.payment_status,
    p.payment_method
FROM 
    Rides r
JOIN 
    Users rider ON r.rider_id = rider.user_id
LEFT JOIN 
    Users driver ON r.driver_id = driver.user_id
LEFT JOIN 
    Ratings_Reviews rr ON r.ride_id = rr.ride_id
LEFT JOIN 
    Payments p ON r.ride_id = p.ride_id;

-- View for Nearby Drivers
CREATE OR REPLACE VIEW Nearby_Drivers AS
SELECT 
    d.driver_id,
    u.name AS driver_name,
    lh.latitude,
    lh.longitude,
    d.rating,
    v.vehicle_type,
    lh.timestamp AS last_location_update
FROM 
    Drivers d
JOIN 
    Users u ON d.driver_id = u.user_id
JOIN 
    Location_History lh ON d.driver_id = lh.driver_id
LEFT JOIN 
    Vehicles v ON d.vehicle_id = v.vehicle_id
WHERE 
    d.status = 'available'
AND 
    lh.timestamp = (
        SELECT MAX(timestamp) 
        FROM Location_History 
        WHERE driver_id = d.driver_id
    );

-- Stored Procedure for Matching Ride Requests
DELIMITER //
CREATE PROCEDURE MatchRideRequest(
    IN p_rider_id INT,
    IN p_pickup_latitude DECIMAL(9,6),
    IN p_pickup_longitude DECIMAL(9,6),
    IN p_dropoff_latitude DECIMAL(9,6),
    IN p_dropoff_longitude DECIMAL(9,6)
)
BEGIN
    DECLARE matched_driver_id INT;
    DECLARE new_ride_id INT;

    -- Find the nearest available driver
    SELECT driver_id INTO matched_driver_id
    FROM Nearby_Drivers
    ORDER BY (
        6371 * ACOS(
            COS(RADIANS(p_pickup_latitude)) * COS(RADIANS(latitude)) * 
            COS(RADIANS(longitude) - RADIANS(p_pickup_longitude)) + 
            SIN(RADIANS(p_pickup_latitude)) * SIN(RADIANS(latitude))
        )
    ) ASC
    LIMIT 1;

    -- Insert new ride
    INSERT INTO Rides (
        rider_id, 
        driver_id, 
        start_location, 
        end_location, 
        ride_status
    ) VALUES (
        p_rider_id,
        matched_driver_id,
        CONCAT(p_pickup_latitude, ',', p_pickup_longitude),
        CONCAT(p_dropoff_latitude, ',', p_dropoff_longitude),
        'pending'
    );

    -- Get the new ride ID
    SET new_ride_id = LAST_INSERT_ID();

    -- Update driver status
    UPDATE Drivers 
    SET status = 'on_ride' 
    WHERE driver_id = matched_driver_id;

    -- Return ride details
    SELECT new_ride_id AS ride_id, matched_driver_id AS driver_id;
END //
DELIMITER ;

-- Trigger to update driver rating after ride completion
DELIMITER //
CREATE TRIGGER update_driver_rating AFTER INSERT ON Ratings_Reviews
FOR EACH ROW
BEGIN
    UPDATE Drivers d
    SET d.rating = (
        SELECT AVG(rating) 
        FROM Ratings_Reviews 
        WHERE driver_id = NEW.driver_id
    )
    WHERE d.driver_id = NEW.driver_id;
END //
DELIMITER ;

-- Function to calculate ride fare
DELIMITER //
CREATE FUNCTION CalculateFare(
    distance DECIMAL(5,2),
    base_rate DECIMAL(10,2),
    rate_per_km DECIMAL(10,2)
) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN base_rate + (distance * rate_per_km);
END //
DELIMITER ;

-- Additional Constraints and Checks
ALTER TABLE Rides 
ADD CONSTRAINT check_ride_locations 
CHECK (start_location IS NOT NULL AND end_location IS NOT NULL);

ALTER TABLE CARPOOLING 
ADD CONSTRAINT check_riders_capacity 
CHECK (current_riders <= max_capacity);