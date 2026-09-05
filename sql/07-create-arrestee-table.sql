-- define the NIBRS_ARRESTEE table
create table nibrs_arrestee (
	data_year int,
	arrestee_id bigint not null,
	incident_id bigint not null,
	arrestee_seq_num smallint,
	arrest_date timestamp without time zone,
	arrest_type_id int,
	multiple_indicator char(1),
	offense_code varchar(5) not null,
	age_id smallint not null,
	age_num smallint,
	sex_code char(1),
	race_id smallint not null,
	ethnicity_id smallint,
	resident_code char(1),
	under_18_disposition_code char(1),
	clearance_ind char(1),
	age_range_low_num smallint,
	age_range_high_num smallint
);
-- pk
alter table only public.nibrs_arrestee add constraint nibrs_arrestee_id_pk primary key (arrestee_id);
-- fk
alter table only public.nibrs_arrestee add constraint nibrs_arrestee_incident_fk foreign key (incident_id)
	references public.nibrs_incident (incident_id);
alter table only public.nibrs_arrestee add constraint nibrs_arrestee_race_fk foreign key (race_id)
	references public.ref_race (race_id);
alter table only public.nibrs_arrestee add constraint nibrs_arrestee_ethnicity_fk foreign key (ethnicity_id)
	references public.nibrs_ethnicity (ethnicity_id);
alter table only public.nibrs_arrestee add constraint nibrs_arrestee_age_fk foreign key (age_id)
	references public.nibrs_age (age_id);
alter table only public.nibrs_arrestee add constraint nibrs_arrestee_offense_type_fk foreign key (offense_code)
	references public.nibrs_offense_type (offense_code);