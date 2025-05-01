-- Dimension Tables

CREATE TABLE dim_date (
    date_key SERIAL PRIMARY KEY,
    full_date DATE NOT NULL,
    year INTEGER,
    month INTEGER,
    day INTEGER
);

CREATE TABLE dim_launch_site (
    launch_site_key SERIAL PRIMARY KEY,
    space_port TEXT,
    country TEXT
);

CREATE TABLE dim_rocket (
    rocket_key SERIAL PRIMARY KEY,
    name TEXT,
    company TEXT,
    status TEXT,
    liftoff_thrust REAL,
    payload_leo REAL,
    stages REAL,
    height REAL,
    price REAL
);

CREATE TABLE dim_satellite (
    satellite_key SERIAL PRIMARY KEY,
    name TEXT,
    country_of_operator TEXT[],
    operator TEXT,
    users TEXT,
    purpose TEXT,
    class_of_orbit TEXT,
    orbit_period REAL,
    launch_mass REAL,
    expected_lifetime REAL,
    contractor TEXT,
    country_of_contractor TEXT[]
);

CREATE TABLE dim_launch (
    launch_key SERIAL PRIMARY KEY,
    status TEXT,
    provider TEXT,
    mission TEXT,
    launch_pad TEXT
);

-- Fact Table (Factless)
CREATE TABLE fact_satellite_launch (
    fact_id SERIAL PRIMARY KEY,
    date_key INTEGER REFERENCES dim_date(date_key),
    launch_site_key INTEGER REFERENCES dim_launch_site(launch_site_key),
    rocket_key INTEGER REFERENCES dim_rocket(rocket_key),
    satellite_key INTEGER REFERENCES dim_satellite(satellite_key),
    launch_key INTEGER REFERENCES dim_launch(launch_key)
);
