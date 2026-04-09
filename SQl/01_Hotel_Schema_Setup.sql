CREATE TABLE users(
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);
CREATE TABLE bookings(
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50)
);

CREATE TABLE booking_commercials(
    id VARCHAR(50),
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2)
);

CREATE TABLE items(
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

INSERT INTO users VALUES
("21wrcxuy-67erfn", "Agan", "9712233455" , "agan90@example.com", "Ramnagar, Warangal"),
("13wrcxuy-56ajfn", "Rakesh", "7838977989" , "rakesh12@example.com", "Sri Nagar, Karimnagar");


INSERT INTO bookings VALUES
('A1232a', '2021-11-10 10:00:00', 'A1', '21wrcxuy-67erfn'),
('A2132a', '2021-11-15 12:00:00', 'A2', '13wrcxuy-56ajfn'),
('A3213a', '2021-10-05 09:00:00', 'A3', '21wrxcut-67erfn');


INSERT INTO booking_commercials VALUES
('1', 'A1232a', 'bill1', '2021-11-10', 'i1', 5),
('2', 'A1232a', 'bill1', '2021-11-10', 'i2', 2),
('3', 'A2132a', 'bill2', '2021-11-15', 'i3', 10),
('4', 'A3213a', 'bill3', '2021-10-05', 'i2', 15);

INSERT INTO items VALUES
('i1', 'Paratha', 20),
('i2', 'Paneer', 100),
('i3', 'Tea', 10);


