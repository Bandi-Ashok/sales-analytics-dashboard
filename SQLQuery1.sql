
use ecommerce

create database ecommerce;

CREATE TABLE dim_customer (
    CustomerID INT PRIMARY KEY,
    CustomerLocation VARCHAR(100),
    CustomerSegment VARCHAR(50)
);

CREATE TABLE dim_product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(150),
    ProductCategory VARCHAR(100)
);

CREATE TABLE dim_date (
    DateKey DATE PRIMARY KEY,
    Day INT,
    Month INT,
    Year INT
);

CREATE TABLE fact_sales (
    OrderID INT PRIMARY KEY,

    CustomerID INT,
    ProductID INT,
    DateKey DATE,

    Quantity INT CHECK (Quantity >= 0),
    PricePerUnit DECIMAL(10,2),

    TotalRevenue DECIMAL(12,2),

    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50),

    DiscountApplied DECIMAL(10,2),
    DeliveryTime INT,
    IsReturned BIT,

    FOREIGN KEY (CustomerID) REFERENCES dim_customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES dim_product(ProductID),
    FOREIGN KEY (DateKey) REFERENCES dim_date(DateKey)
);


select * from dim_customer;


SELECT COUNT(*) FROM fact_sales;
SELECT COUNT(*) FROM dim_customer;
SELECT * FROM fact_sales WHERE TotalRevenue IS NULL;



1. Total Revenue (KPI)


select sum(TotalRevenue) as total_revenue
from fact_sales

2. Revenue by Product


select ProductID,sum(TotalRevenue) as total_revenue
from fact_sales
group by ProductID
order by total_revenue desc;




select orderstatus,count(*) as total_ordes
from fact_sales
group by OrderStatus

4. Return Rate



select 
(case when IsReturned = 1 then 1 else 0 end)*100.0/count(*) as persentgae
from fact_sales
group by IsReturned


select customerid,sum(totalrevenue) as top_customers
from fact_sales
group by CustomerID
order by top_customers desc; 


SELECT 
p.ProductName,
SUM(f.TotalRevenue) AS Revenue
FROM fact_sales f
JOIN dim_product p ON f.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY Revenue DESC;


ecommerce



