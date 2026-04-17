CREATE DATABASE IF NOT EXISTS school_management;

USE school_management;

CREATE TABLE IF NOT EXISTS schools (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  latitude FLOAT NOT NULL,
  longitude FLOAT NOT NULL
);

-- Seed data for testing purposes
INSERT INTO schools (name, address, latitude, longitude) VALUES 
('Delhi Public School', 'Mathura Road, New Delhi', 28.5843, 77.2423),
('Bombay Scottish School', 'Mahim, Mumbai', 19.0336, 72.8397),
('Bishop Cotton Boys', 'St. Marks Road, Bangalore', 12.9719, 77.5990)
ON DUPLICATE KEY UPDATE name=VALUES(name);

