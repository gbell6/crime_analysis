-- This file is used to setup the database tables and load the NIBRS
-- code lookup tables. It only needs to be run once before you load
-- any data tables using 02-load-tables.sql
begin;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


CREATE TABLE public.nibrs_location_type (                       
    location_id bigint NOT NULL,
    location_code character(2),
    location_name character varying(100)
);

CREATE TABLE public.nibrs_offense_type (                            
    offense_code character varying(5) NOT NULL,
    offense_name character varying(100),
    crime_against character varying(100),
    ct_flag character(1),
    hc_flag character(1),
    hc_code character varying(5),
    offense_category_name character varying(100),
    offense_group character(5)
);

CREATE TABLE public.nibrs_criminal_act (                           
    data_year int,
    criminal_act_id smallint NOT NULL,
    offense_id bigint NOT NULL
);

CREATE TABLE public.nibrs_criminal_act_type (                    
    criminal_act_id smallint NOT NULL,
    criminal_act_code character(1),
    criminal_act_name character varying(100),
    criminal_act_desc character varying(300)

);

CREATE TABLE public.nibrs_ethnicity (                      
    ethnicity_id smallint NOT NULL,
    ethnicity_code character(1),
    ethnicity_name character varying(100)
);

CREATE TABLE public.ref_race (             
	race_id smallint NOT NULL,
	race_code character varying(2) NOT NULL,
	race_desc character varying(100) NOT NULL,
	sort_order smallint,
	start_year smallint,
	end_year smallint,
	notes character varying(1000)
);

CREATE TABLE public.nibrs_age (
	age_id smallint NOT NULL,
	age_code character(2),
	age_name character varying(100)
);

CREATE TABLE public.nibrs_month (
	data_year int,
	nibrs_month_id bigint NOT NULL,
	agency_id bigint NOT NULL,
	month_num smallint NOT NULL,
	inc_data_year int,
	reported_status character varying(10),
	report_date timestamp without time zone,
	update_flag character(1) DEFAULT NULL,
	orig_format character(1) NOT NULL,
	data_home character varying(10),
	ddocname character varying(50),
	did bigint,
	month_pub_status int
);

COMMENT ON COLUMN nibrs_month.orig_format IS 'This is the format the report was in when it was first submitted to the system.  F for Flat File, W for Web Form, U for IEPDXML Upload, S for IEPDXML Service, B for BPEL, N for null or unavailable, and M for Multiple. When summarizing NIBRS data into the _month tables, a single months data could come from multiple sources.  If so the entry will be M';

CREATE TABLE public.agencies (
    yearly_agency_id integer,
    agency_id bigint,
    data_year integer,
    ori character varying(25),
    legacy_ori character varying(25),
    covered_by_legacy_ori character varying(25),
    direct_contributor_flag character varying(1),
    dormant_flag character varying(1),
    dormant_year integer,
    reporting_type character varying(1),
    ucr_agency_name character varying(100),
    ncic_agency_name character varying(100),
    pub_agency_name character varying(100),
    pub_agency_unit character varying(100),
    agency_status character varying(1),
    state_id integer,
    state_name character varying(100),
    state_abbr character varying(2),
    state_postal_abbr character varying(2),
    division_code integer,
    division_name character varying(100),
    region_code integer,
    region_name character varying(100),
    region_desc character varying(100),
    agency_type_name character varying(100),
    population integer,
    submitting_agency_id integer,
    sai character varying(25),
    submitting_agency_name character varying(200),
    suburban_area_flag character varying(1),
    population_group_id integer,
    population_group_code character varying(2),
    population_group_desc character varying(100),
    parent_pop_group_code integer,
    parent_pop_group_desc character varying(100),
    mip_flag character varying(1),
    pop_sort_order integer,
    summary_rape_def character varying(1),
    pe_reported_flag character varying(1),
    male_officer integer,
    male_civilian integer,
    male_total integer,
    female_officer integer,
    female_civilian integer,
    female_total integer,
    officer_rate decimal,
    employee_rate decimal,
    nibrs_cert_date date,
    nibrs_start_date date,
    nibrs_leoka_start_date date,
    nibrs_ct_start_date date,
    nibrs_multi_bias_start_date date,
    nibrs_off_eth_start_date date,
    covered_flag character varying(1),
    county_name character varying(100),
    msa_name character varying(100),
    publishable_flag character varying(1),
    participated character varying(1),
    nibrs_participated character varying(1)
);

--
-- Main NIBRS tables
--

CREATE TABLE public.nibrs_incident (                     
	data_year int,
	agency_id bigint NOT NULL,
    incident_id bigint NOT NULL,
    nibrs_month_id bigint NOT NULL,
    cargo_theft_flag character(1),
    submission_date timestamp without time zone,
    incident_date timestamp without time zone,
    report_date_flag character(1),
    incident_hour smallint,
    cleared_except_id smallint NOT NULL,
    cleared_except_date timestamp without time zone,
    incident_status character varying(100), --smallint,
    data_home character(1),
    orig_format character(1),
    did bigint
);

COMMENT ON COLUMN nibrs_incident.orig_format IS 'This is the format the report was in when it was first submitted to the system.  F for Flat File, W for Web Form, U for IEPDXML Upload, S for IEPDXML Service, B for BPEL, N for null or unavailable.';


CREATE TABLE public.nibrs_offender (                     
	data_year int,
	offender_id bigint NOT NULL,
	incident_id bigint NOT NULL,
	offender_seq_num smallint,
	age_id smallint,
	age_num character(3),
	sex_code character(1),
	race_id smallint,
	ethnicity_id smallint,
	age_range_low_num smallint,
	age_range_high_num smallint
);

CREATE TABLE public.nibrs_offense (                     
	data_year int,
	offense_id bigint NOT NULL,
	incident_id bigint NOT NULL,
	offense_code character varying(5) NOT NULL,
	attempt_complete_flag character(1),
	location_id bigint NOT NULL,
	num_premises_entered smallint,
	method_entry_code character(1)
);

--Create PKs and FKs
--PKS

  ALTER TABLE only PUBLIC.NIBRS_ETHNICITY ADD CONSTRAINT NIBRS_ETH_PK PRIMARY KEY (ETHNICITY_ID);

  ALTER TABLE only PUBLIC.NIBRS_CRIMINAL_ACT ADD CONSTRAINT NIBRS_CRIMINAL_ACT_PK PRIMARY KEY (CRIMINAL_ACT_ID, OFFENSE_ID);

  ALTER table only PUBLIC.NIBRS_OFFENSE_TYPE ADD CONSTRAINT NIBRS_OFFENSE_TYPE_PK PRIMARY KEY (offense_code);

  ALTER TABLE only PUBLIC.NIBRS_CRIMINAL_ACT_TYPE ADD CONSTRAINT NIBRS_CRIMINAL_ACT_TYPE_PK PRIMARY KEY (CRIMINAL_ACT_ID);

  ALTER TABLE only PUBLIC.NIBRS_INCIDENT ADD CONSTRAINT NIBRS_INCIDENT_PK PRIMARY KEY (INCIDENT_ID);

  ALTER TABLE only PUBLIC.NIBRS_OFFENDER ADD CONSTRAINT NIBRS_OFFENDER_PK PRIMARY KEY (OFFENDER_ID);

  ALTER TABLE only PUBLIC.NIBRS_OFFENSE ADD CONSTRAINT NIBRS_OFFENSE_PK PRIMARY KEY (OFFENSE_ID);

  ALTER TABLE only PUBLIC.NIBRS_LOCATION_TYPE ADD CONSTRAINT NIBRS_LOCATION_TYPE_PK PRIMARY KEY (LOCATION_ID);

  ALTER TABLE only PUBLIC.REF_RACE ADD CONSTRAINT REF_RACE_PK PRIMARY KEY (RACE_ID);
  
  alter table only public.nibrs_month add constraint nibrs_month_pk primary key (did);
  
  alter table only public.nibrs_age add constraint nibrs_age_pk primary key (age_id);
  
  alter table only public.agencies add constraint agencies_pk primary key (agency_id);
  
-- ADD FKs
  
alter table only public.nibrs_criminal_act add constraint nibrs_criminal_act_type_fk foreign key (criminal_act_id)
  references public.nibrs_criminal_act_type (criminal_act_id);

alter table only public.nibrs_criminal_act add constraint nibrs_offense_id_fk foreign key (offense_id)
  references public.nibrs_offense (offense_id);

alter table only public.nibrs_incident add constraint nibrs_incident_month_id_fk foreign key (did)
  references public.nibrs_month (did);

alter table only public.nibrs_offender add constraint nibrs_offender_incident_id_fk foreign key (incident_id)
  references public.nibrs_incident (incident_id) on delete cascade;

alter table only public.nibrs_offender add constraint nibrs_offender_age_id_fk foreign key (age_id)
  references public.nibrs_age (age_id);

alter table only public.nibrs_offender add constraint nibrs_offender_race_id_fk foreign key (race_id)
  references public.ref_race (race_id);

alter table only public.nibrs_offender add constraint nibrs_offender_ethnicity_id_fk foreign key (ethnicity_id)
  references public.nibrs_ethnicity (ethnicity_id);

alter table only public.nibrs_offense add constraint nibrs_offense_incident_id_fk foreign key (incident_id)
  references public.nibrs_incident (incident_id) on delete cascade;

alter table only public.nibrs_offense add constraint nibrs_offense_location_id_fk foreign key (location_id)
  references public.nibrs_location_type (location_id);

alter table only public.nibrs_offense add constraint nibrs_offense_off_code_fk foreign key (offense_code)
  references public.nibrs_offense_type (offense_code);

alter table only public.nibrs_incident add constraint nibrs_incident_agency_id_fk foreign key (agency_id) 
  references public.agencies (agency_id);

alter table only public.nibrs_month add constraint nibrs_month_agency_id_fk foreign key (agency_id)
  references public.agencies (agency_id);

commit;