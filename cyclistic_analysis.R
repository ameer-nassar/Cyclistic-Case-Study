# Install required libraries
install.packages("tidyverse")
# Load libraries
library(tidyverse)
# Load datasets
Q1_2019 <- read.csv("Divvy_Trips_2019_Q1.csv")
Q2_2019 <- read.csv("Divvy_Trips_2019_Q2.csv")
Q3_2019 <- read.csv("Divvy_Trips_2019_Q3.csv")
Q4_2019 <- read.csv("Divvy_Trips_2019_Q4.csv")
Q1_2020 <- read.csv("Divvy_Trips_2020_Q1.csv")
# View the first few rows of Q1 2019
head(Q1_2019)
# Check the structure of Q1 2019
str(Q1_2019)
# Clean and transform the data
Q1_2019 <- Q1_2019 %>% 
  mutate(
    ride_length = as.numeric(difftime(end_time, start_time, units = "mins")),
    day_of_week = weekdays(as.Date(start_time))
  ) %>% 
  filter(ride_length > 0)
Q2_2019 <- Q2_2019 %>% 
  mutate(
    ride_length = as.numeric(difftime(end_time, start_time, units = "mins")),
    day_of_week = weekdays(as.Date(start_time))
  ) %>% 
  filter(ride_length > 0)
Q3_2019 <- Q3_2019 %>% 
  mutate(
    ride_length = as.numeric(difftime(end_time, start_time, units = "mins")),
    day_of_week = weekdays(as.Date(start_time))
  ) %>% 
  filter(ride_length > 0)
Q4_2019 <- Q4_2019 %>% 
  mutate(
    ride_length = as.numeric(difftime(end_time, start_time, units = "mins")),
    day_of_week = weekdays(as.Date(start_time))
  ) %>% 
  filter(ride_length > 0)
Q1_2020 <- Q1_2020 %>% 
  mutate(
    ride_length = as.numeric(difftime(end_time, start_time, units = "mins")),
    day_of_week = weekdays(as.Date(start_time))
  ) %>% 
  filter(ride_length > 0)
# Ensure trip_id is consistent across all datasets (convert to character)
Q1_2019 <- Q1_2019 %>% mutate(trip_id = as.character(trip_id))
Q2_2019 <- Q2_2019 %>% mutate(trip_id = as.character(trip_id))
Q3_2019 <- Q3_2019 %>% mutate(trip_id = as.character(trip_id))
Q4_2019 <- Q4_2019 %>% mutate(trip_id = as.character(trip_id))
Q1_2020 <- Q1_2020 %>% mutate(trip_id = as.character(trip_id))
# Ensure bikeid is consistent across all datasets (convert to character)
Q1_2019 <- Q1_2019 %>% mutate(bikeid = as.character(bikeid))
Q2_2019 <- Q2_2019 %>% mutate(bikeid = as.character(bikeid))
Q3_2019 <- Q3_2019 %>% mutate(bikeid = as.character(bikeid))
Q4_2019 <- Q4_2019 %>% mutate(bikeid = as.character(bikeid))
Q1_2020 <- Q1_2020 %>% mutate(bikeid = as.character(bikeid))
# Combine all datasets into one dataframe
all_data <- bind_rows(Q1_2019, Q2_2019, Q3_2019, Q4_2019, Q1_2020)
# View the first few rows of the combined dataset
head(all_data)
# Check the structure of the dataset
str(all_data)
# Save the combined dataset to a CSV file
write.csv(all_data, "Cleaned_Cyclistic_Data.csv", row.names = FALSE)
# Remove individual datasets if no longer needed
rm(Q1_2019, Q2_2019, Q3_2019, Q4_2019, Q1_2020)
# Free up memory
gc()  # Garbage collection to reclaim unused memory
# Had to retart R session after free up some memory and garbage collection due to RAM running high 
library(tidyverse)
all_data <- read.csv("Cleaned_Cyclistic_Data.csv")
# Summary statistics for ride_length by usertype
all_data %>%
  group_by(usertype) %>%
  summarise(
    mean_ride_length = mean(ride_length, na.rm = TRUE),
    median_ride_length = median(ride_length, na.rm = TRUE),
    max_ride_length = max(ride_length, na.rm = TRUE),
    min_ride_length = min(ride_length, na.rm = TRUE)
  )
# Total rides by day of the week and usertype
all_data %>%
  group_by(usertype, day_of_week) %>%
  summarise(total_rides = n()) %>%
  arrange(usertype, desc(total_rides))
# Average ride length by day of the week and usertype
all_data %>%
  group_by(usertype, day_of_week) %>%
  summarise(average_ride_length = mean(ride_length, na.rm = TRUE)) %>%
  arrange(usertype, day_of_week)
# Saving all the last three code runs as csv files 
summary_stats <- all_data %>%
  group_by(usertype) %>%
  summarise(
    mean_ride_length = mean(ride_length, na.rm = TRUE),
    median_ride_length = median(ride_length, na.rm = TRUE),
    max_ride_length = max(ride_length, na.rm = TRUE),
    min_ride_length = min(ride_length, na.rm = TRUE)
  )
write.csv(summary_stats, "Summary_Statistics.csv", row.names = FALSE)
total_rides <- all_data %>%
  group_by(usertype, day_of_week) %>%
  summarise(total_rides = n()) %>%
  arrange(usertype, desc(total_rides))
write.csv(total_rides, "Total_Rides_By_Day.csv", row.names = FALSE)
avg_ride_length <- all_data %>%
  group_by(usertype, day_of_week) %>%
  summarise(average_ride_length = mean(ride_length, na.rm = TRUE)) %>%
  arrange(usertype, day_of_week)
write.csv(avg_ride_length, "Average_Ride_Length_By_Day.csv", row.names = FALSE)
# Had to restart R due to RAM again, lets proceed to reload necessary libraries and datasets for visualizations
library(tidyverse)
summary_stats <- read.csv("Summary_Statistics.csv")
total_rides <- read.csv("Total_Rides_By_Day.csv")
avg_ride_length <- read.csv("Average_Ride_Length_By_Day.csv")
# Removed all data from memory due to RAM restrictions
rm(all_data)
gc()  # Garbage collection
# Make sure ggplot2 is loaded
library(ggplot2)
# Bar plot for total rides by day of the week
total_rides %>%
  ggplot(aes(x = day_of_week, y = total_rides, fill = usertype)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Total Rides by Day of the Week",
    x = "Day of the Week",
    y = "Total Rides",
    fill = "User Type"
  ) +
  theme_minimal()
ggsave("Total_Rides_By_Day.png", width = 10, height = 6)
# Line plot for average ride length by day of the week
avg_ride_length %>%
  ggplot(aes(x = day_of_week, y = average_ride_length, color = usertype, group = usertype)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Average Ride Length by Day of the Week",
    x = "Day of the Week",
    y = "Average Ride Length (minutes)",
    color = "User Type"
  ) +
  theme_minimal()
# Bar plot for total rides by user type
total_rides %>%
  group_by(usertype) %>%
  summarise(total_rides = sum(total_rides)) %>%
  ggplot(aes(x = usertype, y = total_rides, fill = usertype)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Total Rides by User Type",
    x = "User Type",
    y = "Total Rides",
    fill = "User Type"
  ) +
  theme_minimal()
# Bar plot for total rides by user type
total_rides %>%
  group_by(usertype) %>%
  summarise(total_rides = sum(total_rides)) %>%
  ggplot(aes(x = usertype, y = total_rides, fill = usertype)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Total Rides by User Type",
    x = "User Type",
    y = "Total Rides",
    fill = "User Type"
  ) +
  theme_minimal()
ggsave("Total_Rides_By_User_Type.png", width = 10, height = 6)
# Visuals came out a little funky (especially when exported) wrote new code to clean them up, unfortunately removed all_data so need to do one-by-one
# Reorder the days of the week in total_rides
total_rides$day_of_week <- factor(total_rides$day_of_week, levels = c("Sunday", "Monday", "Tuesday", "Wednesday", 
"Thursday", "Friday", "Saturday"))
# Reorder the days of the week in avg_ride_length
avg_ride_length$day_of_week <- factor(avg_ride_length$day_of_week, levels = c("Sunday", "Monday", "Tuesday", 
"Wednesday", "Thursday", "Friday", "Saturday"))
# Total ride plot update
total_rides %>%
  ggplot(aes(x = day_of_week, y = total_rides, fill = usertype)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Total Rides by Day of the Week",
    x = "Day of the Week",
    y = "Total Rides",
    fill = "User Type"
  ) +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "white", color = "white"),
    plot.background = element_rect(fill = "white", color = "white")
  ) +
  scale_y_continuous(labels = scales::label_comma())
# Average ride length update
avg_ride_length %>%
  ggplot(aes(x = day_of_week, y = average_ride_length, color = usertype, group = usertype)) +
  geom_line(linewidth = 1) +  # Fix the deprecation warning by using `linewidth`
  geom_point(size = 2) +
  labs(
    title = "Average Ride Length by Day of the Week",
    x = "Day of the Week",
    y = "Average Ride Length (minutes)",
    color = "User Type"
  ) +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "white", color = "white"),
    plot.background = element_rect(fill = "white", color = "white")
  ) +
  scale_y_continuous(labels = scales::label_comma())
# Total ride user type update
total_rides %>%
  group_by(usertype) %>%
  summarise(total_rides = sum(total_rides)) %>%
  ggplot(aes(x = usertype, y = total_rides, fill = usertype)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Total Rides by User Type",
    x = "User Type",
    y = "Total Rides",
    fill = "User Type"
  ) +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "white", color = "white"),
    plot.background = element_rect(fill = "white", color = "white")
  ) +
  scale_y_continuous(labels = scales::label_comma())
# Re saving the plots
ggsave("Total_Rides_By_Day_Cleaned.png", width = 10, height = 6)
ggsave("Average_Ride_Length_By_Day_Cleaned.png", width = 10, height = 6)
ggsave("Total_Rides_By_User_Type_Cleaned.png", width = 10, height = 6)
# Reorder the days of the week for both datasets
total_rides$day_of_week <- factor(total_rides$day_of_week, 
                                  levels = c("Sunday", "Monday", "Tuesday", 
                                             "Wednesday", "Thursday", "Friday", 
                                             "Saturday"))

avg_ride_length$day_of_week <- factor(avg_ride_length$day_of_week, 
                                      levels = c("Sunday", "Monday", "Tuesday", 
                                                 "Wednesday", "Thursday", "Friday", 
                                                 "Saturday"))
# reupdate some code for the charts
total_rides %>%
  ggplot(aes(x = day_of_week, y = total_rides, fill = usertype)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Total Rides by Day of the Week",
    x = "Day of the Week",
    y = "Total Rides",
    fill = "User Type"
  ) +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "white", color = "white"),
    plot.background = element_rect(fill = "white", color = "white")
  ) +
  scale_y_continuous(labels = scales::label_comma())
# reupdate some code for the charts 
avg_ride_length %>%
  ggplot(aes(x = day_of_week, y = average_ride_length, color = usertype, group = usertype)) +
  geom_line(linewidth = 1) +  # Use `linewidth` to fix warning
  geom_point(size = 2) +
  labs(
    title = "Average Ride Length by Day of the Week",
    x = "Day of the Week",
    y = "Average Ride Length (minutes)",
    color = "User Type"
  ) +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "white", color = "white"),
    plot.background = element_rect(fill = "white", color = "white")
  ) +
  scale_y_continuous(labels = scales::label_comma())
# reupdate some code for the charts
total_rides %>%
  group_by(usertype) %>%
  summarise(total_rides = sum(total_rides)) %>%
  ggplot(aes(x = usertype, y = total_rides, fill = usertype)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Total Rides by User Type",
    x = "User Type",
    y = "Total Rides",
    fill = "User Type"
  ) +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "white", color = "white"),
    plot.background = element_rect(fill = "white", color = "white")
  ) +
  scale_y_continuous(labels = scales::label_comma())
# saving the plots as PNGs again so I can export
ggsave("Total_Rides_By_Day_Final.png", width = 10, height = 6)
ggsave("Average_Ride_Length_By_Day_Final.png", width = 10, height = 6)
ggsave("Total_Rides_By_User_Type_Final.png", width = 10, height = 6)
