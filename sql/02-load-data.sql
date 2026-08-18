-- Load the data in the relevant csv files into the tables we created in 01_create_tables.sql
\set ON_ERROR_STOP on;
\copy agencies from 'agencies.csv' with (delimiter ',', format csv, header true);
\copy nibrs_month from 'nibrs_month.csv' with (delimiter ',', format csv, header true);
\copy nibrs_incident from 'nibrs_incident.csv' with (delimiter ',', format csv, header true);
\copy nibrs_ethnicity from 'nibrs_ethnicity.csv' with (delimiter ',', format csv, header true);
\copy ref_race from 'ref_race.csv' with (delimiter ',', format csv, header true);
\copy nibrs_age from 'nibrs_age.csv' with (delimiter ',', format csv, header true);
\copy nibrs_location_type from 'nibrs_location_type.csv' with (delimiter ',', format csv, header true);
\copy nibrs_offense_type from 'nibrs_offense_type.csv' with (delimiter ',', format csv, header true);
\copy nibrs_offender from 'nibrs_offender.csv' with (delimiter ',', format csv, header true);
\copy nibrs_criminal_act_type from 'nibrs_criminal_act_type.csv' with (delimiter ',', format csv, header true);
\copy nibrs_offense from 'nibrs_offense.csv' with (delimiter ',', format csv, header true);
\copy nibrs_criminal_act from 'nibrs_criminal_act.csv' with (delimiter ',', format csv, header true);