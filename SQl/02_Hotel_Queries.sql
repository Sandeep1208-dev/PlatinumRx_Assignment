// Last Booked Room

SELECT user_id,room_no 
FROM(
    SELECT 
    user_id,
    room_no, 
    ROW_NUMBER() OVER(
        PARTITION BY user_id 
        ORDER BY booking_date DESC
        ) AS rn 
    FROM bookings
) 
WHERE rn = 1;

// Billing In November 

SELECT 
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total
    FROM bookings b 
    JOIN booking_commercials bc ON b.booking_id = bc.booking_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE strftime('%Y-%m',b.boking_date) = '2021-11'
    GROUP BY b.booking_id;

// Bills > 1000

SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS total
FROM booking_commercials bc
JOIN items i 
    ON bc.item_id = i.item_id
WHERE strftime('%m', bc.bill_date) = '10'
  AND strftime('%Y', bc.bill_date) = '2021'
GROUP BY bc.bill_id
HAVING total > 1000;

// Most And Least items 

WITH data AS (
    SELECT 
        strftime('%m', bill_date) AS month,
        item_id,
        SUM(item_quantity) AS qty
    FROM booking_commercials
    GROUP BY month, item_id
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY month ORDER BY qty DESC) AS r1,
        RANK() OVER (PARTITION BY month ORDER BY qty ASC) AS r2
    FROM data
)
SELECT * FROM ranked
WHERE r1 = 1 OR r2 = 1;

// 2nd Highest Bill

WITH bills AS (
    SELECT 
        bill_id,
        strftime('%m', bill_date) AS month,
        SUM(item_quantity * item_rate) AS total
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY bill_id, month
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY month ORDER BY total DESC) AS rnk
    FROM bills
)
SELECT * FROM ranked
WHERE rnk = 2;