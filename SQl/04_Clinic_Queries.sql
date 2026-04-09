// Revenue from each sales channel (given year)

SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales 
WHERE strftime('%Y', datetime) = '2021'
GROUP BY sales_channel; 

// Top 10 most valuable customers 

SELECT 
    uid,
    SUM(amount) AS total_spent
FROM clinic_sales
WHERE strftime('%Y', datetime) = '2021'
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

// Month-wise revenue, expense, profit, status

WITH revenue AS (
    SELECT 
        strftime('%m', datetime) AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY month
),
expense AS (
    SELECT 
        strftime('%m', datetime) AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY month
)
SELECT 
    r.month,
    r.total_revenue,
    e.total_expense,
    (r.total_revenue - e.total_expense) AS profit,
    CASE 
        WHEN (r.total_revenue - e.total_expense) > 0 
        THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM revenue r
JOIN expense e 
    ON r.month = e.month;


// Most profitable clinic per city (given month)

WITH profit_data AS (
    SELECT 
        c.cid,
        c.city,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics c
    JOIN clinic_sales cs 
        ON c.cid = cs.cid
    LEFT JOIN expenses e 
        ON c.cid = e.cid
    WHERE strftime('%Y', cs.datetime) = '2021'
      AND strftime('%m', cs.datetime) = '09'
    GROUP BY c.cid, c.city
),
ranked AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY city 
            ORDER BY profit DESC
        ) AS rnk
    FROM profit_data
)
SELECT *
FROM ranked
WHERE rnk = 1;

// 2nd least profitable clinic per state (given month)

WITH profit_data AS (
    SELECT 
        c.cid,
        c.state,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics c
    JOIN clinic_sales cs 
        ON c.cid = cs.cid
    LEFT JOIN expenses e 
        ON c.cid = e.cid
    WHERE strftime('%Y', cs.datetime) = '2021'
      AND strftime('%m', cs.datetime) = '09'
    GROUP BY c.cid, c.state
),
ranked AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY state 
            ORDER BY profit ASC
        ) AS rnk
    FROM profit_data
)
SELECT *
FROM ranked
WHERE rnk = 2;