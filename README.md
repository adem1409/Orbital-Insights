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

🔍 1. Extract

Source data comes from three CSV files:

launches.csv – launch details (status, provider, mission, site, etc.)

rockets.csv – technical specs and metadata for rockets

satellites.csv – information about satellites and their orbits

Data is read into pandas DataFrames for initial inspection and cleansing.


🧪 2. Transform

📅 Date Formatting
All date fields (e.g. date, date_of_launch) are converted to proper datetime objects.
These dates are then broken into year, month, and day to populate the dim_date dimension.

❓ Handling Missing Values
Missing values are filled when possible using domain logic or calculated estimates:
orbit_period is estimated using a formula based on orbit class and altitude when missing.

🌍 Country Name Standardization
Country names are standardized across datasets using a reference mapping (e.g., 'USA' → 'United States', 'UK' → 'United Kingdom').
Arrays of country fields (country_of_operator, country_of_contractor) are also cleaned and deduplicated.

🚀 Rocket Name Normalization (Fuzzy Matching)
Rocket names across the launches and satellites datasets often have inconsistent naming.
Fuzzy matching (using fuzzywuzzy) is applied to align these names to a canonical list from rockets.csv.

🧩 Building the Fact Table
The cleaned and merged data is used to assign foreign keys from all dimension tables.
Each row in the fact table (fact_satellite_launch) is a unique combination of date, launch, satellite, rocket, and launch site — without any direct measure, forming a factless fact table.


🛢️ 3. Load

Data is loaded into a PostgreSQL data warehouse using psycopg2 and parameterized SQL queries.

Dimension tables are inserted with ON CONFLICT DO NOTHING to avoid duplicates.

Fact table entries are inserted only after all foreign key lookups succeed.
