use business_schema;
CREATE OR REPLACE VIEW business_table_merged AS
SELECT
    s.date,
    s.shop_id,
    s.shop_name,
    s.customers,
    s.sales_usd,

    ROUND(s.sales_usd / NULLIF(s.customers, 0), 2) AS Sales_Per_Customer,

    DAYNAME(s.date) AS Day_Of_Week,

    CASE
        WHEN DAYOFWEEK(s.date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS is_weekend,

    su.pct_male,
    su.pct_female,
    su.pct_family,
    su.pct_single,

    w.avg_temp_f,
    ROUND((w.avg_temp_f - 32) * 5 / 9, 2) AS temp_celsius,
    w.precip_in,

    CASE
        WHEN w.precip_in > 0 THEN 'Raining'
        ELSE 'Not Raining'
    END AS is_rain,

    w.humidity_pct

FROM sales s
LEFT JOIN survey su
    ON s.date = su.date
LEFT JOIN weather w
    ON s.date = w.date;