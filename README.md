# Macroeconomic-and-Financial-Stability-Analysis-
This title describes about the financial and macroeconomic stability with the available data from the year 2000-2024

# Introduction
Macroeconomic stability plays a central role in determining a country’s long-term economic growth and financial health. This study analyzes key macro-financial indicators — GDP growth, inflation (CPI), interest rates, exchange rates, and unemployment levels — for multiple countries from 2000 to 2024.

# objective 

  Examine long-term economic patterns
  Understand relationships between monetary variables
  Identify drivers of economic performance
  Evaluate financial stability across regions and income groups
  Provide data-driven insights using analytical tools

This project uses a combination of Excel, SQL, Python, and Power BI, reflecting a full analytics workflow suitable for professional financial analysis roles.

# Dataset Description

The dataset contains annual macroeconomic indicators for various countries between 2000–2024. Data sources are primarily the World Bank Open Data portal.

# Variables Used
Variable	Description
country_name -	Name of the country
country_code - ISO country code
region	- Geographic region classification
income_group	- Income level classification (Low, Lower-Middle, Upper-Middle, High)
year	- Observation year
cpi	- Consumer Price Index (Inflation %)
int_rate	- Interest rate (Bank Rate / Policy Rate / Real Interest Rate)
gdp_growth_rate	- Annual % change in GDP
gdp - GDP in constant USD
exchange_rate	- Local currency units per USD
unemployment_rate -	Unemployment %, optional

Data was cleaned and transformed in Excel, stored and queried in SQL, statistically analyzed in Python, and visualized using Power BI.

# Methodology
This project followed a structured analytics approach:
1 Data Cleaning (Excel)

Removed duplicate entries

Handled missing values using regional median imputation

Normalized column names

Converted exchange rates to numeric format

Ensured year and GDP fields were consistent

2 SQL Analysis

SQL was used to:

Compute regional and income-group level averages

Identify highest/lowest inflation and GDP growth years

Calculate year-over-year trends

Rank countries by financial stability

Join and aggregate data for dashboard use

Key SQL operations included:

Window functions (LAG, LEAD)

GROUP BY aggregations

CTEs for intermediate calculations

Ranking using ROW_NUMBER and DENSE_RANK

3. Python Analysis

Python (Pandas, Matplotlib, Seaborn, Statsmodels) was used for deeper statistical analysis.

# Exploratory Data Analysis (EDA)

Trend charts for inflation, GDP growth, interest rates

Distribution plots to detect volatility

Outlier detection using IQR and Z-Scores

## Correlation Analysis

A correlation matrix revealed relationships such as:

Inflation vs Interest Rate: Generally positive in emerging economies

Interest Rate vs GDP Growth: Often negative, suggesting monetary tightening reduces growth

Exchange Rate vs Inflation: Depreciation linked to higher inflation

Unemployment vs GDP Growth: Negative (Okun’s Law)

## Regression Analysis

A multiple linear regression model evaluated:

GDP Growth (dependent variable)
as a function of:

Inflation

Interest Rate

Exchange Rate

Unemployment rate

Key insights:

Inflation significantly affects GDP growth in developing nations

Exchange rate volatility negatively impacts GDP growth

Moderate interest rates support stable economic growth



