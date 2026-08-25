-- Find out how many crimes each gender committed.
select
	count(*) filter (where sex_code = 'M') as male_offenders,
	count(*) filter (where sex_code = 'F') as female_offenders,
	count(*) filter (where sex_code != 'F' and sex_code != 'M') as unknown_gender
from nibrs_offender;
