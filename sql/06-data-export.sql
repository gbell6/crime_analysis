-- Create client-side export of data to be visualized since Tableau Public cannot connect to local db servers
\copy (select * from county_common_crimes) to 'viz_data/county_common_crimes.csv' with (format csv, header)
\copy (select * from crimes_by_race) to 'viz_data/crimes_by_race.csv' with (format csv, header)
\copy nibrs_month to 'viz_data/month.csv' with (format csv, header)
\copy nibrs_offender to 'viz_data/offender.csv' with (format csv, header)
-- Execute via psql cli with "\i sql/06-data-export.sql"