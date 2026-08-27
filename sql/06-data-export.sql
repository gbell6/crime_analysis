-- Create client-side export of data to be visualized since Tableau Public cannot connect to local db servers
\copy county_common_crimes to '../viz\ data/' with (format csv, header, delimiter ',')
\copy crimes_by_race to '../viz\ data/' with (format csv, header, delimiter ',')
\copy nibrs_month to '../viz\ data/' with (format csv, header, delimiter ',')
\copy nibrs_offender to '../viz\ data/' with (format csv, header, delimiter ',')
-- Execute via psql cli with "psql -d portfolio_proj -f 'sql/06-data-export.sql'"