# Cyclistic Case Study - Analyzing 2019-2020 Bike Share Data

## Project Overview
This project is part of the Google Data Analytics Capstone, analyzing bike share data for the fictional company **Cyclistic**. The goal is to understand ride patterns across **casual riders** and **annual members** to support Cyclistic's marketing strategies.

## Files in This Repository

| File | Description |
|---|---|
| `Cyclistic_Case_Study.R` | Full R script used for data cleaning, analysis, and visualization. |
| `Cleaned_Cyclistic_Data.csv` | Combined and cleaned dataset used in the analysis. |
| `Summary_Statistics.csv` | Summary stats for ride lengths by user type. |
| `Total_Rides_By_Day.csv` | Total ride counts by day of the week and user type. |
| `Average_Ride_Length_By_Day.csv` | Average ride length by day of the week and user type. |
| `Total_Rides_By_Day_Final.png` | Final visualization: Total rides by day of the week. |
| `Average_Ride_Length_By_Day_Final.png` | Final visualization: Average ride length by day of the week. |
| `Total_Rides_By_User_Type_Final.png` | Final visualization: Total rides by user type. |

## Tools Used
- **R** (tidyverse, ggplot2)
- **RStudio**
- **CSV Files for data storage and analysis**

## Process
### 1. Data Loading
- Loaded quarterly Divvy trip datasets from 2019 and Q1 2020.
- Combined all datasets into a single master dataset.

### 2. Data Cleaning
- Converted timestamps to date objects.
- Calculated **ride length** for each trip.
- Filtered out invalid trips (negative durations).

### 3. Exploratory Data Analysis (EDA)
- Analyzed ride counts by user type and day of the week.
- Compared average ride lengths across user types and days.
- Identified seasonal patterns and membership trends.

### 4. Visualizations
- **Bar Chart:** Total rides by day of the week.
- **Line Chart:** Average ride length by day.
- **Bar Chart:** Total rides by user type.
- Visuals exported to PNG for easy sharing.

## Key Insights
- **Casual riders** ride more on weekends.
- **Annual members** ride more on weekdays.
- Casual riders take longer rides on average, indicating more leisure activity.
- Membership marketing could target casual riders who ride often but haven’t subscribed yet.

## Conclusion
The analysis supports targeted marketing strategies focused on converting high-frequency casual riders into members and ensuring bike availability during peak hours (weekends for casual riders, weekdays for members).

---

### Related Links
- [Original Divvy Data Source](https://divvybikes.com/system-data)
- [Google Data Analytics Capstone](https://www.coursera.org/professional-certificates/google-data-analytics)

---

## Data Disclaimer
This dataset is for educational purposes and may not fully reflect real-world operations.

