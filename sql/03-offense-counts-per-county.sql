-- Create a view containing the top 5 most common crimes in each county
create view county_common_crimes as
-- Chain CTEs to derive the most frequent crimes in each county
-- join nibrs_offense -> nibrs_offense_type
with offense_type_join AS(
	select o.offense_id, o.incident_id, o_t.offense_name
	from nibrs_offense as o
	left join nibrs_offense_type as o_t
		on o.offense_code = o_t.offense_code
),
-- join nibrs_incident -> offense_type_join (the above CTE)
incident_offense_join as(
	select i.agency_id, o_t.offense_id, o_t.offense_name
	from nibrs_incident as i
	right join offense_type_join as o_t
		on i.incident_id = o_t.incident_id 
),
-- join agencies -> incident_offense_join (the above CTE)
county_offense_count as(
	select a.county_name, i_o.offense_name, count(i_o.offense_name) as offense_count
	from agencies as a
	right join incident_offense_join as i_o
		on a.agency_id = i_o.agency_id
	group by a.county_name, i_o.offense_name
	order by a.county_name, offense_count desc
),
-- add column to county_offense_count with a window function containing the ranking of each crime within the county
offense_ranks as(
	select *,
		row_number() over(
			partition by county_name
			order by offense_count desc
		) as offense_rank
	from county_offense_count
)
-- filter offense_ranks so that only the 5 most frequent crimes are returned for each county.
select *
from offense_ranks
where offense_rank <=5;
