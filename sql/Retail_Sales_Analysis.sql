-- =====================================================
-- RETAIL SALES ANALYSIS PROJECT
-- Dataset: Sample Superstore
-- Database: retail_sales
-- Table: superstore
-- Purpose: Analyze sales, profit, products, customers,
--          regions, time trends, and discount impact.
-- =====================================================

USE retail_sales;

-- =====================================================
-- 1. DATA CHECKING
-- =====================================================

-- 1.1 Preview data
SELECT *
FROM superstore
LIMIT 10;

-- 1.2 Count total rows
SELECT COUNT(*) AS total_rows
FROM superstore;

-- 1.3 Check table structure
DESCRIBE superstore;


-- =====================================================
-- 2. KPI OVERVIEW
-- =====================================================

-- 2.1 Total revenue, profit, orders, and customers
SELECT 
    ROUND(SUM(Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    COUNT(DISTINCT `Customer ID`) AS total_customers
FROM superstore;

-- 2.2 Total revenue
SELECT 
    ROUND(SUM(Sales), 2) AS total_revenue
FROM superstore;

-- 2.3 Total profit
SELECT 
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore;

-- 2.4 Total orders
SELECT 
    COUNT(DISTINCT `Order ID`) AS total_orders
FROM superstore;

-- 2.5 Total customers
SELECT 
    COUNT(DISTINCT `Customer ID`) AS total_customers
FROM superstore;

-- 2.6 Average order value
SELECT 
    ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS average_order_value
FROM superstore;


-- =====================================================
-- 3. PRODUCT ANALYSIS
-- =====================================================

-- 3.1 Top 10 products by revenue
SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY `Product Name`
ORDER BY revenue DESC
LIMIT 10;

-- 3.2 Top 10 products by profit
SELECT
    `Product Name`,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY `Product Name`
ORDER BY profit DESC
LIMIT 10;

-- 3.3 Top 10 loss-making products
SELECT
    `Product Name`,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY `Product Name`
ORDER BY profit ASC
LIMIT 10;

-- 3.4 Top 10 products by quantity sold
SELECT
    `Product Name`,
    SUM(Quantity) AS total_quantity
FROM superstore
GROUP BY `Product Name`
ORDER BY total_quantity DESC
LIMIT 10;

-- 3.5 Product profit margin
SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS revenue,
    ROUND(SUM(Profit), 2) AS profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percent
FROM superstore
GROUP BY `Product Name`
HAVING revenue > 0
ORDER BY profit_margin_percent DESC
LIMIT 10;


-- =====================================================
-- 4. CATEGORY ANALYSIS
-- =====================================================

-- 4.1 Revenue by category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY Category
ORDER BY revenue DESC;

-- 4.2 Profit by category
SELECT
    Category,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY Category
ORDER BY profit DESC;

-- 4.3 Revenue by sub-category
SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY `Sub-Category`
ORDER BY revenue DESC;

-- 4.4 Profit by sub-category
SELECT
    `Sub-Category`,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY `Sub-Category`
ORDER BY profit DESC;

-- 4.5 Category profit margin
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS revenue,
    ROUND(SUM(Profit), 2) AS profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percent
FROM superstore
GROUP BY Category
ORDER BY profit_margin_percent DESC;


-- =====================================================
-- 5. CUSTOMER ANALYSIS
-- =====================================================

-- 5.1 Top 10 customers by revenue
SELECT
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY `Customer Name`
ORDER BY revenue DESC
LIMIT 10;

-- 5.2 Top 10 customers by profit
SELECT
    `Customer Name`,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY `Customer Name`
ORDER BY profit DESC
LIMIT 10;

-- 5.3 Revenue by customer segment
SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY Segment
ORDER BY revenue DESC;

-- 5.4 Profit by customer segment
SELECT
    Segment,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY Segment
ORDER BY profit DESC;

-- 5.5 Number of customers by segment
SELECT
    Segment,
    COUNT(DISTINCT `Customer ID`) AS total_customers
FROM superstore
GROUP BY Segment
ORDER BY total_customers DESC;


-- =====================================================
-- 6. REGIONAL ANALYSIS
-- =====================================================

-- 6.1 Revenue by region
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY Region
ORDER BY revenue DESC;

-- 6.2 Profit by region
SELECT
    Region,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY Region
ORDER BY profit DESC;

-- 6.3 Region performance by revenue and profit
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS revenue,
    ROUND(SUM(Profit), 2) AS profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percent
FROM superstore
GROUP BY Region
ORDER BY profit ASC;

-- 6.4 Top 10 states by revenue
SELECT
    State,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY State
ORDER BY revenue DESC
LIMIT 10;

-- 6.5 Top 10 states by profit
SELECT
    State,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY State
ORDER BY profit DESC
LIMIT 10;

-- 6.6 Top 10 loss-making states
SELECT
    State,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY State
ORDER BY profit ASC
LIMIT 10;

-- 6.7 Revenue by city
SELECT
    City,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY City
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- 7. TIME SERIES ANALYSIS
-- =====================================================

-- 7.1 Revenue by year
SELECT
    YEAR(`Order Date`) AS year_,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY year_
ORDER BY year_;

-- 7.2 Profit by year
SELECT
    YEAR(`Order Date`) AS year_,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY year_
ORDER BY year_;

-- 7.3 Monthly revenue trend
SELECT
    YEAR(`Order Date`) AS year_,
    MONTH(`Order Date`) AS month_,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY year_, month_
ORDER BY year_, month_;

-- 7.4 Monthly profit trend
SELECT
    YEAR(`Order Date`) AS year_,
    MONTH(`Order Date`) AS month_,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY year_, month_
ORDER BY year_, month_;

-- 7.5 Revenue by quarter
SELECT
    YEAR(`Order Date`) AS year_,
    QUARTER(`Order Date`) AS quarter_,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY year_, quarter_
ORDER BY year_, quarter_;


-- =====================================================
-- 8. DISCOUNT ANALYSIS
-- =====================================================

-- 8.1 Average profit by discount level
SELECT
    Discount,
    ROUND(AVG(Profit), 2) AS avg_profit
FROM superstore
GROUP BY Discount
ORDER BY Discount;

-- 8.2 Revenue by discount level
SELECT
    Discount,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY Discount
ORDER BY Discount;

-- 8.3 Profit by discount level
SELECT
    Discount,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY Discount
ORDER BY Discount;

-- 8.4 Profit margin by discount level
SELECT
    Discount,
    ROUND(SUM(Sales), 2) AS revenue,
    ROUND(SUM(Profit), 2) AS profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percent
FROM superstore
GROUP BY Discount
ORDER BY Discount;


-- =====================================================
-- 9. SHIPPING ANALYSIS
-- =====================================================

-- 9.1 Revenue by ship mode
SELECT
    `Ship Mode`,
    ROUND(SUM(Sales), 2) AS revenue
FROM superstore
GROUP BY `Ship Mode`
ORDER BY revenue DESC;

-- 9.2 Profit by ship mode
SELECT
    `Ship Mode`,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY `Ship Mode`
ORDER BY profit DESC;

-- 9.3 Number of orders by ship mode
SELECT
    `Ship Mode`,
    COUNT(DISTINCT `Order ID`) AS total_orders
FROM superstore
GROUP BY `Ship Mode`
ORDER BY total_orders DESC;


-- =====================================================
-- 10. BUSINESS INSIGHT SUPPORT QUERIES
-- =====================================================

-- 10.1 High revenue but low profit products
SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS revenue,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY `Product Name`
HAVING revenue > 5000 AND profit < 0
ORDER BY revenue DESC;

-- 10.2 States with negative profit
SELECT
    State,
    ROUND(SUM(Sales), 2) AS revenue,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY State
HAVING profit < 0
ORDER BY profit ASC;

-- 10.3 Sub-categories with negative profit
SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS revenue,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY `Sub-Category`
HAVING profit < 0
ORDER BY profit ASC;

-- 10.4 Best performing region and category combination
SELECT
    Region,
    Category,
    ROUND(SUM(Sales), 2) AS revenue,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY Region, Category
ORDER BY profit DESC;

-- 10.5 Worst performing region and category combination
SELECT
    Region,
    Category,
    ROUND(SUM(Sales), 2) AS revenue,
    ROUND(SUM(Profit), 2) AS profit
FROM superstore
GROUP BY Region, Category
ORDER BY profit ASC;