This Project is an analysis of crime in the state of Georgia for the year 2024. The data was sourced from the FBI's National Incident-Based Reporting System (NIBRS). Source data is open and can be downloaded at https://cde.ucr.cjis.gov/LATEST/webapp/#/pages/downloads. Only data relevant to the stated objectives of the project was utilized.

---

### Analytical Objectives:

This analysis aims to answer the following questions:

- What offenses were most common across all counties in Georgia in 2024?
- Which month of the 2024 calendar year saw the most reported incidences across the state?
- For arrests made in 2024, which offense led to the most arrests across the state, and what was the racial breakdown of those arrests?
- Were men arrested more frequently than women?

---

### Project Structure/Methodology:

The Analysis utilized a locally hosted PostgreSQL database for data storage and manipulation. A schema containing table definitions as well as Primary/Foreign key constraints was composed. After the schema was created, the tables were populated with data (found in data/) using the psql CLI. Several scripts utilizing CTEs, window functions, aggregate functions, and JOINs were then used to isolate the desired data into table views. The needed table views (or original tables) were exported to tabular data files (in viz_data/) to be added to Tableau for visualization.

##### File Structure:

crime_analysis
|-- data/    <---- Tabular data downloaded from NIBRS site
|-- sql/     <---- SQL scripts creating db schema, views, and data exports
|-- visualizations/    <---- Tableau workbook file containing final visualizations
|-- viz_data/    <---- Stores exported tabular data to be imported to Tableau
|-- nibrs_diagram.pdf    <---- Bird's eye diagram highlighting the topography of all data in the original download (included by source)

## Visualizations and Findings:

DISCLAIMER: NOT ALL COUNTIES SUBMITTED INCIDENT REPORTS TO NIBRS. OF 159 COUNTIES IN THE STATE, 147 PROVIDED DATA FOR THE YEAR OF 2024. NON-PARTICIPANT COUNTIES WERE LEFT IN GREY.

##### Most common offense per county:
<img width="888" height="599" alt="image" src="https://github.com/user-attachments/assets/97043122-ad74-4a5e-a260-286193411c90" />

Geographical mapping of offense counts by total indicates "Simple Assault" (Purple) as being the most common offense perpetrated across all counties, followed by "Drug/Narcotic Violations" (yellow), and "All Other Larceny" (light blue).

##### Largest Reporting Month for 2024:
<img width="563" height="607" alt="image" src="https://github.com/user-attachments/assets/ddd9e983-1f2f-46e5-b080-07ab1180e0c3" />

The highest number of reported incidents happened during the Month of May, closely followed by January. After a high-incident January, reports fall by roughly 2,000 in February, and pick back up until the peak in May. After the high in May, the number of incidents reported tapers-off for the second-half of the year, with the most substantial decrease being between October and November.

##### Arrests by Race and Offense:
<img width="877" height="605" alt="image" src="https://github.com/user-attachments/assets/385401e6-1221-4f4b-a948-8903d666fcac" />

this chart displays arrests made per offense, and gives a racial breakdown of those arrests. Bars are in descending order from left to right in terms of total arrests. Additionally, each crime is color-coded to show the proportion of arrests made per race for that particular offense in descending order, with the most frequently arrested race on top. We can see that the Black/African American group was arrested most frequently across the board, followed by Whites. The largest number of arrests were made for "Drug/Narcotic Violations", followed by "Simple Assault" and "Shoplifting".

##### Arrests by Gender:
<img width="327" height="600" alt="image" src="https://github.com/user-attachments/assets/28af7f79-4437-4b73-86fc-bc0dfa5986f5" />

As far as race is concerned, men constituted the vast majority of arrestees, making up a little over 71% of all cases. Women, on the other hand made up a little under 30% of arrestees.
