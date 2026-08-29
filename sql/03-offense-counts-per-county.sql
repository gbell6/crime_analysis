-- Create a view containing the top 5 most common crimes in each county
create view county_common_crimes as
-- Chain CTEs to derive the most frequent crimes in each county
with offense_type_join AS(
	select
		o.offense_id,
		o.incident_id,
		o_t.offense_name
	from nibrs_offense as o
	left join nibrs_offense_type as o_t
		on o.offense_code = o_t.offense_code
),

incident_offense_join as(
	select
		i.agency_id,
		o_t.offense_id,
		o_t.offense_name
	from nibrs_incident as i
	right join offense_type_join as o_t
		on i.incident_id = o_t.incident_id 
),
-- many of the rows in county_name column are comma-separated lists of multiple county names.
-- expand_counties uses string_to_table() to expand those lists into their own distinct rows, while preserving the 
-- offense_name value that matched the original row
expand_counties as(
	select
		c.county_name,
		i_o.offense_name
	from agencies as a
	right join incident_offense_join as i_o
		on a.agency_id = i_o.agency_id
	cross join lateral string_to_table(a.county_name, ', ') as c(county_name)
),

county_offense_count as(
	select
		e_c.county_name,
		e_c.offense_name,
		count(e_c.offense_name) as offense_count
	from expand_counties as e_c
	group by e_c.county_name, e_c.offense_name
	order by e_c.county_name, offense_count desc
),

offense_ranks as(
	select
		*,
		row_number() over(
			partition by county_name
			order by offense_count desc
		) as offense_rank
	from county_offense_count
)

select *
from offense_ranks
where offense_rank <=5;
