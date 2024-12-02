#users table
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

#drivers table
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

#vehicles table
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

#rides table
CREATE TABLE Rides (
    ride_id INT PRIMARY KEY AUTO_INCREMENT,
    rider_id INT NOT NULL,
    driver_id INT,
    start_location VARCHAR(255),
    end_location VARCHAR(255),
    distance DECIMAL (5,2),
    ride_status ENUM('pending','accepted','completed','cancelled') DEFAULT 'pending',
    fare DECIMAL(10,2),
    ride_start_time TIMESTAMP,
    ride_end_time TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rider_id) REFERENCES Users(user_id),
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

#payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    ride_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('paid','pending','failed') DEFAULT 'pending',
    payment_method ENUM('credit_card','debit_card','cash','mobile_wallet') NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ride_id) REFERENCES Rides(ride_id)
);

#ratings and reviews table
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

#Locaton history table 
CREATE TABLE Location_History(
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    driver_id INT NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9.6) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

#Ride request table
CREATE TABLE Ride_Requests(
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    rider_id INT NOT NULL,
    pickup_location VARCHAR(255) NOT NULL,
    dropoff_location VARCHAR(255) NOT NULL,
    status ENUM('requested','matched','cancelled') DEFAULT 'requested',
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(rider_id) REFERENCES Users(user_id)
);

#notifications table
CREATE TABLE Notifications(
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

#driver docs table
CREATE TABLE Driver_Documents(
    document_id INT PRIMARY KEY AUTO_INCREMENT,
    driver_id INT NOT NULL,
    document_type ENUM('license','identity_card','vehicle_registration') NOT NULL,
    document_url VARCHAR(255),
    is_verified BOOLEAN DEFAULT FALSE,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(driver_id) REFERENCES Drivers(driver_id)
);

#emergency contacts table
CREATE TABLE Emergency_Contacts (
    contact_id INT PRIMARY KEY AUTO_INCREMENT,
    rider_id INT NOT NULL,
    contact_name VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(15) NOT NULL,
    relationship VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (rider_id) REFERENCES Users(user_id)
);

#support ticket thingy table
CREATE TABLE Support_Tickets(
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    subject VARCHAR(255) not null,
    description TEXT,
    status ENUM('open','in_progress','resolved','closed') DEFAULT 'open',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

#promotions table
CREATE TABLE Promotions(
    promo_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) UNIQUE NOT NULL,
    discount_percentage DECIMAL(5,2) NOT NULL,
    valid_until DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
)

#ride promo table
CREATE TABLE Ride_Promotions(
    ride_promo_id INT PRIMARY KEY AUTO_INCREMENT,
    ride_id INT NOT NULL,
    promo_id INT NOT NULL,
    FOREIGN KEY (ride_id) REFERENCES Rides(ride_id),
    FOREIGN KEY (promo_id) REFERENCES Promotions(promo_id)
);
