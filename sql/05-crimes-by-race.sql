-- Build view breaking down what race commits which crimes
create or replace view crimes_by_race as
with offense_offender as(
	select n_perp.race_id, n_off.offense_code
	from nibrs_offense as n_off
	inner join nibrs_offender as n_perp
	on n_perp.incident_id = n_off.incident_id
),
offense_desc as(
	select race_id, o_t.offense_name
	from offense_offender as o_o
	left join nibrs_offense_type as o_t
	on o_o.offense_code = o_t.offense_code
)
select r.race_desc, o.offense_name, count(o.offense_name)
from offense_desc o
left join ref_race r
on o.race_id = r.race_id
group by r.race_desc, o.offense_name
order by r.race_desc, count(o.offense_name) desc;
