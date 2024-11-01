INSERT INTO Customers (CustomerID, Name, PhoneNumber, Email, CNIC, EmergencyContact, RegistrationDate) VALUES
(1, 'Ayesha Khan', '03001234567', 'ayesha@email.com', '35202-1234567-1', '03009876543', CURRENT_TIMESTAMP),
(2, 'Fatima Ali', '03002345678', 'fatima@email.com', '35202-2345678-2', '03008765432', CURRENT_TIMESTAMP);

-- Insert sample Drivers
INSERT INTO Drivers (DriverID, Name, PhoneNumber, Email, CNIC, EmergencyContact, LicenseNumber, RegistrationDate) VALUES
(1, 'Zara Ahmed', '03003456789', 'zara@email.com', '35202-3456789-3', '03007654321', 'LHR-789-456', CURRENT_TIMESTAMP),
(2, 'Sana Malik', '03004567890', 'sana@email.com', '35202-4567890-4', '03006543210', 'LHR-012-345', CURRENT_TIMESTAMP);

-- Insert sample Vehicles
INSERT INTO Vehicles (VehicleID, DriverID, Make, Model, Year, Color, LicensePlate) VALUES
(1, 1, 'Toyota', 'Corolla', 2020, 'White', 'ABC-123'),
(2, 2, 'Honda', 'City', 2021, 'Silver', 'XYZ-789');

-- Insert sample Rides
INSERT INTO Rides (RideID, RequestID, CustomerID, DriverID, VehicleID, PickupLocation, DropoffLocation, PickupTime, DropoffTime, Fare, Status) VALUES
(1, 1, 1, 1, 1, 'DHA Phase 5', 'Gulberg III', CURRENT_TIMESTAMP, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 30 MINUTE), 500.00, 'Completed'),
(2, 2, 2, 2, 2, 'Johar Town', 'Model Town', CURRENT_TIMESTAMP, NULL, 350.00, 'In Progress');

-- Insert sample Payments
INSERT INTO Payments (PaymentID, RideID, Amount, Status, PaymentMethod, TransactionID, PaymentDate) VALUES
(1, 1, 500.00, 'Completed', 'Cash', 'CASH-001', CURRENT_TIMESTAMP),
(2, 2, 350.00, 'Pending', 'EasyPaisa', 'EP-001', CURRENT_TIMESTAMP);

-- Insert sample Reviews
INSERT INTO Reviews (ReviewID, RideID, ReviewerType, ReviewerID, Rating, Feedback, ReviewDate) VALUES
(1, 1, 'Customer', 1, 5, 'Excellent service, very polite driver', CURRENT_TIMESTAMP),
(2, 1, 'Driver', 1, 4, 'Pleasant passenger, clear directions', CURRENT_TIMESTAMP);

-- Insert sample SafetyFeatures
INSERT INTO SafetyFeatures (FeatureID, FeatureName, Description, IsActive) VALUES
(1, 'Emergency SOS', 'One-tap emergency alert to local authorities', TRUE),
(2, 'Share Ride Status', 'Share ride details with trusted contacts', TRUE);

-- Insert sample UserSafetyPreferences
INSERT INTO UserSafetyPreferences (PreferenceID, UserType, UserID, FeatureID, IsEnabled) VALUES
(1, 'Customer', 1, 1, TRUE),
(2, 'Customer', 1, 2, TRUE),
(3, 'Driver', 1, 1, TRUE);

-- Insert sample RideRequests
INSERT INTO RideRequests (RequestID, CustomerID, PickupLocation, DropoffLocation, RequestTime, Status) VALUES
(1, 1, 'DHA Phase 5', 'Gulberg III', DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 HOUR), 'Completed'),
(2, 2, 'Johar Town', 'Model Town', DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 30 MINUTE), 'Accepted');

-- Insert sample DriverVerifications
INSERT INTO DriverVerifications (VerificationID, DriverID, Status, VerificationDate) VALUES
(1, 1, 'Approved', DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)),
(2, 2, 'Approved', DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY));

-- Insert sample DriverAvailability
INSERT INTO DriverAvailability (AvailabilityID, DriverID, Status, LastUpdateTime, CurrentLocation) VALUES
(1, 1, 'Available', CURRENT_TIMESTAMP, POINT(31.5204, 74.3587)),
(2, 2, 'Busy', CURRENT_TIMESTAMP, POINT(31.4697, 74.2728));