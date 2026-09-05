-- aggregate the arrests by race and offense.
create or replace view arrests_per_race as
with arrestee_race as (
	select r.race_desc, a.offense_code
	from nibrs_arrestee a
	left join ref_race r
	on a.race_id = r.race_id
),
arrestee_offense as (
	select r.race_desc, o.offense_name
	from arrestee_race r
	left join nibrs_offense_type o
	on r.offense_code = o.offense_code
)
select race_desc, offense_name, count(*) as offense_count
from arrestee_offense
group by race_desc, offense_name
order by race_desc, offense_count desc;