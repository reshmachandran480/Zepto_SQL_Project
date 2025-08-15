## Zepto SQL Data Analysis Project


### 📌 Project Overview

This project analyzes product data from **Zepto**, a popular quick-commerce grocery delivery platform.
Using **PostgreSQL**, I performed **data exploration, data cleaning**, and **business insights generation** to practice SQL skills and gain hands-on experience with real-world datasets.

This is part of my journey to becoming a **Data Scientist**, focusing on **SQL for Data Analysis**.

### 📊 Dataset Source

The dataset used in this project is publicly available on Kaggle:
📎[ZeptoInventory Dataset – Kaggle](https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset/data)
**Author**: Palvinder Singh

This dataset contains product details such as category, pricing, discounts, availability, and weight, which are ideal for practicing SQL data analysis.

### 🎯 Objectives

- 1. **Understand the dataset** by exploring product categories, availability, and pricing.
- 2. **Clean the data** to remove invalid or inconsistent entries.
- 3. **Generate business insights** for decision-making, such as:
        - Top discounts
        - Out-of-stock high-value products
        - Estimated revenue by category
        - Price-per-gram analysis

  analysis

### 📁 Dataset Details

| Column                 | Description                                                      |
| ---------------------- | ---------------------------------------------------------------  |
| sku\_id                | Unique identifier for each product entry (Synthetic Primary Key) |
| category               |  Product category like Fruits, Snacks, Beverages, etc.           |
| name                   | Product name as it appears on the app                            |
| mrp                    | Maximum Retail Price (originally in paise, converted to ₹)       |
| discountPercent        | Discount applied on MRP                                          |
| availableQuantity      | Units available in inventory                                     |
| discountedSellingPrice | Final price after discount (also converted to ₹)                 |
| weightInGms            | Product weight in grams                                          |
| outOfStock             | Boolean flag indicating stock availability                       |
| quantity               | Number of units per package (mixed with grams for loose produce) |


### 🛠 SQL Tasks Performed

#### 1️⃣ Database & Table Creation
```
CREATE TABLE zepto (
  sku_id SERIAL PRIMARY KEY,
  category VARCHAR(120),
  name VARCHAR(150) NOT NULL,
  mrp NUMERIC(8,2),
  discountPercent NUMERIC(5,2),
  availableQuantity INTEGER,
  discountedSellingPrice NUMERIC(8,2),
  weightInGms INTEGER,
  outOfStock BOOLEAN,
  quantity INTEGER
);
```
#### 2️⃣ Data Import
Loaded CSV using pgAdmin's import feature.

#### 13️⃣ Data Exploration
- Counted total rows in the dataset
- Viewed sample records
- Checked for **null values**
- Listed all **product categories**
- Checked **in-stock vs. out-of-stock** products
- Identified **duplicate product names**

#### 4️⃣ Data Cleaning
- Removed products with **MRP or selling price = 0**
- Converted MRP & Selling Price from **paise to rupees**

#### 5️⃣ Business Insights Queries
- **Top 10 products** by highest discount percentage
- **High MRP & out-of-stock** products
- **Estimated revenue** per category
- Products with **MRP > 500** but low discount (< 10%)
- **Top 5 categories** by average discount percentage
- **Price per gram** for products above 100g
- Categorized products as **Low, Medium, Bulk weight**
- **Total inventory weight** per category

### 📊 Sample Insights
- Found categories offering **> 25% average discounts.**
- Identified **high-value products that are out of stock.**
- Estimated **category-wise revenue** based on selling price & quantity.
- Highlighted **best-value products** based on price-per-gram.

### 📂 Project Structure

📁 zepto-sql-analysis

│── 📄 README.md       # Project documentation

│── 📄 zepto_SQL_project.sql       # SQL queries

│── 📄 zepto_data.csv  # Dataset (if allowed to share, or link to Kaggle)

### 🧠 Skills Practiced
- **SQL Data Cleaning**
- **Aggregate Functions** (SUM, AVG, COUNT)
- **Joins & Grouping** (GROUP BY, HAVING)
- **Case Statements** for categorization
- **Business Analysis** with SQL
