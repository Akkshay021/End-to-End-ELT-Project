# End-to-End-ELT-Project
ELT Project using Netflix data
# ELT Project Using Python and SQL

## Overview
This project demonstrates the ELT (Extract, Load, Transform) process using a dataset of Netflix movies and TV shows. The data is extracted and loaded into a SQL Server database using Python, where all transformations are performed directly in SQL. Post-transformation, the cleaned data is analyzed to gain insights into Netflix's content catalog.

## Objectives
- Understand the ELT workflow, where transformations are performed post-loading into the database.
- Leverage Python for data extraction and loading.
- Utilize SQL for data cleaning, transformation, and analysis.

## Dataset
The dataset used in this project is sourced from Kaggle: [Netflix Titles Dataset](https://www.kaggle.com/shivamb/netflix-shows). It contains information about Netflix's movies and TV shows, including attributes like title, release year, genre, country, and ratings.

## Steps
1. **Extract:**
   - The Netflix dataset is imported into a Python environment as a Pandas DataFrame.

2. **Load:**
   - Connected to a SQL Server database using SQLAlchemy.
   - Loaded the raw dataset into a table named `netflix_raw` in the `Netflix_Analysis` database.

3. **Transform:**
   - Data cleaning and transformation performed entirely within SQL Server:
     - Handling null and missing values.
     - Standardizing text formats.
     - Extracting year, genre, and duration details.
     - Categorizing content by type (Movies vs. TV Shows).
   - A new table `netflix_clean` was created for the cleaned and transformed data.

4. **Analyze:**
   - Conducted SQL queries to answer business-related questions and analyze Netflix's content library.

## Dependencies
- Python 3.x
- Libraries:
  - pandas
  - numpy
  - sqlalchemy
- SQL Server with ODBC Driver 17 for SQL Server


## SQL Table Schema
**Raw Table:** `netflix_raw`  
- Contains the raw data loaded from the dataset.

**Transformed Table:** `netflix_clean`  
Created after transformations in SQL. Example schema:
```sql
CREATE TABLE netflix_clean (
    [show_id] VARCHAR(20) PRIMARY KEY,
    [title] NVARCHAR(1000),
    [director] NVARCHAR(500),
    [cast] NVARCHAR(MAX),
    [country] NVARCHAR(100),
    [date_added] DATE,
    [release_year] INT,
    [rating] NVARCHAR(10),
    [duration] NVARCHAR(50),
    [type] NVARCHAR(50),
    [genre] NVARCHAR(100)
);
