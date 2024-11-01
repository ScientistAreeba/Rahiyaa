-- Active: 1728133312199@@127.0.0.1@3306@rahiyaa
-- Customers Table
create table Customers
(
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    PhoneNumeber VARCHAR(20),
    Email VARCHAR(100),
    CNIC VARCHAR(15),
    EmergencyContact VARCHAR(100),
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Drivers Table
create table Drivers
(
    DriverID INT PRIMARY KEY,
    Name VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    CNIC VARCHAR(15),
    EmergencyContact VARCHAR(100),
    LicenseNumber VARCHAR(20),
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Vehicles Table
create table Vehicles 
(
    VehicleID INT PRIMARY KEY,
    DriverID INT,
    Make VARCHAR(50),
    Model VARCHAR(50),
    Year INT,
    Color VARCHAR(20),
    LicensePlate VARCHAR(20),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

-- Driver Verification Table
create table DriverVerifications
(
    VerificationID INT PRIMARY KEY,
    DriverID INT,
    Status ENUM ('Pending', 'Approved', 'Rejected'),
    VerificationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

-- Ride Requests Table
create table RideRequests
(
    RequestID INT PRIMARY KEY,
    CustomerID INT,
    PickupLocation VARCHAR(200),
    DropoffLocation VARCHAR(200),
    RequestTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Pending', 'Accepted', 'Cancelled'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Rides Table
create table Rides
(
    RideID INT PRIMARY KEY,
    RequestID INT,
    CustomerID INT,
    DriverID INT,
    VehicleID INT,
    PickupLocation VARCHAR(200),
    DropoffLocation VARCHAR(200),
    PickupTime TIMESTAMP,
    DropoffTime TIMESTAMP,
    Fare DECIMAL (10,2), 
    Status ENUM('In Progress', 'Completed', 'Cancelled'),
    FOREIGN KEY (RequestID) REFERENCES RideRequests(RequestID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);

-- Payments Table
create table Payments
(
    PaymentID INT PRIMARY KEY,
    RideID INT,
    Amount DECIMAL (10,2),
    Status ENUM('Pending','Completed','Failed'),
    PaymentMethod ENUM('Cash','Credit Card','Debit Card','EasyPaisa','JazzCash'),
    TransactionID VARCHAR(100),
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RideID) REFERENCES Rides(RideID)
);

-- Reviews Table
create table Reviews
(
    ReviewID INT PRIMARY KEY,
    RideID INT,
    ReviewType ENUM('Customer','Driver'),
    ReviewerID INT,
    Rating INT CHECK (Rating>=1 AND Rating <= 5),
    Feedback TEXT,
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RideID) REFERENCES Rides(RideID)
);

-- SOS Alert Table
create table SOSAlerts
(
    AlertID INT PRIMARY KEY,
    UserType ENUM('Customer','Driver'),
    UserID INT,
    RideID INT,
    AlertTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AlertType ENUM('Medical','Safety','Other'),
    Location VARCHAR (200),
    Status ENUM ('Active','Resolved','False Alarm'),
    FOREIGN KEY (RideID) REFERENCES Rides(RideID)
);

-- Preferred Drivers Network
create table PreferredDrivers (
    CustomerID INT,
    DriverID INT,
    DateAdded TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (CustomerID, DriverID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

-- Scheduled Rides
create table ScheduledRides
(
    ScheduleID INT PRIMARY KEY,
    CustomerID INT,
    PickupLocation VARCHAR(200),
    DropoffLocation VARCHAR(200),
    ScheduledPickupTime TIME,
    RecurrencePattern ENUM('Daily','Weekdays','Weekly'),
    StartDate DATE,
    EndDate DATE,
    Status ENUM('Active','Paused','Cancelled'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- User Verification Table (for both customers and drivers)
create table UserVerifications (
    VerificationID INT PRIMARY KEY,
    UserType ENUM('Customer', 'Driver'),
    UserID INT,
    VerificationType ENUM('Phone', 'Email', 'Government ID', 'Face Recognition'),
    Status ENUM('Pending', 'Approved', 'Rejected'),
    VerificationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- In-App Messages Table
create table InAppMessages
(
    MessageID INT PRIMARY KEY,
    SenderType ENUM('Customer','Driver','System'),
    SenderID INT,
    ReceiverType ENUM('Customer','Driver'),
    ReveiverID INT,
    RideID INT,
    MessageContent TEXT,
    SentTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ReadStatus BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (RideID) REFERENCES Rides(RideID)
);

-- -- Promo Codes Table
-- create table PromoCodes 
-- (
--     PromoID INT PRIMARY KEY,
--     Code VARCHAR(20) UNIQUE,
--     DiscountType ENUM('Percentage', 'Fixed Amount'),
--     DiscountValue DECIMAL(10, 2),
--     StartDate DATE,
--     EndDate DATE,
--     UsageLimit INT,
--     CurrentUsage INT DEFAULT 0
-- );

-- -- User Promo Usage Table
-- create table UserPromoUsage
-- (
--     UsageID INT PRIMARY KEY,
--     UserID INT,
--     PromoID INT,
--     RideID INT,
--     UsageDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     FOREIGN KEY (PromoID) REFERENCES PromoCodes(PromoID),
--     FOREIGN KEY (RideID) REFERENCES Rides(RideID)
-- );

-- -- Ride Zone Table
-- create table RideZones      
-- (
--     ZoneID INT PRIMARY KEY,
--     ZoneName VARCHAR(100),
--     Coordinated POLYGON,
--     BasePrice Decimal(10,2),
--     PricePerKM DECIMAL(10,2)
-- );

-- Driver Availablitiy Table
create table DriverAvailability
(
    AvailabilityID INT PRIMARY KEY,
    DriverID INT,
    Status ENUM('Available','Busy','Offline'),
    LastUpdateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CurrentLocation POINT,
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

-- -- User Documents Table
-- create table UserDocuments
-- (
--     DocumentID INT PRIMARY KEY,
--     UserType ENUM('Customer','Driver'),
--     UserID INT,
--     DocumentType ENUM('ID Card','Driver License','Vehicle Registration','Insurance'),
--     DocumentURL VARCHAR(255),
--     UploadDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     VerificationStatus ENUM ('Pending','Approved','Rejected')
-- );

-- -- Safety Features Table
-- create table SafetyFeatures
-- (
--     FeatureID INT PRIMARY KEY,
--     FeatureName VARCHAR(100),
--     Description TEXT,
--     IsActive BOOLEAN DEFAULT TRUE
-- );

-- --User Safety Preferences Table
-- create table UserSafetyPreferences
-- (
--     PreferenceID INT PRIMARY KEY,
--     UserType ENUM('Customer','Driver'),
--     UserID INT,
--     FeatureID INT,
--     IsEnabled BOOLEAN DEFAULT TRUE,
--     FOREIGN KEY (FeatureID) REFERENCES SafetyFeatures(FeatureID)
-- );