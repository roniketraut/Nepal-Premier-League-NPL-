# Nepal-Premier-League-NPL-
Welcome to the Nepal Premier League (NPL) Analytics Project, a comprehensive data analytics initiative that extracts the cricket data from API in Jupyter Notebook to provide valuable insights using SQL and Power BI. Just so you know, NPL is a T20 domestic cricket league which just started on 30th Nov, 2024 and edned on 21 Dec, 2024

Project Overview

This project is a data analysis case study that focuses on the Nepal Premier League cricket tournament. The primary objective is to extract, transform, and analyze cricket data to derive actionable insights and showcase expertise in data analytics, including database management and visualization.

Python (https://github.com/roniketraut/Nepal-Premier-League-NPL-/blob/main/NPL%20preprocessing.ipynb)

Data Extraction and transformation 

   API Integration: Extracted cricket data from an external API.
   
   Handling Nested JSONs: Parsed and transformed complex nested JSON structures into tabular formats for database insertion.

SQL (https://github.com/roniketraut/Nepal-Premier-League-NPL-/blob/main/npl%20table%20creation.sql, https://github.com/roniketraut/Nepal-Premier-League-NPL-/blob/main/npl%20table%20creation.sql, https://github.com/roniketraut/Nepal-Premier-League-NPL-/blob/main/npl%20queries.sql)

Database Type: PostgreSQL

Tables Included: teams, players, match_sum, batting and bowling.

Schema Design: Optimized for querying and analysis.

Queries on SQL inlcudes window functions, views, CTEs, subqueries and other complex joins.

The queries aim to extract the following insights:
   Player Performance: Analyze batting and bowling statistics to identify top-performing players.
   Team Analysis: Examine team performance trends across matches.
   Match Insights: Identify high-scoring matches, key contributors, and game-changing moments.

Power BI (https://github.com/roniketraut/Nepal-Premier-League-NPL-/blob/main/NPL%20preprocessing.ipynb)

Data importation through Postgres database.

Data cleaning in Power Query Editor(splitting columns via delimeters, creating custom columns, find and replace, data type check, conversion into numeric for binary 
 columns, etc.)
 
DAX: Measures and Calcualted columns

Dashboard and report design and creation:
  Idedntified the best players in every positon
  Created the best 11 for the ultimate team
  Presented key torunament and team statistics 

For example, 

The data looking like the below 

![image](https://github.com/user-attachments/assets/88d03729-c993-43c0-803c-a4ce28dcf4d2)

was converted to 

<img src="https://github.com/user-attachments/assets/d6d22ac8-3587-4b80-aa2b-2c4d7ca7af76" alt="Dashboard Preview" width="600" height="400">


The below measures were created using DAX.

<img src="https://github.com/user-attachments/assets/e158bf9c-41eb-4998-8fbb-e9d413259345" alt="Dashboard Preview" width="400" height="600">


The best players in every position was chosen like below:

![image](https://github.com/user-attachments/assets/688a7c58-5ed3-417c-8b3a-59f91c78ef71)

In the above, players in each position can be easily be seen by clicking on the buttons as well.

The torunament status that can be filtered by teams was created as below:

![image](https://github.com/user-attachments/assets/dbdba08a-77ba-4956-88e3-6cbe5e3019c4)


PL-Analytics-Project/
|-- SQL/
|   |-- npl table creation.sql    # SQL script for database schema
|   |-- npl data insertion and cleaning.sql      # SQL script to populate tables
|   |-- npl queries.sql          # Custom queries for insights
|
|-- PowerBI/
|   |-- NPL EXP.pbix   # Power BI report file
|
|-- Python/
|   |-- NPL preprocessing.ipynb    # Script for API data extraction
|
|-- README.md                # Project documentation


