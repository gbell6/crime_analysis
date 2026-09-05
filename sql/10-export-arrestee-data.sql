-- export the data in the arrests_per_race view
\copy (select * from arrests_per_race) to 'viz_data/race_offense_arrests.csv' with (format csv, header)