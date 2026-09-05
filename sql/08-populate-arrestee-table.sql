-- populate arrestee table
\copy nibrs_arrestee from 'nibrs_arrestee.csv' with (delimiter ',', format csv, header true);
-- executed from terminal via psql