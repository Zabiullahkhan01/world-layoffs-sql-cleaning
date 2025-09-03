# World Layoffs Data Cleaning Project 🧹📊

A comprehensive SQL data cleaning and preprocessing pipeline for analyzing global tech industry layoffs dataset.

## 📋 Project Overview

This project demonstrates advanced SQL data cleaning techniques applied to a real-world dataset containing information about layoffs in the global technology sector. The goal was to transform raw, inconsistent data into a clean, analysis-ready format suitable for exploratory data analysis and business intelligence reporting.

## 🎯 Objectives

- **Data Quality Improvement**: Remove duplicates, standardize formats, and handle missing values
- **Data Integrity**: Preserve original data while creating clean working datasets
- **Analysis Preparation**: Transform data types and structure for efficient querying and visualization
- **Best Practices**: Implement industry-standard data cleaning methodologies

## 📊 Dataset Description

The original dataset contains information about layoffs across various companies with the following key attributes:

| Column | Description | Data Type |
|--------|-------------|-----------|
| `company` | Company name | Text |
| `location` | Geographic location of layoffs | Text |
| `industry` | Industry sector | Text |
| `total_laid_off` | Number of employees laid off | Integer |
| `percentage_laid_off` | Percentage of workforce affected | Text |
| `date` | Date of layoff announcement | Text (initially) |
| `stage` | Company funding stage | Text |
| `country` | Country location | Text |
| `funds_raised_millions` | Total funds raised (in millions) | Integer |

## 🔧 Data Cleaning Methodology

### Phase 1: Data Preservation & Duplicate Removal
1. **Created staging tables** to preserve original data integrity
2. **Identified duplicates** using window functions (`ROW_NUMBER()`) with comprehensive partitioning
3. **Removed duplicate records** while maintaining data relationships

### Phase 2: Data Standardization
1. **Text cleaning**: Removed leading/trailing whitespaces using `TRIM()` and `trail()` method
2. **Industry standardization**: Consolidated similar industry names (e.g., "Crypto" vs "Cryptocurrency")
3. **Country normalization**: Fixed formatting inconsistencies (removed trailing periods)
4. **Date formatting**: Converted text dates to proper SQL DATE datatype for time-series analysis

### Phase 3: Missing Data Handling
1. **Smart population**: Used self-joins to fill missing industry values based on company-location matches
2. **Strategic deletion**: Removed records with critical missing information (both `total_laid_off` and `percentage_laid_off`)
3. **Data validation**: Cross-referenced entries to ensure accuracy

## 🛠️ SQL Techniques Demonstrated

- **Common Table Expressions (CTEs)** for complex data identification
- **Window Functions** (`ROW_NUMBER()`, `PARTITION BY`) for duplicate detection
- **Self-joins** for intelligent data imputation
- **String functions** (`TRIM()`, `LIKE`, `STR_TO_DATE()`) for data standardization
- **Data type conversions** and table schema modifications
- **Conditional updates** and bulk data operations

## 📁 Repository Structure

```
world-layoffs-sql-cleaning/
│
├── README.md                              # Project documentation
├──layoffs.csv                             # raw csv file
├── world_layoff_sql_data_cleaning_project.sql  # Main SQL script
├── docs/                                  # Additional documentation
│   ├── data-dictionary.md                # Column definitions
```

## 🚀 How to Run the Project

### Prerequisites
- MySQL Server 5.7+ or MySQL 8.0+
- Access to the world layoffs dataset
- Basic SQL knowledge for understanding the queries

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/world-layoffs-sql-cleaning.git
   cd world-layoffs-sql-cleaning
   ```

2. **Database Setup**
   ```sql
   CREATE DATABASE world_layoff;
   USE world_layoff;
   ```

3. **Load original dataset**
   ```sql
   -- Import your layoffs.csv file into a table named 'layoffs'
   -- Ensure column names match the schema in the SQL script
   ```

4. **Execute cleaning script**
   ```sql
   SOURCE world_layoff_sql_data_cleaning_project.sql;
   ```

## 📈 Results & Impact

### Data Quality Improvements
- **Duplicate removal**: Eliminated redundant records ensuring unique entries
- **Standardization**: Achieved 100% consistency in company names, industries, and country formats
- **Date formatting**: Converted all dates to proper SQL DATE format enabling time-series analysis
- **Missing data handling**: Reduced null values through intelligent imputation and strategic removal

### Key Metrics
- **Records processed**: 
- **Duplicates removed**:
- **Null values handled**: 
- **Data integrity**: 100% maintained through staging table approach

## 🔍 Sample Queries

After cleaning, the data supports complex analytical queries:

```sql
-- Top 10 companies by total layoffs
SELECT company, SUM(total_laid_off) as total_layoffs
FROM layoffs_staging2 
WHERE total_laid_off IS NOT NULL
GROUP BY company 
ORDER BY total_layoffs DESC 
LIMIT 10;

-- Monthly layoff trends
SELECT DATE_FORMAT(date, '%Y-%m') as month, SUM(total_laid_off) as monthly_layoffs
FROM layoffs_staging2 
WHERE total_laid_off IS NOT NULL
GROUP BY month 
ORDER BY month;

-- Industry impact analysis
SELECT industry, COUNT(*) as layoff_events, AVG(total_laid_off) as avg_layoffs
FROM layoffs_staging2 
WHERE industry IS NOT NULL AND total_laid_off IS NOT NULL
GROUP BY industry 
ORDER BY layoff_events DESC;
```

## 🚀 Next Steps & Future Enhancements

- **Exploratory Data Analysis (EDA)**: Statistical analysis and trend identification
- **Data Visualization**: Create interactive dashboards using Tableau/Power BI
- **Predictive Modeling**: Build models to forecast layoff patterns
- **Real-time Updates**: Implement automated data pipeline for new records

## 💼 Skills Demonstrated

- **SQL Proficiency**: Advanced querying, joins, window functions, CTEs
- **Data Quality Management**: Systematic approach to data cleaning challenges
- **Problem Solving**: Creative solutions for complex data inconsistencies  
- **Documentation**: Clear, comprehensive project documentation
- **Best Practices**: Industry-standard data preprocessing methodologies

## 📚 Technologies Used

- **Database**: MySQL 8.0
- **Language**: SQL
- **Tools**: MySQL Workbench, Command Line Interface
- **Version Control**: Git & GitHub

## 🤝 Contributing

Feel free to fork this repository and submit pull requests for:
- Additional data cleaning techniques
- Enhanced documentation
- Sample analysis queries
- Performance optimizations

## 📧 Contact

**[Zabiullah Khan]**  
- LinkedIn: [https://www.linkedin.com/in/zabiullah-khan-2852702ba]  
- Email: [zabiullah.khan2002@gmail.com]  

---

⭐ **If you found this project helpful, please give it a star!** ⭐

---

*This project showcases practical SQL skills applicable to data analyst, data engineer, and business intelligence roles.*
