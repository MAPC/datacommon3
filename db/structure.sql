--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: gisdata; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA gisdata;


--
-- Name: mapc; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA mapc;


--
-- Name: metadata; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA metadata;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = metadata, pg_catalog;

--
-- Name: populate_metadata_tables(); Type: FUNCTION; Schema: metadata; Owner: -
--

CREATE FUNCTION populate_metadata_tables() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    my_row    RECORD;
    my_metadata text;
    insertquery text;
BEGIN   

    
    FOR my_row IN 
        SELECT table_name
        FROM   information_schema.tables
        WHERE  table_schema = 'metadata'
        AND table_name <>'_public_tables'
        AND table_name <>'_metadata_view'
    LOOP
    my_metadata = my_row.table_name;
    insertquery:= ' INSERT INTO metadata._public_tables(name) VALUES (''' || my_metadata ||''')';

    --RAISE NOTICE ' INSERT INTO metadata._tables(name) VALUES %',  my_metadata;
    
    EXECUTE insertquery;
    END LOOP;
END;
$$;


--
-- Name: populate_metadata_view(); Type: FUNCTION; Schema: metadata; Owner: -
--

CREATE FUNCTION populate_metadata_view() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    my_row    RECORD;
    my_metadata text;
    insertquery text;
BEGIN   

    
    FOR my_row IN 
        SELECT table_name
        FROM   information_schema.tables
        WHERE  table_schema = 'metadata'
        AND table_name <>'_tables' AND table_name <>'_metadata_view'

    LOOP
    my_metadata = my_row.table_name;
    insertquery:= ' CREATE OR REPLACE VIEW metadata._metadata_view AS SELECT name,alias
		FROM   metadata.' || my_metadata ||'
		WHERE  orderid < 16
--INSERT INTO metadata._tables(name) VALUES (''' || my_metadata ||''')';

    --RAISE NOTICE ' INSERT INTO metadata._tables(name) VALUES %',  my_metadata;
    
    EXECUTE insertquery;
    END LOOP;
END;
$$;


--
-- Name: update_id(); Type: FUNCTION; Schema: metadata; Owner: -
--

CREATE FUNCTION update_id() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    my_row    RECORD;
    my_metadata text;
    updatequery text;
BEGIN   

    
    FOR my_row IN 
        SELECT table_name
        FROM   information_schema.tables
        WHERE  table_schema = 'metadata'
        AND table_name <>'_tables' AND table_name <>'_metadata_view'

    LOOP
    my_metadata = my_row.table_name;
    updatequery:= 'UPDATE  metadata.' || my_metadata ||' set name = ''join_key'' where name = ''id'' ';
    --RAISE NOTICE ' INSERT INTO metadata._tables(name) VALUES %',  my_metadata;
    --RAISE NOTICE 'UPDATE  metadata.% set name = ''join_key'' where name = ''id'' ', my_metadata;

    EXECUTE updatequery;
    END LOOP;
END;
$$;


SET search_path = gisdata, pg_catalog;

--
-- Name: ma_municipal_gid_seq; Type: SEQUENCE; Schema: gisdata; Owner: -
--

CREATE SEQUENCE ma_municipal_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET search_path = mapc, pg_catalog;

--
-- Name: health_births_m_seq; Type: SEQUENCE; Schema: mapc; Owner: -
--

CREATE SEQUENCE health_births_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: health_births_m; Type: TABLE; Schema: mapc; Owner: -; Tablespace: 
--

CREATE TABLE health_births_m (
    seq_id integer DEFAULT nextval('health_births_m_seq'::regclass) NOT NULL,
    muni_id smallint,
    municipal text,
    years integer,
    births_num integer
);


SET search_path = metadata, pg_catalog;

--
-- Name: _geo_extents; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE _geo_extents (
    id integer NOT NULL,
    title text,
    createdate date,
    moddate date,
    publisher text,
    contributr text,
    coverage text,
    universe text,
    schema text,
    tablename text,
    join_key text,
    table_suffix text,
    key_desc text,
    key_name text
);


--
-- Name: _geo_extents_geo_layers_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE _geo_extents_geo_layers_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _geo_extents_geo_layers; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE _geo_extents_geo_layers (
    id integer DEFAULT nextval('_geo_extents_geo_layers_seq'::regclass) NOT NULL,
    geo_layer_id integer,
    geo_extent_id integer,
    geo_layer_key text,
    geo_extent_key text
);


--
-- Name: _geo_extents_id_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE _geo_extents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _geo_extents_id_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: -
--

ALTER SEQUENCE _geo_extents_id_seq OWNED BY _geo_extents.id;


--
-- Name: _geo_layers; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE _geo_layers (
    id integer NOT NULL,
    title text,
    alt_title text,
    descriptn text,
    topic text,
    category text,
    creator text,
    createdate date,
    moddate date,
    publisher text,
    contributr text,
    coverage text,
    universe text,
    schema text,
    tablename text,
    tablenum text,
    institution_id integer,
    datesavail text
);


--
-- Name: _geo_layers_id_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE _geo_layers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _geo_layers_id_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: -
--

ALTER SEQUENCE _geo_layers_id_seq OWNED BY _geo_layers.id;


--
-- Name: _public_tables_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE _public_tables_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _public_tables; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE _public_tables (
    seq_id integer DEFAULT nextval('_public_tables_seq'::regclass) NOT NULL,
    name character varying(150)
);


--
-- Name: _tables_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE _tables_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b01002_med_age_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b01002_med_age_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b01002_med_age_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b01002_med_age_acs_bg (
    orderid integer DEFAULT nextval('b01002_med_age_bg_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b01002_med_age_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b01002_med_age_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b01002_med_age_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b01002_med_age_acs_ct (
    orderid integer DEFAULT nextval('b01002_med_age_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b01002_med_age_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b01002_med_age_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b01002_med_age_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b01002_med_age_acs_m (
    orderid integer DEFAULT nextval('b01002_med_age_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b05002_citizenship_nativity_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b05002_citizenship_nativity_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b05002_citizenship_nativity_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b05002_citizenship_nativity_acs_ct (
    orderid integer DEFAULT nextval('b05002_citizenship_nativity_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b05002_citizenship_nativity_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b05002_citizenship_nativity_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b05002_citizenship_nativity_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b05002_citizenship_nativity_acs_m (
    orderid integer DEFAULT nextval('b05002_citizenship_nativity_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b05002_citizenship_nativity_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b05002_citizenship_nativity_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b05003_nativity_by_age_gender_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b05003_nativity_by_age_gender_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b05003_citizenship_nativity_by_age_gender_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b05003_citizenship_nativity_by_age_gender_acs_ct (
    orderid integer DEFAULT nextval('b05003_nativity_by_age_gender_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b05003_nativity_by_age_gender_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b05003_nativity_by_age_gender_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b05003_citizenship_nativity_by_age_gender_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b05003_citizenship_nativity_by_age_gender_acs_m (
    orderid integer DEFAULT nextval('b05003_nativity_by_age_gender_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b05003_citizenship_nativity_by_age_gender_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b05003_citizenship_nativity_by_age_gender_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b05003_citizenship_nativity_by_age_gender_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b05003_citizenship_nativity_by_age_gender_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b06009_educational_attainment_by_placeofbirth_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b06009_educational_attainment_by_placeofbirth_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b06009_educational_attainment_by_placeofbirth_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b06009_educational_attainment_by_placeofbirth_acs_ct (
    orderid integer DEFAULT nextval('b06009_educational_attainment_by_placeofbirth_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b06009_educational_attainment_by_placeofbirth_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b06009_educational_attainment_by_placeofbirth_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b06009_educational_attainment_by_placeofbirth_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b06009_educational_attainment_by_placeofbirth_acs_m (
    orderid integer DEFAULT nextval('b06009_educational_attainment_by_placeofbirth_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b06009_educational_attainment_by_placeofbirth_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b06009_educational_attainment_by_placeofbirth_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b06009_educational_attainment_by_placeofbirth_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b06009_educational_attainment_by_placeofbirth_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b07204_geomobility_in_migration_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b07204_geomobility_in_migration_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b07204_geomobility_in_migration_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b07204_geomobility_in_migration_acs_ct (
    orderid integer DEFAULT nextval('b07204_geomobility_in_migration_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b07204_geomobility_in_migration_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b07204_geomobility_in_migration_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b07204_geomobility_in_migration_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b07204_geomobility_in_migration_acs_m (
    orderid integer DEFAULT nextval('b07204_geomobility_in_migration_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b07204_geomobility_in_migration_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b07204_geomobility_in_migration_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b07204_geomobility_in_migration_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b07204_geomobility_in_migration_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b07403_geomobility_out_migration_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b07403_geomobility_out_migration_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b07403_geomobility_out_migration_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b07403_geomobility_out_migration_acs_m (
    orderid integer DEFAULT nextval('b07403_geomobility_out_migration_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b07403_geomobility_out_migration_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b07403_geomobility_out_migration_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08006_means_transportation_to_work_by_residence_gender_ct_meta; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08006_means_transportation_to_work_by_residence_gender_ct_meta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08006_means_transportation_to_work_by_residence_gender_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08006_means_transportation_to_work_by_residence_gender_acs_ct (
    orderid integer DEFAULT nextval('b08006_means_transportation_to_work_by_residence_gender_ct_meta'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08006_means_transportation_to_work_by_residence_gender_m_meta_; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08006_means_transportation_to_work_by_residence_gender_m_meta_
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08006_means_transportation_to_work_by_residence_gender_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08006_means_transportation_to_work_by_residence_gender_acs_m (
    orderid integer DEFAULT nextval('b08006_means_transportation_to_work_by_residence_gender_m_meta_'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08101_means_transportation_to_work_by_residence_age_ct_meta_se; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08101_means_transportation_to_work_by_residence_age_ct_meta_se
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08101_means_transportation_to_work_by_residence_age_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08101_means_transportation_to_work_by_residence_age_acs_ct (
    orderid integer DEFAULT nextval('b08101_means_transportation_to_work_by_residence_age_ct_meta_se'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08101_means_transportation_to_work_by_residence_age_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08101_means_transportation_to_work_by_residence_age_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08101_means_transportation_to_work_by_residence_age_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08101_means_transportation_to_work_by_residence_age_acs_m (
    orderid integer DEFAULT nextval('b08101_means_transportation_to_work_by_residence_age_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08105_means_transportation_to_work_by_residence_race_ct_meta_s; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08105_means_transportation_to_work_by_residence_race_ct_meta_s
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08105_means_transportation_to_work_by_residence_race_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08105_means_transportation_to_work_by_residence_race_acs_ct (
    orderid integer DEFAULT nextval('b08105_means_transportation_to_work_by_residence_race_ct_meta_s'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08105_means_transportation_to_work_by_residence_race_m_meta_se; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08105_means_transportation_to_work_by_residence_race_m_meta_se
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08105_means_transportation_to_work_by_residence_race_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08105_means_transportation_to_work_by_residence_race_acs_m (
    orderid integer DEFAULT nextval('b08105_means_transportation_to_work_by_residence_race_m_meta_se'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08134_means_by_traveltime_to_work_acs_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08134_means_by_traveltime_to_work_acs_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08134_means_by_traveltime_to_work_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08134_means_by_traveltime_to_work_acs_bg (
    orderid integer DEFAULT nextval('b08134_means_by_traveltime_to_work_acs_bg_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08134_means_by_traveltime_to_work_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08134_means_by_traveltime_to_work_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08134_means_by_traveltime_to_work_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08134_means_by_traveltime_to_work_acs_ct (
    orderid integer DEFAULT nextval('b08134_means_by_traveltime_to_work_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08134_means_by_traveltime_to_work_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08134_means_by_traveltime_to_work_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08134_means_by_traveltime_to_work_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08134_means_by_traveltime_to_work_acs_m (
    orderid integer DEFAULT nextval('b08134_means_by_traveltime_to_work_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08134_means_by_traveltime_to_work_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08134_means_by_traveltime_to_work_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08134_means_by_traveltime_to_work_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08134_means_by_traveltime_to_work_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08134_means_by_traveltime_to_work_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08134_means_by_traveltime_to_work_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08201_hhsize_by_vehicles_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08201_hhsize_by_vehicles_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08201_hhsize_by_vehicles_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08201_hhsize_by_vehicles_acs_ct (
    orderid integer DEFAULT nextval('b08201_hhsize_by_vehicles_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08201_hhsize_by_vehicles_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08201_hhsize_by_vehicles_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08201_hhsize_by_vehicles_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08201_hhsize_by_vehicles_acs_m (
    orderid integer DEFAULT nextval('b08201_hhsize_by_vehicles_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08201_hhsize_by_vehicles_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08201_hhsize_by_vehicles_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08201_hhsize_by_vehicles_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08201_hhsize_by_vehicles_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08301_means_transportation_to_work_by_residence_acs_bg_meta_se; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08301_means_transportation_to_work_by_residence_acs_bg_meta_se
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08301_means_transportation_to_work_by_residence_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08301_means_transportation_to_work_by_residence_acs_bg (
    orderid integer DEFAULT nextval('b08301_means_transportation_to_work_by_residence_acs_bg_meta_se'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08301_means_transportation_to_work_by_residence_acs_ct_meta_se; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08301_means_transportation_to_work_by_residence_acs_ct_meta_se
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08301_means_transportation_to_work_by_residence_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08301_means_transportation_to_work_by_residence_acs_ct (
    orderid integer DEFAULT nextval('b08301_means_transportation_to_work_by_residence_acs_ct_meta_se'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08301_means_transportation_to_work_by_residence_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08301_means_transportation_to_work_by_residence_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08301_means_transportation_to_work_by_residence_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08301_means_transportation_to_work_by_residence_acs_m (
    orderid integer DEFAULT nextval('b08301_means_transportation_to_work_by_residence_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08301_means_transportation_to_work_by_residence_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08301_means_transportation_to_work_by_residence_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08301_means_transportation_to_work_by_residence_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08301_means_transportation_to_work_by_residence_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08301_means_transportation_to_work_by_residence_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08301_means_transportation_to_work_by_residence_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08303_traveltime_to_work_by_residence_acs_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08303_traveltime_to_work_by_residence_acs_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08303_traveltime_to_work_by_residence_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08303_traveltime_to_work_by_residence_acs_bg (
    orderid integer DEFAULT nextval('b08303_traveltime_to_work_by_residence_acs_bg_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08303_traveltime_to_work_by_residence_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08303_traveltime_to_work_by_residence_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08303_traveltime_to_work_by_residence_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08303_traveltime_to_work_by_residence_acs_ct (
    orderid integer DEFAULT nextval('b08303_traveltime_to_work_by_residence_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08303_traveltime_to_work_by_residence_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08303_traveltime_to_work_by_residence_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08303_traveltime_to_work_by_residence_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08303_traveltime_to_work_by_residence_acs_m (
    orderid integer DEFAULT nextval('b08303_traveltime_to_work_by_residence_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08303_traveltime_to_work_by_residence_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08303_traveltime_to_work_by_residence_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08303_traveltime_to_work_by_residence_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08303_traveltime_to_work_by_residence_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08303_traveltime_to_work_by_residence_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08303_traveltime_to_work_by_residence_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08601_means_transportation_to_work_by_workplace_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08601_means_transportation_to_work_by_workplace_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08601_means_transportation_to_work_by_workplace_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08601_means_transportation_to_work_by_workplace_acs_m (
    orderid integer DEFAULT nextval('b08601_means_transportation_to_work_by_workplace_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b08603_traveltime_to_work_by_placeofwork_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b08603_traveltime_to_work_by_placeofwork_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b08603_traveltime_to_work_by_placeofwork_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b08603_traveltime_to_work_by_placeofwork_acs_m (
    orderid integer DEFAULT nextval('b08603_traveltime_to_work_by_placeofwork_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b11005_hh_with_kids_acs_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11005_hh_with_kids_acs_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11005_hh_with_kids_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b11005_hh_with_kids_acs_bg (
    orderid integer DEFAULT nextval('b11005_hh_with_kids_acs_bg_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b11005_hh_with_kids_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11005_hh_with_kids_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11005_hh_with_kids_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b11005_hh_with_kids_acs_ct (
    orderid integer DEFAULT nextval('b11005_hh_with_kids_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b11005_hh_with_kids_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11005_hh_with_kids_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11005_hh_with_kids_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b11005_hh_with_kids_acs_m (
    orderid integer DEFAULT nextval('b11005_hh_with_kids_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b11005_hh_with_kids_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11005_hh_with_kids_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11005_hh_with_kids_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11005_hh_with_kids_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11005_hh_with_kids_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11005_hh_with_kids_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11007_hh_with_seniors_acs_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11007_hh_with_seniors_acs_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11007_hh_with_seniors_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b11007_hh_with_seniors_acs_bg (
    orderid integer DEFAULT nextval('b11007_hh_with_seniors_acs_bg_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b11007_hh_with_seniors_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11007_hh_with_seniors_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11007_hh_with_seniors_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b11007_hh_with_seniors_acs_ct (
    orderid integer DEFAULT nextval('b11007_hh_with_seniors_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b11007_hh_with_seniors_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11007_hh_with_seniors_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11007_hh_with_seniors_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b11007_hh_with_seniors_acs_m (
    orderid integer DEFAULT nextval('b11007_hh_with_seniors_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b11007_hh_with_seniors_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11007_hh_with_seniors_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11007_hh_with_seniors_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11007_hh_with_seniors_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11007_hh_with_seniors_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11007_hh_with_seniors_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11009_unmarried_partners_hh_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11009_unmarried_partners_hh_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11009_unmarried_partners_hh_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b11009_unmarried_partners_hh_acs_ct (
    orderid integer DEFAULT nextval('b11009_unmarried_partners_hh_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b11009_unmarried_partners_hh_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11009_unmarried_partners_hh_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11009_unmarried_partners_hh_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11009_unmarried_partners_hh_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11009_unmarried_partners_hh_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b11009_unmarried_partners_hh_acs_m (
    orderid integer DEFAULT nextval('b11009_unmarried_partners_hh_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b11009_unmarried_partners_hh_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11009_unmarried_partners_hh_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11009_unmarried_partners_hh_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11009_unmarried_partners_hh_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11009_unmarried_partners_hh_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11009_unmarried_partners_hh_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b11009_unmarried_partners_hh_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b11009_unmarried_partners_hh_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b15001_educational_attainment_by_age_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b15001_educational_attainment_by_age_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b15001_educational_attainment_by_age_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b15001_educational_attainment_by_age_acs_ct (
    orderid integer DEFAULT nextval('b15001_educational_attainment_by_age_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b15001_educational_attainment_by_age_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b15001_educational_attainment_by_age_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b15001_educational_attainment_by_age_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b15001_educational_attainment_by_age_acs_m (
    orderid integer DEFAULT nextval('b15001_educational_attainment_by_age_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b15001_educational_attainment_by_age_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b15001_educational_attainment_by_age_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b15002_educational_attainment_acs_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b15002_educational_attainment_acs_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b15002_educational_attainment_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b15002_educational_attainment_acs_bg (
    orderid integer DEFAULT nextval('b15002_educational_attainment_acs_bg_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b15002_educational_attainment_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b15002_educational_attainment_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b15002_educational_attainment_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b15002_educational_attainment_acs_ct (
    orderid integer DEFAULT nextval('b15002_educational_attainment_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b15002_educational_attainment_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b15002_educational_attainment_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b15002_educational_attainment_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b15002_educational_attainment_acs_m (
    orderid integer DEFAULT nextval('b15002_educational_attainment_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b16002_hh_linguistic_isolation_acs_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16002_hh_linguistic_isolation_acs_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16002_hh_linguistic_isolation_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b16002_hh_linguistic_isolation_acs_bg (
    orderid integer DEFAULT nextval('b16002_hh_linguistic_isolation_acs_bg_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b16002_hh_linguistic_isolation_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16002_hh_linguistic_isolation_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16002_hh_linguistic_isolation_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b16002_hh_linguistic_isolation_acs_ct (
    orderid integer DEFAULT nextval('b16002_hh_linguistic_isolation_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b16002_hh_linguistic_isolation_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16002_hh_linguistic_isolation_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16002_hh_linguistic_isolation_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b16002_hh_linguistic_isolation_acs_m (
    orderid integer DEFAULT nextval('b16002_hh_linguistic_isolation_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b16004_home_language_english_ability_acs_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16004_home_language_english_ability_acs_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16004_home_language_english_ability_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b16004_home_language_english_ability_acs_bg (
    orderid integer DEFAULT nextval('b16004_home_language_english_ability_acs_bg_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b16004_home_language_english_ability_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16004_home_language_english_ability_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16004_home_language_english_ability_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16004_home_language_english_ability_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16004_home_language_english_ability_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b16004_home_language_english_ability_acs_ct (
    orderid integer DEFAULT nextval('b16004_home_language_english_ability_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b16004_home_language_english_ability_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16004_home_language_english_ability_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16004_home_language_english_ability_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16004_home_language_english_ability_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16004_home_language_english_ability_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b16004_home_language_english_ability_acs_m (
    orderid integer DEFAULT nextval('b16004_home_language_english_ability_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b16004_home_language_english_ability_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16004_home_language_english_ability_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16005_nativity_english_ability_by_race_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16005_nativity_english_ability_by_race_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16005_nativity_english_ability_by_race_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b16005_nativity_english_ability_by_race_acs_ct (
    orderid integer DEFAULT nextval('b16005_nativity_english_ability_by_race_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b16005_nativity_english_ability_by_race_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16005_nativity_english_ability_by_race_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16005_nativity_english_ability_by_race_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16005_nativity_english_ability_by_race_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b16005_nativity_english_ability_by_race_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b16005_nativity_english_ability_by_race_acs_m (
    orderid integer DEFAULT nextval('b16005_nativity_english_ability_by_race_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b16005_nativity_english_ability_by_race_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b16005_nativity_english_ability_by_race_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17001_poverty_by_age_gender_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17001_poverty_by_age_gender_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17001_poverty_by_age_gender_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17001_poverty_by_age_gender_acs_ct (
    orderid integer DEFAULT nextval('b17001_poverty_by_age_gender_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17001_poverty_by_age_gender_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17001_poverty_by_age_gender_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17001_poverty_by_age_gender_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17001_poverty_by_age_gender_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17001_poverty_by_age_gender_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17001_poverty_by_age_gender_acs_m (
    orderid integer DEFAULT nextval('b17001_poverty_by_age_gender_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17001_poverty_by_age_gender_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17001_poverty_by_age_gender_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17001_povertypopulation_acs_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17001_povertypopulation_acs_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17001_povertypopulation_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17001_povertypopulation_acs_ct (
    orderid integer DEFAULT nextval('b17001_povertypopulation_acs_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17001_povertypopulation_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17001_povertypopulation_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17001_povertypopulation_acs_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17001_povertypopulation_acs_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17001_povertypopulation_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17001_povertypopulation_acs_m (
    orderid integer DEFAULT nextval('b17001_povertypopulation_acs_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17001_povertypopulation_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17001_povertypopulation_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17006_child_poverty_by_familytype_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17006_child_poverty_by_familytype_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17006_child_poverty_by_familytype_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17006_child_poverty_by_familytype_acs_ct (
    orderid integer DEFAULT nextval('b17006_child_poverty_by_familytype_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17006_child_poverty_by_familytype_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17006_child_poverty_by_familytype_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17006_child_poverty_by_familytype_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17006_child_poverty_by_familytype_acs_m (
    orderid integer DEFAULT nextval('b17006_child_poverty_by_familytype_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17010_families_with_children_inpoverty_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17010_families_with_children_inpoverty_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17010_families_with_children_in_poverty_by_familytype_race_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17010_families_with_children_in_poverty_by_familytype_race_bg (
    orderid integer DEFAULT nextval('b17010_families_with_children_inpoverty_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17010_families_with_children_inpoverty_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17010_families_with_children_inpoverty_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17010_families_with_children_in_poverty_by_familytype_race_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17010_families_with_children_in_poverty_by_familytype_race_ct (
    orderid integer DEFAULT nextval('b17010_families_with_children_inpoverty_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17010_families_with_children_inpoverty_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17010_families_with_children_inpoverty_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17010_families_with_children_in_poverty_by_familytype_race_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17010_families_with_children_in_poverty_by_familytype_race_m (
    orderid integer DEFAULT nextval('b17010_families_with_children_inpoverty_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17017_poverty_by_hh_type_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17017_poverty_by_hh_type_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17017_poverty_by_hh_type_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17017_poverty_by_hh_type_acs_bg (
    orderid integer DEFAULT nextval('b17017_poverty_by_hh_type_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17017_poverty_by_hh_type_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17017_poverty_by_hh_type_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17017_poverty_by_hh_type_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17017_poverty_by_hh_type_acs_ct (
    orderid integer DEFAULT nextval('b17017_poverty_by_hh_type_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17017_poverty_by_hh_type_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17017_poverty_by_hh_type_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17017_poverty_by_hh_type_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17017_poverty_by_hh_type_acs_m (
    orderid integer DEFAULT nextval('b17017_poverty_by_hh_type_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17020_poverty_by_race_age_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17020_poverty_by_race_age_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17020_poverty_by_race_age_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17020_poverty_by_race_age_acs_ct (
    orderid integer DEFAULT nextval('b17020_poverty_by_race_age_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b17020_poverty_by_race_age_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b17020_poverty_by_race_age_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b17020_poverty_by_race_age_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b17020_poverty_by_race_age_acs_m (
    orderid integer DEFAULT nextval('b17020_poverty_by_race_age_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19001_hh_income_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19001_hh_income_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19001_hh_income_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19001_hh_income_acs_bg (
    orderid integer DEFAULT nextval('b19001_hh_income_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19001_hh_income_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19001_hh_income_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19001_hh_income_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19001_hh_income_acs_ct (
    orderid integer DEFAULT nextval('b19001_hh_income_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19001_hh_income_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19001_hh_income_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19001_hh_income_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19001_hh_income_acs_m (
    orderid integer DEFAULT nextval('b19001_hh_income_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19013_b19113_b19202_mhi_fam_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19013_b19113_b19202_mhi_fam_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19013_b19113_b19202_mhi_fam_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19013_b19113_b19202_mhi_fam_acs_bg (
    orderid integer DEFAULT nextval('b19013_b19113_b19202_mhi_fam_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19013_b19113_b19202_mhi_fam_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19013_b19113_b19202_mhi_fam_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19013_b19113_b19202_mhi_fam_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19013_b19113_b19202_mhi_fam_acs_ct (
    orderid integer DEFAULT nextval('b19013_b19113_b19202_mhi_fam_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19013_b19113_b19202_mhi_fam_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19013_b19113_b19202_mhi_fam_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19013_b19113_b19202_mhi_fam_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19013_b19113_b19202_mhi_fam_acs_m (
    orderid integer DEFAULT nextval('b19013_b19113_b19202_mhi_fam_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19013_mhi_race_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19013_mhi_race_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19013_mhi_race_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19013_mhi_race_acs_bg (
    orderid integer DEFAULT nextval('b19013_mhi_race_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19013_mhi_race_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19013_mhi_race_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19013_mhi_race_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19013_mhi_race_acs_ct (
    orderid integer DEFAULT nextval('b19013_mhi_race_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19013_mhi_race_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19013_mhi_race_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19013_mhi_race_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19013_mhi_race_acs_m (
    orderid integer DEFAULT nextval('b19013_mhi_race_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19037_hh_income_by_age_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19037_hh_income_by_age_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19037_hh_income_by_age_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19037_hh_income_by_age_acs_bg (
    orderid integer DEFAULT nextval('b19037_hh_income_by_age_bg_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19037_hh_income_by_age_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19037_hh_income_by_age_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19037_hh_income_by_age_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19037_hh_income_by_age_acs_ct (
    orderid integer DEFAULT nextval('b19037_hh_income_by_age_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19037_hh_income_by_age_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19037_hh_income_by_age_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19037_hh_income_by_age_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19037_hh_income_by_age_acs_m (
    orderid integer DEFAULT nextval('b19037_hh_income_by_age_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19058_public_assist_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19058_public_assist_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19058_public_assist_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19058_public_assist_acs_ct (
    orderid integer DEFAULT nextval('b19058_public_assist_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19058_public_assist_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19058_public_assist_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19058_public_assist_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19058_public_assist_acs_m (
    orderid integer DEFAULT nextval('b19058_public_assist_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19083_gini_index_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19083_gini_index_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19083_gini_index_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19083_gini_index_acs_ct (
    orderid integer DEFAULT nextval('b19083_gini_index_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19083_gini_index_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19083_gini_index_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19083_gini_index_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19083_gini_index_acs_m (
    orderid integer DEFAULT nextval('b19083_gini_index_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19301_per_capita_income_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19301_per_capita_income_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19301_per_capita_income_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19301_per_capita_income_acs_bg (
    orderid integer DEFAULT nextval('b19301_per_capita_income_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19301_per_capita_income_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19301_per_capita_income_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19301_per_capita_income_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19301_per_capita_income_acs_ct (
    orderid integer DEFAULT nextval('b19301_per_capita_income_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b19301_per_capita_income_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b19301_per_capita_income_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b19301_per_capita_income_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b19301_per_capita_income_acs_m (
    orderid integer DEFAULT nextval('b19301_per_capita_income_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b22003_b22005_hh_foodstamps_snap_by_race_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b22003_b22005_hh_foodstamps_snap_by_race_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b22003_b22005_hh_foodstamps_snap_by_race_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b22003_b22005_hh_foodstamps_snap_by_race_acs_ct (
    orderid integer DEFAULT nextval('b22003_b22005_hh_foodstamps_snap_by_race_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b22003_b22005_hh_foodstamps_snap_by_race_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b22003_b22005_hh_foodstamps_snap_by_race_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b22003_b22005_hh_foodstamps_snap_by_race_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b22003_b22005_hh_foodstamps_snap_by_race_acs_m (
    orderid integer DEFAULT nextval('b22003_b22005_hh_foodstamps_snap_by_race_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b23006_educational_attainment_by_laborforce_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b23006_educational_attainment_by_laborforce_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b23006_educational_attainment_by_laborforce_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b23006_educational_attainment_by_laborforce_ct (
    orderid integer DEFAULT nextval('b23006_educational_attainment_by_laborforce_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b23006_educational_attainment_by_laborforce_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b23006_educational_attainment_by_laborforce_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b23006_educational_attainment_by_laborforce_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b23006_educational_attainment_by_laborforce_m (
    orderid integer DEFAULT nextval('b23006_educational_attainment_by_laborforce_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b23025_employment_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b23025_employment_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b23025_employment_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b23025_employment_acs_bg (
    orderid integer DEFAULT nextval('b23025_employment_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b23025_employment_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b23025_employment_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b23025_employment_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b23025_employment_acs_ct (
    orderid integer DEFAULT nextval('b23025_employment_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b23025_employment_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b23025_employment_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b23025_employment_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b23025_employment_acs_m (
    orderid integer DEFAULT nextval('b23025_employment_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25002_b25003_hu_occupancy_by_tenure_race_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25002_b25003_hu_occupancy_by_tenure_race_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25002_b25003_hu_occupancy_by_tenure_race_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25002_b25003_hu_occupancy_by_tenure_race_acs_bg (
    orderid integer DEFAULT nextval('b25002_b25003_hu_occupancy_by_tenure_race_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25002_b25003_hu_occupancy_by_tenure_race_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25002_b25003_hu_occupancy_by_tenure_race_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25002_b25003_hu_occupancy_by_tenure_race_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25002_b25003_hu_occupancy_by_tenure_race_acs_ct (
    orderid integer DEFAULT nextval('b25002_b25003_hu_occupancy_by_tenure_race_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25002_b25003_hu_occupancy_by_tenure_race_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25002_b25003_hu_occupancy_by_tenure_race_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25002_b25003_hu_occupancy_by_tenure_race_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25002_b25003_hu_occupancy_by_tenure_race_acs_m (
    orderid integer DEFAULT nextval('b25002_b25003_hu_occupancy_by_tenure_race_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25024_hu_units_in_structure_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25024_hu_units_in_structure_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25024_hu_units_in_structure_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25024_hu_units_in_structure_acs_bg (
    orderid integer DEFAULT nextval('b25024_hu_units_in_structure_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25024_hu_units_in_structure_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25024_hu_units_in_structure_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25024_hu_units_in_structure_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25024_hu_units_in_structure_acs_ct (
    orderid integer DEFAULT nextval('b25024_hu_units_in_structure_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25024_hu_units_in_structure_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25024_hu_units_in_structure_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25024_hu_units_in_structure_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25024_hu_units_in_structure_acs_m (
    orderid integer DEFAULT nextval('b25024_hu_units_in_structure_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25032_hu_tenure_by_units_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25032_hu_tenure_by_units_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25032_hu_tenure_by_units_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25032_hu_tenure_by_units_acs_bg (
    orderid integer DEFAULT nextval('b25032_hu_tenure_by_units_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25032_hu_tenure_by_units_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25032_hu_tenure_by_units_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25032_hu_tenure_by_units_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25032_hu_tenure_by_units_acs_ct (
    orderid integer DEFAULT nextval('b25032_hu_tenure_by_units_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25032_hu_tenure_by_units_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25032_hu_tenure_by_units_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25032_hu_tenure_by_units_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25032_hu_tenure_by_units_acs_m (
    orderid integer DEFAULT nextval('b25032_hu_tenure_by_units_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25044_hu_vehicles_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25044_hu_vehicles_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25044_hu_vehicles_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25044_hu_vehicles_acs_bg (
    orderid integer DEFAULT nextval('b25044_hu_vehicles_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25044_hu_vehicles_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25044_hu_vehicles_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25044_hu_vehicles_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25044_hu_vehicles_acs_ct (
    orderid integer DEFAULT nextval('b25044_hu_vehicles_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25044_hu_vehicles_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25044_hu_vehicles_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25044_hu_vehicles_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25044_hu_vehicles_acs_m (
    orderid integer DEFAULT nextval('b25044_hu_vehicles_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25056_b25058_contract_rent_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25056_b25058_contract_rent_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25056_b25058_contract_rent_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25056_b25058_contract_rent_acs_bg (
    orderid integer DEFAULT nextval('b25056_b25058_contract_rent_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25056_b25058_contract_rent_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25056_b25058_contract_rent_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25056_b25058_contract_rent_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25056_b25058_contract_rent_acs_ct (
    orderid integer DEFAULT nextval('b25056_b25058_contract_rent_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25056_b25058_contract_rent_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25056_b25058_contract_rent_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25056_b25058_contract_rent_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25056_b25058_contract_rent_acs_m (
    orderid integer DEFAULT nextval('b25056_b25058_contract_rent_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25063_b25064_b25065_rent_bg_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25063_b25064_b25065_rent_bg_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25063_b25064_b25065_rent_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25063_b25064_b25065_rent_acs_bg (
    orderid integer DEFAULT nextval('b25063_b25064_b25065_rent_bg_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25063_b25064_b25065_rent_ct_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25063_b25064_b25065_rent_ct_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25063_b25064_b25065_rent_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25063_b25064_b25065_rent_acs_ct (
    orderid integer DEFAULT nextval('b25063_b25064_b25065_rent_ct_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25063_b25064_b25065_rent_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25063_b25064_b25065_rent_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25063_b25064_b25065_rent_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25063_b25064_b25065_rent_acs_m (
    orderid integer DEFAULT nextval('b25063_b25064_b25065_rent_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25072_b25093_costburden_by_age_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25072_b25093_costburden_by_age_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25072_b25093_costburden_by_age_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25072_b25093_costburden_by_age_acs_bg (
    orderid integer DEFAULT nextval('b25072_b25093_costburden_by_age_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25072_b25093_costburden_by_age_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25072_b25093_costburden_by_age_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25072_b25093_costburden_by_age_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25072_b25093_costburden_by_age_acs_ct (
    orderid integer DEFAULT nextval('b25072_b25093_costburden_by_age_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25072_b25093_costburden_by_age_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25072_b25093_costburden_by_age_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25072_b25093_costburden_by_age_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25072_b25093_costburden_by_age_acs_m (
    orderid integer DEFAULT nextval('b25072_b25093_costburden_by_age_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25074_costburden_renters_by_income_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25074_costburden_renters_by_income_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25074_costburden_renters_by_income_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25074_costburden_renters_by_income_acs_bg (
    orderid integer DEFAULT nextval('b25074_costburden_renters_by_income_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25074_costburden_renters_by_income_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25074_costburden_renters_by_income_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25074_costburden_renters_by_income_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25074_costburden_renters_by_income_acs_ct (
    orderid integer DEFAULT nextval('b25074_costburden_renters_by_income_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25074_costburden_renters_by_income_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25074_costburden_renters_by_income_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25074_costburden_renters_by_income_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25074_costburden_renters_by_income_acs_m (
    orderid integer DEFAULT nextval('b25074_costburden_renters_by_income_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25091_b25070_costburden_acs_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25091_b25070_costburden_acs_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25091_b25070_costburden_acs_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25091_b25070_costburden_acs_bg (
    orderid integer DEFAULT nextval('b25091_b25070_costburden_acs_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25091_b25070_costburden_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25091_b25070_costburden_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25091_b25070_costburden_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25091_b25070_costburden_acs_ct (
    orderid integer DEFAULT nextval('b25091_b25070_costburden_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25091_b25070_costburden_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25091_b25070_costburden_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25091_b25070_costburden_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25091_b25070_costburden_acs_m (
    orderid integer DEFAULT nextval('b25091_b25070_costburden_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25097_median_value_by_mortgage_status_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25097_median_value_by_mortgage_status_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25097_median_value_by_mortgage_status_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25097_median_value_by_mortgage_status_acs_ct (
    orderid integer DEFAULT nextval('b25097_median_value_by_mortgage_status_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25097_median_value_by_mortgage_status_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25097_median_value_by_mortgage_status_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25097_median_value_by_mortgage_status_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25097_median_value_by_mortgage_status_acs_m (
    orderid integer DEFAULT nextval('b25097_median_value_by_mortgage_status_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25106_costburden_by_income_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25106_costburden_by_income_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25106_costburden_by_income_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25106_costburden_by_income_acs_ct (
    orderid integer DEFAULT nextval('b25106_costburden_by_income_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25106_costburden_by_income_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25106_costburden_by_income_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25106_costburden_by_income_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25106_costburden_by_income_acs_m (
    orderid integer DEFAULT nextval('b25106_costburden_by_income_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25117_hu_tenure_by_fuel_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25117_hu_tenure_by_fuel_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25117_hu_tenure_by_fuel_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25117_hu_tenure_by_fuel_acs_ct (
    orderid integer DEFAULT nextval('b25117_hu_tenure_by_fuel_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25117_hu_tenure_by_fuel_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25117_hu_tenure_by_fuel_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25117_hu_tenure_by_fuel_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25117_hu_tenure_by_fuel_acs_m (
    orderid integer DEFAULT nextval('b25117_hu_tenure_by_fuel_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25119_mhi_tenure_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25119_mhi_tenure_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25119_mhi_tenure_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25119_mhi_tenure_acs_ct (
    orderid integer DEFAULT nextval('b25119_mhi_tenure_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25119_mhi_tenure_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25119_mhi_tenure_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25119_mhi_tenure_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25119_mhi_tenure_acs_m (
    orderid integer DEFAULT nextval('b25119_mhi_tenure_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25127_hu_tenure_year_built_units_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25127_hu_tenure_year_built_units_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25127_hu_tenure_year_built_units_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25127_hu_tenure_year_built_units_acs_ct (
    orderid integer DEFAULT nextval('b25127_hu_tenure_year_built_units_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b25127_hu_tenure_year_built_units_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b25127_hu_tenure_year_built_units_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b25127_hu_tenure_year_built_units_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b25127_hu_tenure_year_built_units_acs_m (
    orderid integer DEFAULT nextval('b25127_hu_tenure_year_built_units_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b27001_healthinsurance_by_gender_age_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b27001_healthinsurance_by_gender_age_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b27001_healthinsurance_by_gender_age_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b27001_healthinsurance_by_gender_age_acs_ct (
    orderid integer DEFAULT nextval('b27001_healthinsurance_by_gender_age_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: b27001_healthinsurance_by_gender_age_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE b27001_healthinsurance_by_gender_age_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: b27001_healthinsurance_by_gender_age_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE b27001_healthinsurance_by_gender_age_acs_m (
    orderid integer DEFAULT nextval('b27001_healthinsurance_by_gender_age_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: c15002_educational_attainment_by_race_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE c15002_educational_attainment_by_race_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: c15002_educational_attainment_by_race_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE c15002_educational_attainment_by_race_acs_ct (
    orderid integer DEFAULT nextval('c15002_educational_attainment_by_race_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: c15002_educational_attainment_by_race_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE c15002_educational_attainment_by_race_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: c15002_educational_attainment_by_race_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE c15002_educational_attainment_by_race_acs_m (
    orderid integer DEFAULT nextval('c15002_educational_attainment_by_race_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: c23002_employment_by_race_age_acs_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE c23002_employment_by_race_age_acs_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: c23002_employment_by_race_age_acs_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE c23002_employment_by_race_age_acs_ct (
    orderid integer DEFAULT nextval('c23002_employment_by_race_age_acs_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: c23002_employment_by_race_age_acs_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE c23002_employment_by_race_age_acs_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: c23002_employment_by_race_age_acs_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE c23002_employment_by_race_age_acs_m (
    orderid integer DEFAULT nextval('c23002_employment_by_race_age_acs_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p12_pop_by_age_b_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p12_pop_by_age_b_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p12_pop_by_age_b; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p12_pop_by_age_b (
    orderid integer DEFAULT nextval('census2010_p12_pop_by_age_b_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p12_pop_by_age_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p12_pop_by_age_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p12_pop_by_age_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p12_pop_by_age_bg (
    orderid integer DEFAULT nextval('census2010_p12_pop_by_age_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p12_pop_by_age_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p12_pop_by_age_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p12_pop_by_age_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p12_pop_by_age_ct (
    orderid integer DEFAULT nextval('census2010_p12_pop_by_age_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p12_pop_by_age_gender_b_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p12_pop_by_age_gender_b_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p12_pop_by_age_gender_b; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p12_pop_by_age_gender_b (
    orderid integer DEFAULT nextval('census2010_p12_pop_by_age_gender_b_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p12_pop_by_age_gender_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p12_pop_by_age_gender_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p12_pop_by_age_gender_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p12_pop_by_age_gender_bg (
    orderid integer DEFAULT nextval('census2010_p12_pop_by_age_gender_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p12_pop_by_age_gender_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p12_pop_by_age_gender_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p12_pop_by_age_gender_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p12_pop_by_age_gender_ct (
    orderid integer DEFAULT nextval('census2010_p12_pop_by_age_gender_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p12_pop_by_age_gender_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p12_pop_by_age_gender_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p12_pop_by_age_gender_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p12_pop_by_age_gender_m (
    orderid integer DEFAULT nextval('census2010_p12_pop_by_age_gender_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_b_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p20_hh_with_kids_by_hhtype_b_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_b; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p20_hh_with_kids_by_hhtype_b (
    orderid integer DEFAULT nextval('census2010_p20_hh_with_kids_by_hhtype_b_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p20_hh_with_kids_by_hhtype_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p20_hh_with_kids_by_hhtype_bg (
    orderid integer DEFAULT nextval('census2010_p20_hh_with_kids_by_hhtype_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p20_hh_with_kids_by_hhtype_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p20_hh_with_kids_by_hhtype_ct (
    orderid integer DEFAULT nextval('census2010_p20_hh_with_kids_by_hhtype_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p20_hh_with_kids_by_hhtype_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p20_hh_with_kids_by_hhtype_m (
    orderid integer DEFAULT nextval('census2010_p20_hh_with_kids_by_hhtype_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p25_hh_type_size_b_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p25_hh_type_size_b_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p25_hh_type_size_b; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p25_hh_type_size_b (
    orderid integer DEFAULT nextval('census2010_p25_hh_type_size_b_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p25_hh_type_size_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p25_hh_type_size_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p25_hh_type_size_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p25_hh_type_size_bg (
    orderid integer DEFAULT nextval('census2010_p25_hh_type_size_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p25_hh_type_size_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p25_hh_type_size_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p25_hh_type_size_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p25_hh_type_size_ct (
    orderid integer DEFAULT nextval('census2010_p25_hh_type_size_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p3_race_b_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p3_race_b_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p3_race_b; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p3_race_b (
    orderid integer DEFAULT nextval('census2010_p3_race_b_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p3_race_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p3_race_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p3_race_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p3_race_bg (
    orderid integer DEFAULT nextval('census2010_p3_race_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p3_race_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p3_race_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p3_race_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p3_race_ct (
    orderid integer DEFAULT nextval('census2010_p3_race_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p3_race_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p3_race_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p3_race_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p3_race_m (
    orderid integer DEFAULT nextval('census2010_p3_race_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p5_race_ethnicity_b_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p5_race_ethnicity_b_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p5_race_ethnicity_b; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p5_race_ethnicity_b (
    orderid integer DEFAULT nextval('census2010_p5_race_ethnicity_b_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p5_race_ethnicity_bg_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p5_race_ethnicity_bg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p5_race_ethnicity_bg; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p5_race_ethnicity_bg (
    orderid integer DEFAULT nextval('census2010_p5_race_ethnicity_bg_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p5_race_ethnicity_ct_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p5_race_ethnicity_ct_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p5_race_ethnicity_ct; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p5_race_ethnicity_ct (
    orderid integer DEFAULT nextval('census2010_p5_race_ethnicity_ct_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: census2010_p5_race_ethnicity_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE census2010_p5_race_ethnicity_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: census2010_p5_race_ethnicity_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE census2010_p5_race_ethnicity_m (
    orderid integer DEFAULT nextval('census2010_p5_race_ethnicity_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: demo_population_by_decade_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE demo_population_by_decade_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: demo_population_by_decade_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE demo_population_by_decade_m (
    orderid integer DEFAULT nextval('demo_population_by_decade_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: demo_population_minorities_00_10_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE demo_population_minorities_00_10_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: demo_population_minorities_00_10_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE demo_population_minorities_00_10_m (
    orderid integer DEFAULT nextval('demo_population_minorities_00_10_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: demo_population_over_under18_10m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE demo_population_over_under18_10m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: demo_population_over_under18_10m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE demo_population_over_under18_10m (
    orderid integer DEFAULT nextval('demo_population_over_under18_10m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: econ_unemployment_by_year_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE econ_unemployment_by_year_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: econ_unemployment_by_year_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE econ_unemployment_by_year_m (
    orderid integer DEFAULT nextval('econ_unemployment_by_year_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(250)
);


--
-- Name: educ_district_enrollment_seq_id_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE educ_district_enrollment_seq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: educ_enrollment_by_year_districts; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE educ_enrollment_by_year_districts (
    orderid integer DEFAULT nextval('educ_district_enrollment_seq_id_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: educ_muni_enrollment_seq_id_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE educ_muni_enrollment_seq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: educ_enrollment_by_year_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE educ_enrollment_by_year_m (
    orderid integer DEFAULT nextval('educ_muni_enrollment_seq_id_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: educ_school_enrollment_seq_id_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE educ_school_enrollment_seq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: educ_enrollment_by_year_schools; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE educ_enrollment_by_year_schools (
    orderid integer DEFAULT nextval('educ_school_enrollment_seq_id_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: educ_school_enrollment_by_year_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE educ_school_enrollment_by_year_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: health_births_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE health_births_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: health_births_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE health_births_m (
    orderid integer DEFAULT nextval('health_births_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: hous_hh_fam_00_10meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE hous_hh_fam_00_10meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hous_hh_fam_00_10m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE hous_hh_fam_00_10m (
    orderid integer DEFAULT nextval('hous_hh_fam_00_10meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: hous_table7_hh_ami_by_cb_chas_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE hous_table7_hh_ami_by_cb_chas_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hous_table7_hh_ami_by_cb_chas_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE hous_table7_hh_ami_by_cb_chas_m (
    orderid integer DEFAULT nextval('hous_table7_hh_ami_by_cb_chas_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: hous_table7_hh_income_by_hh_type_chas_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE hous_table7_hh_income_by_hh_type_chas_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hous_table7_hh_income_by_hh_type_chas_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE hous_table7_hh_income_by_hh_type_chas_m (
    orderid integer DEFAULT nextval('hous_table7_hh_income_by_hh_type_chas_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: hous_table7_hh_type_by_cb_chas_m_meta_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE hous_table7_hh_type_by_cb_chas_m_meta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hous_table7_hh_type_by_cb_chas_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE hous_table7_hh_type_by_cb_chas_m (
    orderid integer DEFAULT nextval('hous_table7_hh_type_by_cb_chas_m_meta_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


--
-- Name: trans_crashes_by_year_m_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE trans_crashes_by_year_m_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trans_crashes_by_year_m; Type: TABLE; Schema: metadata; Owner: -; Tablespace: 
--

CREATE TABLE trans_crashes_by_year_m (
    orderid integer DEFAULT nextval('trans_crashes_by_year_m_seq'::regclass) NOT NULL,
    name character varying(10),
    alias character varying(150),
    details character varying(150)
);


SET search_path = public, pg_catalog;

--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    password character varying(128) NOT NULL,
    is_staff boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    is_superuser boolean DEFAULT false NOT NULL,
    last_login timestamp with time zone DEFAULT '2014-10-21 14:32:24.188076-04'::timestamp with time zone NOT NULL,
    date_joined timestamp with time zone DEFAULT '2014-10-21 14:32:24.186514-04'::timestamp with time zone NOT NULL,
    remember_token character varying(255)
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: brandings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE brandings (
    id integer NOT NULL,
    institution_id integer,
    logo_url character varying(255),
    tagline character varying(255),
    map_gallery_intro character varying(255),
    logos text DEFAULT '[]'::text
);


--
-- Name: brandings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE brandings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: brandings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE brandings_id_seq OWNED BY brandings.id;


--
-- Name: core_genericobjectrolemapping; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE core_genericobjectrolemapping (
    id integer NOT NULL,
    subject character varying(100) NOT NULL,
    object_ct_id integer NOT NULL,
    object_id integer NOT NULL,
    role_id integer NOT NULL,
    CONSTRAINT core_genericobjectrolemapping_object_id_check CHECK ((object_id >= 0))
);


--
-- Name: core_genericobjectrolemapping_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE core_genericobjectrolemapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: core_genericobjectrolemapping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE core_genericobjectrolemapping_id_seq OWNED BY core_genericobjectrolemapping.id;


--
-- Name: institutions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE institutions (
    id integer NOT NULL,
    short_name character varying(255),
    long_name character varying(255),
    subdomain character varying(255),
    region_id integer
);


--
-- Name: institutions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE institutions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institutions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE institutions_id_seq OWNED BY institutions.id;


--
-- Name: layers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE layers (
    title character varying(255),
    alt_title character varying(255),
    descriptn character varying(255),
    subject character varying(255),
    creator character varying(255),
    createdate character varying(255),
    moddate character varying(255),
    publisher character varying(255),
    contributr character varying(255),
    coverage character varying(255),
    universe character varying(255),
    schema character varying(255),
    tablename character varying(255),
    tablenum character varying(255),
    institution_id integer,
    id integer NOT NULL,
    join_key character varying(255),
    preview_image character varying(255),
    datesavail character varying(255)
);


--
-- Name: layers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE layers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: layers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE layers_id_seq OWNED BY layers.id;


--
-- Name: maps_contact; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE maps_contact (
    id integer NOT NULL,
    user_id integer,
    name character varying(255),
    organization character varying(255),
    "position" character varying(255),
    voice character varying(255),
    fax character varying(255),
    delivery character varying(255),
    city character varying(255),
    area character varying(255),
    zipcode character varying(255),
    country character varying(3),
    email character varying(75),
    website_url character varying(200),
    mapc_newsletter boolean DEFAULT false NOT NULL,
    mbdc_newsletter boolean DEFAULT false NOT NULL,
    last_modified timestamp with time zone DEFAULT '2014-10-21 14:34:11.939363-04'::timestamp with time zone NOT NULL
);


--
-- Name: maps_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE maps_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: maps_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE maps_contact_id_seq OWNED BY maps_contact.id;


--
-- Name: mbdc_calendar; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mbdc_calendar (
    id integer NOT NULL,
    year integer NOT NULL,
    month integer NOT NULL,
    title character varying(100) NOT NULL,
    abstract text NOT NULL,
    pdf_page character varying(100) NOT NULL,
    thumbnail character varying(100) NOT NULL,
    institution_id integer DEFAULT 1
);


--
-- Name: mbdc_calendar_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mbdc_calendar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mbdc_calendar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mbdc_calendar_id_seq OWNED BY mbdc_calendar.id;


--
-- Name: mbdc_calendar_sources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mbdc_calendar_sources (
    id integer NOT NULL,
    calendar_id integer NOT NULL,
    datasource_id integer NOT NULL
);


--
-- Name: mbdc_calendar_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mbdc_calendar_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mbdc_calendar_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mbdc_calendar_sources_id_seq OWNED BY mbdc_calendar_sources.id;


--
-- Name: mbdc_calendar_topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mbdc_calendar_topics (
    id integer NOT NULL,
    calendar_id integer NOT NULL,
    topic_id integer NOT NULL
);


--
-- Name: mbdc_calendar_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mbdc_calendar_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mbdc_calendar_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mbdc_calendar_topics_id_seq OWNED BY mbdc_calendar_topics.id;


--
-- Name: mbdc_datasource; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mbdc_datasource (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    slug character varying(50) NOT NULL,
    url character varying(200),
    description text
);


--
-- Name: mbdc_datasource_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mbdc_datasource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mbdc_datasource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mbdc_datasource_id_seq OWNED BY mbdc_datasource.id;


--
-- Name: mbdc_featured; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mbdc_featured (
    id integer NOT NULL,
    visualization_id integer NOT NULL,
    "order" integer
);


--
-- Name: mbdc_featured_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mbdc_featured_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mbdc_featured_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mbdc_featured_id_seq OWNED BY mbdc_featured.id;


--
-- Name: mbdc_hero; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mbdc_hero (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    subtitle character varying(50) NOT NULL,
    navtitle character varying(50),
    navsubtitle character varying(50),
    content text,
    image character varying(100) NOT NULL,
    "order" integer,
    active boolean NOT NULL,
    content_markup_type character varying(30) NOT NULL,
    _content_rendered text NOT NULL,
    institution_id integer DEFAULT 1
);


--
-- Name: mbdc_hero_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mbdc_hero_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mbdc_hero_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mbdc_hero_id_seq OWNED BY mbdc_hero.id;


--
-- Name: mbdc_topic; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mbdc_topic (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    slug character varying(50) NOT NULL,
    "order" integer
);


--
-- Name: mbdc_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mbdc_topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mbdc_topic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mbdc_topic_id_seq OWNED BY mbdc_topic.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    institution_id integer,
    sort_order integer,
    topic_id character varying(255),
    slug character varying(255)
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: weave_visualization; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE weave_visualization (
    id integer NOT NULL,
    title character varying(100),
    abstract text,
    owner_id integer NOT NULL,
    last_modified timestamp with time zone NOT NULL,
    sessionstate text NOT NULL,
    year character varying(50),
    original_id integer,
    featured integer,
    institution_id integer DEFAULT 1,
    permission character varying(255) DEFAULT 'private'::character varying,
    image_file_name character varying(255),
    image_content_type character varying(255),
    image_file_size integer,
    image_updated_at timestamp without time zone
);


--
-- Name: searches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW searches AS
 SELECT weave_visualization.id AS searchable_id,
    'Visualization'::text AS searchable_type,
    weave_visualization.title AS term
   FROM weave_visualization
UNION
 SELECT weave_visualization.id AS searchable_id,
    'Visualization'::text AS searchable_type,
    weave_visualization.abstract AS term
   FROM weave_visualization
UNION
 SELECT layers.id AS searchable_id,
    'Layer'::text AS searchable_type,
    layers.title AS term
   FROM layers
UNION
 SELECT layers.id AS searchable_id,
    'Layer'::text AS searchable_type,
    layers.alt_title AS term
   FROM layers
UNION
 SELECT layers.id AS searchable_id,
    'Layer'::text AS searchable_type,
    layers.descriptn AS term
   FROM layers
UNION
 SELECT mbdc_calendar.id AS searchable_id,
    'StaticMap'::text AS searchable_type,
    mbdc_calendar.title AS term
   FROM mbdc_calendar
UNION
 SELECT mbdc_calendar.id AS searchable_id,
    'StaticMap'::text AS searchable_type,
    mbdc_calendar.abstract AS term
   FROM mbdc_calendar;


--
-- Name: snapshots_regionalunit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE snapshots_regionalunit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_regionalunit; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE snapshots_regionalunit (
    id integer DEFAULT nextval('snapshots_regionalunit_id_seq'::regclass) NOT NULL,
    unitid character varying(20),
    name character varying(100) NOT NULL,
    slug character varying(50) NOT NULL,
    regiontype_id integer,
    geometry geometry NOT NULL,
    short_desc text,
    short_desc_markup_type character varying(30) NOT NULL,
    _short_desc_rendered text NOT NULL,
    subunit_ids character varying(255),
    institution_id integer,
    CONSTRAINT enforce_dims_geometry CHECK ((st_ndims(geometry) = 2)),
    CONSTRAINT enforce_geotype_geometry CHECK (((geometrytype(geometry) = 'MULTIPOLYGON'::text) OR (geometry IS NULL))),
    CONSTRAINT enforce_srid_geometry CHECK ((st_srid(geometry) = 26986))
);


--
-- Name: snapshots_visualization; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE snapshots_visualization (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    regiontype_id integer DEFAULT 1 NOT NULL,
    sessionstate character varying(100) NOT NULL,
    year character varying(20),
    overviewmap boolean NOT NULL
);


--
-- Name: snapshots_visualization_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE snapshots_visualization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_visualization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE snapshots_visualization_id_seq OWNED BY snapshots_visualization.id;


--
-- Name: snapshots_visualization_source; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE snapshots_visualization_source (
    id integer NOT NULL,
    visualization_id integer NOT NULL,
    datasource_id integer NOT NULL
);


--
-- Name: snapshots_visualization_source_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE snapshots_visualization_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_visualization_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE snapshots_visualization_source_id_seq OWNED BY snapshots_visualization_source.id;


--
-- Name: snapshots_visualization_topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE snapshots_visualization_topics (
    id integer NOT NULL,
    visualization_id integer NOT NULL,
    topic_id integer NOT NULL
);


--
-- Name: snapshots_visualization_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE snapshots_visualization_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_visualization_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE snapshots_visualization_topics_id_seq OWNED BY snapshots_visualization_topics.id;


--
-- Name: weave_visualization_datasources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE weave_visualization_datasources (
    id integer NOT NULL,
    visualization_id integer NOT NULL,
    datasource_id integer NOT NULL
);


--
-- Name: weave_visualization_datasources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE weave_visualization_datasources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: weave_visualization_datasources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE weave_visualization_datasources_id_seq OWNED BY weave_visualization_datasources.id;


--
-- Name: weave_visualization_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE weave_visualization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: weave_visualization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE weave_visualization_id_seq OWNED BY weave_visualization.id;


--
-- Name: weave_visualization_topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE weave_visualization_topics (
    id integer NOT NULL,
    visualization_id integer NOT NULL,
    topic_id integer NOT NULL
);


--
-- Name: weave_visualization_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE weave_visualization_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: weave_visualization_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE weave_visualization_topics_id_seq OWNED BY weave_visualization_topics.id;


SET search_path = metadata, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY _geo_extents ALTER COLUMN id SET DEFAULT nextval('_geo_extents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY _geo_layers ALTER COLUMN id SET DEFAULT nextval('_geo_layers_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY brandings ALTER COLUMN id SET DEFAULT nextval('brandings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY core_genericobjectrolemapping ALTER COLUMN id SET DEFAULT nextval('core_genericobjectrolemapping_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY institutions ALTER COLUMN id SET DEFAULT nextval('institutions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers ALTER COLUMN id SET DEFAULT nextval('layers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps_contact ALTER COLUMN id SET DEFAULT nextval('maps_contact_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_calendar ALTER COLUMN id SET DEFAULT nextval('mbdc_calendar_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_calendar_sources ALTER COLUMN id SET DEFAULT nextval('mbdc_calendar_sources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_calendar_topics ALTER COLUMN id SET DEFAULT nextval('mbdc_calendar_topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_datasource ALTER COLUMN id SET DEFAULT nextval('mbdc_datasource_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_featured ALTER COLUMN id SET DEFAULT nextval('mbdc_featured_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_hero ALTER COLUMN id SET DEFAULT nextval('mbdc_hero_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_topic ALTER COLUMN id SET DEFAULT nextval('mbdc_topic_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY snapshots_visualization ALTER COLUMN id SET DEFAULT nextval('snapshots_visualization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY snapshots_visualization_source ALTER COLUMN id SET DEFAULT nextval('snapshots_visualization_source_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY snapshots_visualization_topics ALTER COLUMN id SET DEFAULT nextval('snapshots_visualization_topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY weave_visualization ALTER COLUMN id SET DEFAULT nextval('weave_visualization_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY weave_visualization_datasources ALTER COLUMN id SET DEFAULT nextval('weave_visualization_datasources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY weave_visualization_topics ALTER COLUMN id SET DEFAULT nextval('weave_visualization_topics_id_seq'::regclass);


SET search_path = mapc, pg_catalog;

--
-- Name: health_births_m_pkey; Type: CONSTRAINT; Schema: mapc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY health_births_m
    ADD CONSTRAINT health_births_m_pkey PRIMARY KEY (seq_id);


SET search_path = metadata, pg_catalog;

--
-- Name: _geo_extents_geo_layers_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY _geo_extents_geo_layers
    ADD CONSTRAINT _geo_extents_geo_layers_pkey PRIMARY KEY (id);


--
-- Name: _geo_extents_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY _geo_extents
    ADD CONSTRAINT _geo_extents_pkey PRIMARY KEY (id);


--
-- Name: _geo_layers_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY _geo_layers
    ADD CONSTRAINT _geo_layers_pkey PRIMARY KEY (id);


--
-- Name: _public_tables_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY _public_tables
    ADD CONSTRAINT _public_tables_pkey PRIMARY KEY (seq_id);


--
-- Name: b01002_med_age_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b01002_med_age_acs_bg
    ADD CONSTRAINT b01002_med_age_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b01002_med_age_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b01002_med_age_acs_ct
    ADD CONSTRAINT b01002_med_age_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b01002_med_age_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b01002_med_age_acs_m
    ADD CONSTRAINT b01002_med_age_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b05002_citizenship_nativity_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b05002_citizenship_nativity_acs_ct
    ADD CONSTRAINT b05002_citizenship_nativity_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b05002_citizenship_nativity_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b05002_citizenship_nativity_acs_m
    ADD CONSTRAINT b05002_citizenship_nativity_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b05003_citizenship_nativity_by_age_gender_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b05003_citizenship_nativity_by_age_gender_acs_ct
    ADD CONSTRAINT b05003_citizenship_nativity_by_age_gender_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b05003_citizenship_nativity_by_age_gender_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b05003_citizenship_nativity_by_age_gender_acs_m
    ADD CONSTRAINT b05003_citizenship_nativity_by_age_gender_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b06009_educational_attainment_by_placeofbirth_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b06009_educational_attainment_by_placeofbirth_acs_ct
    ADD CONSTRAINT b06009_educational_attainment_by_placeofbirth_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b06009_educational_attainment_by_placeofbirth_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b06009_educational_attainment_by_placeofbirth_acs_m
    ADD CONSTRAINT b06009_educational_attainment_by_placeofbirth_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b07204_geomobility_in_migration_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b07204_geomobility_in_migration_acs_ct
    ADD CONSTRAINT b07204_geomobility_in_migration_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b07204_geomobility_in_migration_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b07204_geomobility_in_migration_acs_m
    ADD CONSTRAINT b07204_geomobility_in_migration_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b07403_geomobility_out_migration_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b07403_geomobility_out_migration_acs_m
    ADD CONSTRAINT b07403_geomobility_out_migration_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b08006_means_transportation_to_work_by_residence_gender_a_pkey1; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08006_means_transportation_to_work_by_residence_gender_acs_m
    ADD CONSTRAINT b08006_means_transportation_to_work_by_residence_gender_a_pkey1 PRIMARY KEY (orderid);


--
-- Name: b08006_means_transportation_to_work_by_residence_gender_ac_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08006_means_transportation_to_work_by_residence_gender_acs_ct
    ADD CONSTRAINT b08006_means_transportation_to_work_by_residence_gender_ac_pkey PRIMARY KEY (orderid);


--
-- Name: b08101_means_transportation_to_work_by_residence_age_acs_c_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08101_means_transportation_to_work_by_residence_age_acs_ct
    ADD CONSTRAINT b08101_means_transportation_to_work_by_residence_age_acs_c_pkey PRIMARY KEY (orderid);


--
-- Name: b08101_means_transportation_to_work_by_residence_age_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08101_means_transportation_to_work_by_residence_age_acs_m
    ADD CONSTRAINT b08101_means_transportation_to_work_by_residence_age_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b08105_means_transportation_to_work_by_residence_race_acs__pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08105_means_transportation_to_work_by_residence_race_acs_ct
    ADD CONSTRAINT b08105_means_transportation_to_work_by_residence_race_acs__pkey PRIMARY KEY (orderid);


--
-- Name: b08105_means_transportation_to_work_by_residence_race_acs_pkey1; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08105_means_transportation_to_work_by_residence_race_acs_m
    ADD CONSTRAINT b08105_means_transportation_to_work_by_residence_race_acs_pkey1 PRIMARY KEY (orderid);


--
-- Name: b08134_means_by_traveltime_to_work_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08134_means_by_traveltime_to_work_acs_bg
    ADD CONSTRAINT b08134_means_by_traveltime_to_work_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b08134_means_by_traveltime_to_work_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08134_means_by_traveltime_to_work_acs_ct
    ADD CONSTRAINT b08134_means_by_traveltime_to_work_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b08134_means_by_traveltime_to_work_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08134_means_by_traveltime_to_work_acs_m
    ADD CONSTRAINT b08134_means_by_traveltime_to_work_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b08201_hhsize_by_vehicles_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08201_hhsize_by_vehicles_acs_ct
    ADD CONSTRAINT b08201_hhsize_by_vehicles_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b08201_hhsize_by_vehicles_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08201_hhsize_by_vehicles_acs_m
    ADD CONSTRAINT b08201_hhsize_by_vehicles_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b08301_means_transportation_to_work_by_residence_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08301_means_transportation_to_work_by_residence_acs_bg
    ADD CONSTRAINT b08301_means_transportation_to_work_by_residence_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b08301_means_transportation_to_work_by_residence_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08301_means_transportation_to_work_by_residence_acs_ct
    ADD CONSTRAINT b08301_means_transportation_to_work_by_residence_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b08301_means_transportation_to_work_by_residence_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08301_means_transportation_to_work_by_residence_acs_m
    ADD CONSTRAINT b08301_means_transportation_to_work_by_residence_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b08303_traveltime_to_work_by_residence_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08303_traveltime_to_work_by_residence_acs_bg
    ADD CONSTRAINT b08303_traveltime_to_work_by_residence_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b08303_traveltime_to_work_by_residence_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08303_traveltime_to_work_by_residence_acs_ct
    ADD CONSTRAINT b08303_traveltime_to_work_by_residence_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b08303_traveltime_to_work_by_residence_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08303_traveltime_to_work_by_residence_acs_m
    ADD CONSTRAINT b08303_traveltime_to_work_by_residence_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b08601_means_transportation_to_work_by_workplace_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08601_means_transportation_to_work_by_workplace_acs_m
    ADD CONSTRAINT b08601_means_transportation_to_work_by_workplace_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b08603_traveltime_to_work_by_placeofwork_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b08603_traveltime_to_work_by_placeofwork_acs_m
    ADD CONSTRAINT b08603_traveltime_to_work_by_placeofwork_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b11005_hh_with_kids_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b11005_hh_with_kids_acs_bg
    ADD CONSTRAINT b11005_hh_with_kids_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b11005_hh_with_kids_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b11005_hh_with_kids_acs_ct
    ADD CONSTRAINT b11005_hh_with_kids_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b11005_hh_with_kids_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b11005_hh_with_kids_acs_m
    ADD CONSTRAINT b11005_hh_with_kids_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b11007_hh_with_seniors_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b11007_hh_with_seniors_acs_bg
    ADD CONSTRAINT b11007_hh_with_seniors_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b11007_hh_with_seniors_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b11007_hh_with_seniors_acs_ct
    ADD CONSTRAINT b11007_hh_with_seniors_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b11007_hh_with_seniors_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b11007_hh_with_seniors_acs_m
    ADD CONSTRAINT b11007_hh_with_seniors_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b11009_unmarried_partners_hh_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b11009_unmarried_partners_hh_acs_ct
    ADD CONSTRAINT b11009_unmarried_partners_hh_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b11009_unmarried_partners_hh_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b11009_unmarried_partners_hh_acs_m
    ADD CONSTRAINT b11009_unmarried_partners_hh_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b15001_educational_attainment_by_age_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b15001_educational_attainment_by_age_acs_ct
    ADD CONSTRAINT b15001_educational_attainment_by_age_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b15001_educational_attainment_by_age_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b15001_educational_attainment_by_age_acs_m
    ADD CONSTRAINT b15001_educational_attainment_by_age_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b15002_educational_attainment_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b15002_educational_attainment_acs_bg
    ADD CONSTRAINT b15002_educational_attainment_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b15002_educational_attainment_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b15002_educational_attainment_acs_ct
    ADD CONSTRAINT b15002_educational_attainment_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b15002_educational_attainment_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b15002_educational_attainment_acs_m
    ADD CONSTRAINT b15002_educational_attainment_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b16002_hh_linguistic_isolation_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b16002_hh_linguistic_isolation_acs_bg
    ADD CONSTRAINT b16002_hh_linguistic_isolation_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b16002_hh_linguistic_isolation_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b16002_hh_linguistic_isolation_acs_ct
    ADD CONSTRAINT b16002_hh_linguistic_isolation_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b16002_hh_linguistic_isolation_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b16002_hh_linguistic_isolation_acs_m
    ADD CONSTRAINT b16002_hh_linguistic_isolation_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b16004_home_language_english_ability_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b16004_home_language_english_ability_acs_bg
    ADD CONSTRAINT b16004_home_language_english_ability_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b16004_home_language_english_ability_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b16004_home_language_english_ability_acs_ct
    ADD CONSTRAINT b16004_home_language_english_ability_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b16004_home_language_english_ability_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b16004_home_language_english_ability_acs_m
    ADD CONSTRAINT b16004_home_language_english_ability_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b16005_nativity_english_ability_by_race_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b16005_nativity_english_ability_by_race_acs_ct
    ADD CONSTRAINT b16005_nativity_english_ability_by_race_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b16005_nativity_english_ability_by_race_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b16005_nativity_english_ability_by_race_acs_m
    ADD CONSTRAINT b16005_nativity_english_ability_by_race_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b17001_poverty_by_age_gender_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17001_poverty_by_age_gender_acs_ct
    ADD CONSTRAINT b17001_poverty_by_age_gender_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b17001_poverty_by_age_gender_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17001_poverty_by_age_gender_acs_m
    ADD CONSTRAINT b17001_poverty_by_age_gender_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b17001_povertypopulation_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17001_povertypopulation_acs_ct
    ADD CONSTRAINT b17001_povertypopulation_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b17001_povertypopulation_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17001_povertypopulation_acs_m
    ADD CONSTRAINT b17001_povertypopulation_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b17006_child_poverty_by_familytype_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17006_child_poverty_by_familytype_acs_ct
    ADD CONSTRAINT b17006_child_poverty_by_familytype_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b17006_child_poverty_by_familytype_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17006_child_poverty_by_familytype_acs_m
    ADD CONSTRAINT b17006_child_poverty_by_familytype_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b17010_families_with_children_in_poverty_by_familytype_ra_pkey1; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17010_families_with_children_in_poverty_by_familytype_race_ct
    ADD CONSTRAINT b17010_families_with_children_in_poverty_by_familytype_ra_pkey1 PRIMARY KEY (orderid);


--
-- Name: b17010_families_with_children_in_poverty_by_familytype_ra_pkey2; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17010_families_with_children_in_poverty_by_familytype_race_m
    ADD CONSTRAINT b17010_families_with_children_in_poverty_by_familytype_ra_pkey2 PRIMARY KEY (orderid);


--
-- Name: b17010_families_with_children_in_poverty_by_familytype_rac_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17010_families_with_children_in_poverty_by_familytype_race_bg
    ADD CONSTRAINT b17010_families_with_children_in_poverty_by_familytype_rac_pkey PRIMARY KEY (orderid);


--
-- Name: b17017_poverty_by_hh_type_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17017_poverty_by_hh_type_acs_bg
    ADD CONSTRAINT b17017_poverty_by_hh_type_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b17017_poverty_by_hh_type_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17017_poverty_by_hh_type_acs_ct
    ADD CONSTRAINT b17017_poverty_by_hh_type_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b17017_poverty_by_hh_type_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17017_poverty_by_hh_type_acs_m
    ADD CONSTRAINT b17017_poverty_by_hh_type_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b17020_poverty_by_race_age_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17020_poverty_by_race_age_acs_ct
    ADD CONSTRAINT b17020_poverty_by_race_age_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b17020_poverty_by_race_age_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b17020_poverty_by_race_age_acs_m
    ADD CONSTRAINT b17020_poverty_by_race_age_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b19001_hh_income_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19001_hh_income_acs_bg
    ADD CONSTRAINT b19001_hh_income_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b19001_hh_income_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19001_hh_income_acs_ct
    ADD CONSTRAINT b19001_hh_income_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b19001_hh_income_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19001_hh_income_acs_m
    ADD CONSTRAINT b19001_hh_income_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b19013_b19113_b19202_mhi_fam_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19013_b19113_b19202_mhi_fam_acs_bg
    ADD CONSTRAINT b19013_b19113_b19202_mhi_fam_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b19013_b19113_b19202_mhi_fam_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19013_b19113_b19202_mhi_fam_acs_ct
    ADD CONSTRAINT b19013_b19113_b19202_mhi_fam_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b19013_b19113_b19202_mhi_fam_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19013_b19113_b19202_mhi_fam_acs_m
    ADD CONSTRAINT b19013_b19113_b19202_mhi_fam_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b19013_mhi_race_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19013_mhi_race_acs_bg
    ADD CONSTRAINT b19013_mhi_race_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b19013_mhi_race_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19013_mhi_race_acs_ct
    ADD CONSTRAINT b19013_mhi_race_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b19013_mhi_race_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19013_mhi_race_acs_m
    ADD CONSTRAINT b19013_mhi_race_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b19037_hh_income_by_age_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19037_hh_income_by_age_acs_bg
    ADD CONSTRAINT b19037_hh_income_by_age_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b19037_hh_income_by_age_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19037_hh_income_by_age_acs_ct
    ADD CONSTRAINT b19037_hh_income_by_age_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b19037_hh_income_by_age_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19037_hh_income_by_age_acs_m
    ADD CONSTRAINT b19037_hh_income_by_age_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b19058_public_assist_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19058_public_assist_acs_ct
    ADD CONSTRAINT b19058_public_assist_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b19058_public_assist_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19058_public_assist_acs_m
    ADD CONSTRAINT b19058_public_assist_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b19083_gini_index_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19083_gini_index_acs_ct
    ADD CONSTRAINT b19083_gini_index_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b19083_gini_index_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19083_gini_index_acs_m
    ADD CONSTRAINT b19083_gini_index_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b19301_per_capita_income_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19301_per_capita_income_acs_bg
    ADD CONSTRAINT b19301_per_capita_income_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b19301_per_capita_income_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19301_per_capita_income_acs_ct
    ADD CONSTRAINT b19301_per_capita_income_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b19301_per_capita_income_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b19301_per_capita_income_acs_m
    ADD CONSTRAINT b19301_per_capita_income_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b22003_b22005_hh_foodstamps_snap_by_race_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b22003_b22005_hh_foodstamps_snap_by_race_acs_ct
    ADD CONSTRAINT b22003_b22005_hh_foodstamps_snap_by_race_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b22003_b22005_hh_foodstamps_snap_by_race_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b22003_b22005_hh_foodstamps_snap_by_race_acs_m
    ADD CONSTRAINT b22003_b22005_hh_foodstamps_snap_by_race_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b23006_educational_attainment_by_laborforce_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b23006_educational_attainment_by_laborforce_ct
    ADD CONSTRAINT b23006_educational_attainment_by_laborforce_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b23006_educational_attainment_by_laborforce_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b23006_educational_attainment_by_laborforce_m
    ADD CONSTRAINT b23006_educational_attainment_by_laborforce_m_pkey PRIMARY KEY (orderid);


--
-- Name: b23025_employment_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b23025_employment_acs_bg
    ADD CONSTRAINT b23025_employment_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b23025_employment_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b23025_employment_acs_ct
    ADD CONSTRAINT b23025_employment_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b23025_employment_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b23025_employment_acs_m
    ADD CONSTRAINT b23025_employment_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25002_b25003_hu_occupancy_by_tenure_race_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25002_b25003_hu_occupancy_by_tenure_race_acs_bg
    ADD CONSTRAINT b25002_b25003_hu_occupancy_by_tenure_race_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b25002_b25003_hu_occupancy_by_tenure_race_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25002_b25003_hu_occupancy_by_tenure_race_acs_ct
    ADD CONSTRAINT b25002_b25003_hu_occupancy_by_tenure_race_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25002_b25003_hu_occupancy_by_tenure_race_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25002_b25003_hu_occupancy_by_tenure_race_acs_m
    ADD CONSTRAINT b25002_b25003_hu_occupancy_by_tenure_race_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25024_hu_units_in_structure_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25024_hu_units_in_structure_acs_bg
    ADD CONSTRAINT b25024_hu_units_in_structure_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b25024_hu_units_in_structure_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25024_hu_units_in_structure_acs_ct
    ADD CONSTRAINT b25024_hu_units_in_structure_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25024_hu_units_in_structure_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25024_hu_units_in_structure_acs_m
    ADD CONSTRAINT b25024_hu_units_in_structure_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25032_hu_tenure_by_units_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25032_hu_tenure_by_units_acs_bg
    ADD CONSTRAINT b25032_hu_tenure_by_units_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b25032_hu_tenure_by_units_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25032_hu_tenure_by_units_acs_ct
    ADD CONSTRAINT b25032_hu_tenure_by_units_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25032_hu_tenure_by_units_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25032_hu_tenure_by_units_acs_m
    ADD CONSTRAINT b25032_hu_tenure_by_units_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25044_hu_vehicles_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25044_hu_vehicles_acs_bg
    ADD CONSTRAINT b25044_hu_vehicles_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b25044_hu_vehicles_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25044_hu_vehicles_acs_ct
    ADD CONSTRAINT b25044_hu_vehicles_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25044_hu_vehicles_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25044_hu_vehicles_acs_m
    ADD CONSTRAINT b25044_hu_vehicles_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25056_b25058_contract_rent_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25056_b25058_contract_rent_acs_bg
    ADD CONSTRAINT b25056_b25058_contract_rent_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b25056_b25058_contract_rent_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25056_b25058_contract_rent_acs_ct
    ADD CONSTRAINT b25056_b25058_contract_rent_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25056_b25058_contract_rent_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25056_b25058_contract_rent_acs_m
    ADD CONSTRAINT b25056_b25058_contract_rent_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25063_b25064_b25065_rent_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25063_b25064_b25065_rent_acs_bg
    ADD CONSTRAINT b25063_b25064_b25065_rent_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b25063_b25064_b25065_rent_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25063_b25064_b25065_rent_acs_ct
    ADD CONSTRAINT b25063_b25064_b25065_rent_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25063_b25064_b25065_rent_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25063_b25064_b25065_rent_acs_m
    ADD CONSTRAINT b25063_b25064_b25065_rent_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25072_b25093_costburden_by_age_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25072_b25093_costburden_by_age_acs_bg
    ADD CONSTRAINT b25072_b25093_costburden_by_age_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b25072_b25093_costburden_by_age_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25072_b25093_costburden_by_age_acs_ct
    ADD CONSTRAINT b25072_b25093_costburden_by_age_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25072_b25093_costburden_by_age_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25072_b25093_costburden_by_age_acs_m
    ADD CONSTRAINT b25072_b25093_costburden_by_age_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25074_costburden_renters_by_income_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25074_costburden_renters_by_income_acs_bg
    ADD CONSTRAINT b25074_costburden_renters_by_income_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b25074_costburden_renters_by_income_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25074_costburden_renters_by_income_acs_ct
    ADD CONSTRAINT b25074_costburden_renters_by_income_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25074_costburden_renters_by_income_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25074_costburden_renters_by_income_acs_m
    ADD CONSTRAINT b25074_costburden_renters_by_income_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25091_b25070_costburden_acs_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25091_b25070_costburden_acs_bg
    ADD CONSTRAINT b25091_b25070_costburden_acs_bg_pkey PRIMARY KEY (orderid);


--
-- Name: b25091_b25070_costburden_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25091_b25070_costburden_acs_ct
    ADD CONSTRAINT b25091_b25070_costburden_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25091_b25070_costburden_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25091_b25070_costburden_acs_m
    ADD CONSTRAINT b25091_b25070_costburden_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25097_median_value_by_mortgage_status_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25097_median_value_by_mortgage_status_acs_ct
    ADD CONSTRAINT b25097_median_value_by_mortgage_status_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25097_median_value_by_mortgage_status_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25097_median_value_by_mortgage_status_acs_m
    ADD CONSTRAINT b25097_median_value_by_mortgage_status_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25106_costburden_by_income_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25106_costburden_by_income_acs_ct
    ADD CONSTRAINT b25106_costburden_by_income_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25106_costburden_by_income_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25106_costburden_by_income_acs_m
    ADD CONSTRAINT b25106_costburden_by_income_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25117_hu_tenure_by_fuel_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25117_hu_tenure_by_fuel_acs_ct
    ADD CONSTRAINT b25117_hu_tenure_by_fuel_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25117_hu_tenure_by_fuel_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25117_hu_tenure_by_fuel_acs_m
    ADD CONSTRAINT b25117_hu_tenure_by_fuel_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25119_mhi_tenure_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25119_mhi_tenure_acs_ct
    ADD CONSTRAINT b25119_mhi_tenure_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25119_mhi_tenure_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25119_mhi_tenure_acs_m
    ADD CONSTRAINT b25119_mhi_tenure_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b25127_hu_tenure_year_built_units_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25127_hu_tenure_year_built_units_acs_ct
    ADD CONSTRAINT b25127_hu_tenure_year_built_units_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b25127_hu_tenure_year_built_units_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b25127_hu_tenure_year_built_units_acs_m
    ADD CONSTRAINT b25127_hu_tenure_year_built_units_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: b27001_healthinsurance_by_gender_age_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b27001_healthinsurance_by_gender_age_acs_ct
    ADD CONSTRAINT b27001_healthinsurance_by_gender_age_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: b27001_healthinsurance_by_gender_age_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY b27001_healthinsurance_by_gender_age_acs_m
    ADD CONSTRAINT b27001_healthinsurance_by_gender_age_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: c15002_educational_attainment_by_race_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY c15002_educational_attainment_by_race_acs_ct
    ADD CONSTRAINT c15002_educational_attainment_by_race_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: c15002_educational_attainment_by_race_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY c15002_educational_attainment_by_race_acs_m
    ADD CONSTRAINT c15002_educational_attainment_by_race_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: c23002_employment_by_race_age_acs_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY c23002_employment_by_race_age_acs_ct
    ADD CONSTRAINT c23002_employment_by_race_age_acs_ct_pkey PRIMARY KEY (orderid);


--
-- Name: c23002_employment_by_race_age_acs_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY c23002_employment_by_race_age_acs_m
    ADD CONSTRAINT c23002_employment_by_race_age_acs_m_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p12_pop_by_age_b_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p12_pop_by_age_b
    ADD CONSTRAINT census2010_p12_pop_by_age_b_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p12_pop_by_age_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p12_pop_by_age_bg
    ADD CONSTRAINT census2010_p12_pop_by_age_bg_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p12_pop_by_age_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p12_pop_by_age_ct
    ADD CONSTRAINT census2010_p12_pop_by_age_ct_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p12_pop_by_age_gender_b_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p12_pop_by_age_gender_b
    ADD CONSTRAINT census2010_p12_pop_by_age_gender_b_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p12_pop_by_age_gender_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p12_pop_by_age_gender_bg
    ADD CONSTRAINT census2010_p12_pop_by_age_gender_bg_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p12_pop_by_age_gender_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p12_pop_by_age_gender_ct
    ADD CONSTRAINT census2010_p12_pop_by_age_gender_ct_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p12_pop_by_age_gender_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p12_pop_by_age_gender_m
    ADD CONSTRAINT census2010_p12_pop_by_age_gender_m_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_b_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p20_hh_with_kids_by_hhtype_b
    ADD CONSTRAINT census2010_p20_hh_with_kids_by_hhtype_b_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p20_hh_with_kids_by_hhtype_bg
    ADD CONSTRAINT census2010_p20_hh_with_kids_by_hhtype_bg_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p20_hh_with_kids_by_hhtype_ct
    ADD CONSTRAINT census2010_p20_hh_with_kids_by_hhtype_ct_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p20_hh_with_kids_by_hhtype_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p20_hh_with_kids_by_hhtype_m
    ADD CONSTRAINT census2010_p20_hh_with_kids_by_hhtype_m_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p25_hh_type_size_b_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p25_hh_type_size_b
    ADD CONSTRAINT census2010_p25_hh_type_size_b_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p25_hh_type_size_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p25_hh_type_size_bg
    ADD CONSTRAINT census2010_p25_hh_type_size_bg_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p25_hh_type_size_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p25_hh_type_size_ct
    ADD CONSTRAINT census2010_p25_hh_type_size_ct_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p3_race_b_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p3_race_b
    ADD CONSTRAINT census2010_p3_race_b_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p3_race_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p3_race_bg
    ADD CONSTRAINT census2010_p3_race_bg_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p3_race_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p3_race_ct
    ADD CONSTRAINT census2010_p3_race_ct_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p3_race_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p3_race_m
    ADD CONSTRAINT census2010_p3_race_m_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p5_race_ethnicity_b_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p5_race_ethnicity_b
    ADD CONSTRAINT census2010_p5_race_ethnicity_b_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p5_race_ethnicity_bg_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p5_race_ethnicity_bg
    ADD CONSTRAINT census2010_p5_race_ethnicity_bg_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p5_race_ethnicity_ct_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p5_race_ethnicity_ct
    ADD CONSTRAINT census2010_p5_race_ethnicity_ct_pkey PRIMARY KEY (orderid);


--
-- Name: census2010_p5_race_ethnicity_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY census2010_p5_race_ethnicity_m
    ADD CONSTRAINT census2010_p5_race_ethnicity_m_pkey PRIMARY KEY (orderid);


--
-- Name: demo_population_by_decade_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY demo_population_by_decade_m
    ADD CONSTRAINT demo_population_by_decade_m_pkey PRIMARY KEY (orderid);


--
-- Name: demo_population_minorities_00_10_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY demo_population_minorities_00_10_m
    ADD CONSTRAINT demo_population_minorities_00_10_m_pkey PRIMARY KEY (orderid);


--
-- Name: demo_population_over_under18_10m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY demo_population_over_under18_10m
    ADD CONSTRAINT demo_population_over_under18_10m_pkey PRIMARY KEY (orderid);


--
-- Name: econ_unemployment_by_year_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY econ_unemployment_by_year_m
    ADD CONSTRAINT econ_unemployment_by_year_m_pkey PRIMARY KEY (orderid);


--
-- Name: educ_enrollment_by_year_districts_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY educ_enrollment_by_year_districts
    ADD CONSTRAINT educ_enrollment_by_year_districts_pkey PRIMARY KEY (orderid);


--
-- Name: educ_enrollment_by_year_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY educ_enrollment_by_year_m
    ADD CONSTRAINT educ_enrollment_by_year_m_pkey PRIMARY KEY (orderid);


--
-- Name: educ_enrollment_by_year_schools_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY educ_enrollment_by_year_schools
    ADD CONSTRAINT educ_enrollment_by_year_schools_pkey PRIMARY KEY (orderid);


--
-- Name: health_births_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY health_births_m
    ADD CONSTRAINT health_births_m_pkey PRIMARY KEY (orderid);


--
-- Name: hous_hh_fam_00_10m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hous_hh_fam_00_10m
    ADD CONSTRAINT hous_hh_fam_00_10m_pkey PRIMARY KEY (orderid);


--
-- Name: hous_table7_hh_ami_by_cb_chas_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hous_table7_hh_ami_by_cb_chas_m
    ADD CONSTRAINT hous_table7_hh_ami_by_cb_chas_m_pkey PRIMARY KEY (orderid);


--
-- Name: hous_table7_hh_income_by_hh_type_chas_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hous_table7_hh_income_by_hh_type_chas_m
    ADD CONSTRAINT hous_table7_hh_income_by_hh_type_chas_m_pkey PRIMARY KEY (orderid);


--
-- Name: hous_table7_hh_type_by_cb_chas_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hous_table7_hh_type_by_cb_chas_m
    ADD CONSTRAINT hous_table7_hh_type_by_cb_chas_m_pkey PRIMARY KEY (orderid);


--
-- Name: trans_crashes_by_year_m_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trans_crashes_by_year_m
    ADD CONSTRAINT trans_crashes_by_year_m_pkey PRIMARY KEY (orderid);


SET search_path = public, pg_catalog;

--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: brandings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY brandings
    ADD CONSTRAINT brandings_pkey PRIMARY KEY (id);


--
-- Name: core_genericobjectrolemapping_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY core_genericobjectrolemapping
    ADD CONSTRAINT core_genericobjectrolemapping_pkey PRIMARY KEY (id);


--
-- Name: core_genericobjectrolemapping_subject_object_ct_id_object_i_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY core_genericobjectrolemapping
    ADD CONSTRAINT core_genericobjectrolemapping_subject_object_ct_id_object_i_key UNIQUE (subject, object_ct_id, object_id, role_id);


--
-- Name: institutions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY institutions
    ADD CONSTRAINT institutions_pkey PRIMARY KEY (id);


--
-- Name: layers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY layers
    ADD CONSTRAINT layers_pkey PRIMARY KEY (id);


--
-- Name: maps_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY maps_contact
    ADD CONSTRAINT maps_contact_pkey PRIMARY KEY (id);


--
-- Name: mbdc_calendar_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mbdc_calendar
    ADD CONSTRAINT mbdc_calendar_pkey PRIMARY KEY (id);


--
-- Name: mbdc_calendar_sources_calendar_id_4b0d4bdf31ddc740_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mbdc_calendar_sources
    ADD CONSTRAINT mbdc_calendar_sources_calendar_id_4b0d4bdf31ddc740_uniq UNIQUE (calendar_id, datasource_id);


--
-- Name: mbdc_calendar_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mbdc_calendar_sources
    ADD CONSTRAINT mbdc_calendar_sources_pkey PRIMARY KEY (id);


--
-- Name: mbdc_calendar_topics_calendar_id_38f0752a22458442_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mbdc_calendar_topics
    ADD CONSTRAINT mbdc_calendar_topics_calendar_id_38f0752a22458442_uniq UNIQUE (calendar_id, topic_id);


--
-- Name: mbdc_calendar_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mbdc_calendar_topics
    ADD CONSTRAINT mbdc_calendar_topics_pkey PRIMARY KEY (id);


--
-- Name: mbdc_datasource_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mbdc_datasource
    ADD CONSTRAINT mbdc_datasource_pkey PRIMARY KEY (id);


--
-- Name: mbdc_featured_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mbdc_featured
    ADD CONSTRAINT mbdc_featured_pkey PRIMARY KEY (id);


--
-- Name: mbdc_hero_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mbdc_hero
    ADD CONSTRAINT mbdc_hero_pkey PRIMARY KEY (id);


--
-- Name: mbdc_topic_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mbdc_topic
    ADD CONSTRAINT mbdc_topic_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: snapshots_regionalunit_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY snapshots_regionalunit
    ADD CONSTRAINT snapshots_regionalunit_pkey PRIMARY KEY (id);


--
-- Name: snapshots_visualization__visualization_id_34c1e30e30858e56_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY snapshots_visualization_topics
    ADD CONSTRAINT snapshots_visualization__visualization_id_34c1e30e30858e56_uniq UNIQUE (visualization_id, topic_id);


--
-- Name: snapshots_visualization__visualization_id_7697a44685099f5a_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY snapshots_visualization_source
    ADD CONSTRAINT snapshots_visualization__visualization_id_7697a44685099f5a_uniq UNIQUE (visualization_id, datasource_id);


--
-- Name: snapshots_visualization_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY snapshots_visualization
    ADD CONSTRAINT snapshots_visualization_pkey PRIMARY KEY (id);


--
-- Name: snapshots_visualization_source_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY snapshots_visualization_source
    ADD CONSTRAINT snapshots_visualization_source_pkey PRIMARY KEY (id);


--
-- Name: snapshots_visualization_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY snapshots_visualization_topics
    ADD CONSTRAINT snapshots_visualization_topics_pkey PRIMARY KEY (id);


--
-- Name: weave_visualization_data_visualization_id_7910f94c368bebdd_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY weave_visualization_datasources
    ADD CONSTRAINT weave_visualization_data_visualization_id_7910f94c368bebdd_uniq UNIQUE (visualization_id, datasource_id);


--
-- Name: weave_visualization_datasources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY weave_visualization_datasources
    ADD CONSTRAINT weave_visualization_datasources_pkey PRIMARY KEY (id);


--
-- Name: weave_visualization_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY weave_visualization
    ADD CONSTRAINT weave_visualization_pkey PRIMARY KEY (id);


--
-- Name: weave_visualization_topi_visualization_id_1f3c9f406802bc09_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY weave_visualization_topics
    ADD CONSTRAINT weave_visualization_topi_visualization_id_1f3c9f406802bc09_uniq UNIQUE (visualization_id, topic_id);


--
-- Name: weave_visualization_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY weave_visualization_topics
    ADD CONSTRAINT weave_visualization_topics_pkey PRIMARY KEY (id);


--
-- Name: core_genericobjectrolemapping_object_ct_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX core_genericobjectrolemapping_object_ct_id ON core_genericobjectrolemapping USING btree (object_ct_id);


--
-- Name: core_genericobjectrolemapping_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX core_genericobjectrolemapping_role_id ON core_genericobjectrolemapping USING btree (role_id);


--
-- Name: index_auth_user_on_remember_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_auth_user_on_remember_token ON auth_user USING btree (remember_token);


--
-- Name: index_layers_on_alt_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_layers_on_alt_title ON layers USING gin (to_tsvector('english'::regconfig, (alt_title)::text));


--
-- Name: index_layers_on_descriptn; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_layers_on_descriptn ON layers USING gin (to_tsvector('english'::regconfig, (descriptn)::text));


--
-- Name: index_layers_on_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_layers_on_title ON layers USING gin (to_tsvector('english'::regconfig, (title)::text));


--
-- Name: index_mbdc_calendar_on_abstract; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mbdc_calendar_on_abstract ON mbdc_calendar USING gin (to_tsvector('english'::regconfig, abstract));


--
-- Name: index_mbdc_calendar_on_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mbdc_calendar_on_title ON mbdc_calendar USING gin (to_tsvector('english'::regconfig, (title)::text));


--
-- Name: index_weave_visualization_on_abstract; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_weave_visualization_on_abstract ON weave_visualization USING gin (to_tsvector('english'::regconfig, abstract));


--
-- Name: index_weave_visualization_on_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_weave_visualization_on_title ON weave_visualization USING gin (to_tsvector('english'::regconfig, (title)::text));


--
-- Name: maps_contact_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX maps_contact_user_id ON maps_contact USING btree (user_id);


--
-- Name: mbdc_calendar_sources_calendar_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_calendar_sources_calendar_id ON mbdc_calendar_sources USING btree (calendar_id);


--
-- Name: mbdc_calendar_sources_datasource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_calendar_sources_datasource_id ON mbdc_calendar_sources USING btree (datasource_id);


--
-- Name: mbdc_calendar_topics_calendar_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_calendar_topics_calendar_id ON mbdc_calendar_topics USING btree (calendar_id);


--
-- Name: mbdc_calendar_topics_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_calendar_topics_topic_id ON mbdc_calendar_topics USING btree (topic_id);


--
-- Name: mbdc_datasource_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_datasource_slug ON mbdc_datasource USING btree (slug);


--
-- Name: mbdc_datasource_slug_like; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_datasource_slug_like ON mbdc_datasource USING btree (slug varchar_pattern_ops);


--
-- Name: mbdc_featured_visualization_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_featured_visualization_id ON mbdc_featured USING btree (visualization_id);


--
-- Name: mbdc_topic_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_topic_slug ON mbdc_topic USING btree (slug);


--
-- Name: mbdc_topic_slug_like; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_topic_slug_like ON mbdc_topic USING btree (slug varchar_pattern_ops);


--
-- Name: snapshots_regionalunit_geometry_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX snapshots_regionalunit_geometry_id ON snapshots_regionalunit USING gist (geometry);


--
-- Name: snapshots_regionalunit_regiontype_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX snapshots_regionalunit_regiontype_id ON snapshots_regionalunit USING btree (regiontype_id);


--
-- Name: snapshots_regionalunit_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX snapshots_regionalunit_slug ON snapshots_regionalunit USING btree (slug);


--
-- Name: snapshots_regionalunit_slug_like; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX snapshots_regionalunit_slug_like ON snapshots_regionalunit USING btree (slug varchar_pattern_ops);


--
-- Name: snapshots_visualization_regiontype_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX snapshots_visualization_regiontype_id ON snapshots_visualization USING btree (regiontype_id);


--
-- Name: snapshots_visualization_source_datasource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX snapshots_visualization_source_datasource_id ON snapshots_visualization_source USING btree (datasource_id);


--
-- Name: snapshots_visualization_source_visualization_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX snapshots_visualization_source_visualization_id ON snapshots_visualization_source USING btree (visualization_id);


--
-- Name: snapshots_visualization_topics_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX snapshots_visualization_topics_topic_id ON snapshots_visualization_topics USING btree (topic_id);


--
-- Name: snapshots_visualization_topics_visualization_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX snapshots_visualization_topics_visualization_id ON snapshots_visualization_topics USING btree (visualization_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: weave_visualization_datasources_datasource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX weave_visualization_datasources_datasource_id ON weave_visualization_datasources USING btree (datasource_id);


--
-- Name: weave_visualization_datasources_visualization_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX weave_visualization_datasources_visualization_id ON weave_visualization_datasources USING btree (visualization_id);


--
-- Name: weave_visualization_original_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX weave_visualization_original_id ON weave_visualization USING btree (original_id);


--
-- Name: weave_visualization_owner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX weave_visualization_owner_id ON weave_visualization USING btree (owner_id);


--
-- Name: weave_visualization_topics_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX weave_visualization_topics_topic_id ON weave_visualization_topics USING btree (topic_id);


--
-- Name: weave_visualization_topics_visualization_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX weave_visualization_topics_visualization_id ON weave_visualization_topics USING btree (visualization_id);


--
-- Name: calendar_id_refs_id_4443fd67cb277315; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_calendar_topics
    ADD CONSTRAINT calendar_id_refs_id_4443fd67cb277315 FOREIGN KEY (calendar_id) REFERENCES mbdc_calendar(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: calendar_id_refs_id_7b51d4ba3e26ac34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_calendar_sources
    ADD CONSTRAINT calendar_id_refs_id_7b51d4ba3e26ac34 FOREIGN KEY (calendar_id) REFERENCES mbdc_calendar(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datasource_id_refs_id_18a2c6b93711440f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_calendar_sources
    ADD CONSTRAINT datasource_id_refs_id_18a2c6b93711440f FOREIGN KEY (datasource_id) REFERENCES mbdc_datasource(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datasource_id_refs_id_2b8b07c52842bd83; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY weave_visualization_datasources
    ADD CONSTRAINT datasource_id_refs_id_2b8b07c52842bd83 FOREIGN KEY (datasource_id) REFERENCES mbdc_datasource(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: original_id_refs_id_539bb75080c6df55; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY weave_visualization
    ADD CONSTRAINT original_id_refs_id_539bb75080c6df55 FOREIGN KEY (original_id) REFERENCES weave_visualization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: topic_id_refs_id_554d76c4e159a617; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_calendar_topics
    ADD CONSTRAINT topic_id_refs_id_554d76c4e159a617 FOREIGN KEY (topic_id) REFERENCES mbdc_topic(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: topic_id_refs_id_717e34d592f66485; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY weave_visualization_topics
    ADD CONSTRAINT topic_id_refs_id_717e34d592f66485 FOREIGN KEY (topic_id) REFERENCES mbdc_topic(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: topic_id_refs_id_a8572218e6e7b7c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY snapshots_visualization_topics
    ADD CONSTRAINT topic_id_refs_id_a8572218e6e7b7c FOREIGN KEY (topic_id) REFERENCES mbdc_topic(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: visualization_id_refs_id_150b8413ab5897b9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY snapshots_visualization_topics
    ADD CONSTRAINT visualization_id_refs_id_150b8413ab5897b9 FOREIGN KEY (visualization_id) REFERENCES snapshots_visualization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: visualization_id_refs_id_17183d0f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mbdc_featured
    ADD CONSTRAINT visualization_id_refs_id_17183d0f FOREIGN KEY (visualization_id) REFERENCES weave_visualization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: visualization_id_refs_id_4779ee3461d3a108; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY snapshots_visualization_source
    ADD CONSTRAINT visualization_id_refs_id_4779ee3461d3a108 FOREIGN KEY (visualization_id) REFERENCES snapshots_visualization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140901170947');

INSERT INTO schema_migrations (version) VALUES ('20140901172554');

INSERT INTO schema_migrations (version) VALUES ('20140901172655');

INSERT INTO schema_migrations (version) VALUES ('20140901173645');

INSERT INTO schema_migrations (version) VALUES ('20140901192441');

INSERT INTO schema_migrations (version) VALUES ('20140901192800');

INSERT INTO schema_migrations (version) VALUES ('20140901200621');

INSERT INTO schema_migrations (version) VALUES ('20140901211355');

INSERT INTO schema_migrations (version) VALUES ('20140902182153');

INSERT INTO schema_migrations (version) VALUES ('20140903002213');

INSERT INTO schema_migrations (version) VALUES ('20140903033148');

INSERT INTO schema_migrations (version) VALUES ('20140904030546');

INSERT INTO schema_migrations (version) VALUES ('20140904031000');

INSERT INTO schema_migrations (version) VALUES ('20140905131353');

INSERT INTO schema_migrations (version) VALUES ('20140905142405');

INSERT INTO schema_migrations (version) VALUES ('20140909152215');

INSERT INTO schema_migrations (version) VALUES ('20141021182918');

INSERT INTO schema_migrations (version) VALUES ('20141021183232');

INSERT INTO schema_migrations (version) VALUES ('20141031173625');

INSERT INTO schema_migrations (version) VALUES ('20141121191140');

INSERT INTO schema_migrations (version) VALUES ('20141121215139');

