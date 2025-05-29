# 🚀 Orbital Insights

**Orbital Insights** is a data warehouse and business intelligence project built around satellites launch data. It models real-world satellites and rockest information using a star schema, automates the ETL process with Python, and visualizes insights through Metabase dashboards.

## 📊 Project Overview

This project transforms raw satellite, rocket, and launch data into an analytical data warehouse hosted on PostgreSQL. It provides KPIs such as:

- Most reliable rockets based on success rate
- Country contributions to satellite launches
- Rocket efficiency by thrust-to-payload ratio
- Satellite launch trends over time

## 🧰 Tech Stack

- **Python** — ETL scripts (pandas + psycopg2)
- **PostgreSQL** — Star schema data warehouse
- **Docker** — Containerized database setup

## 🧱 Data Warehouse Design

The schema is designed using a **factless fact table** to handle the many-to-many relationship between satellites and launches. It includes:

- `dim_satellite`
- `dim_rocket`
- `dim_launch`
- `dim_launch_site`
- `dim_date`
- `fact_satellite_launch`
![star_schema](https://github.com/user-attachments/assets/77f4a7da-84f5-4efd-976a-0ff11a3dc908)


## ⚙️ ETL Automation

The ETL script:
- Cleans and transforms raw CSV data
- Inserts surrogate keys (with fallback to "Unknown" members)
- Populates dimension tables and the fact table automatically
