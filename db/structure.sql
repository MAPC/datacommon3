--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

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
    region_id integer,
    logo_file_name character varying(255),
    logo_content_type character varying(255),
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    retina_dimensions text
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
    institution_id integer DEFAULT 1,
    map_file_name character varying(255),
    map_content_type character varying(255),
    map_file_size integer,
    map_updated_at timestamp without time zone
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
    overviewmap boolean NOT NULL,
    session_state_file_name character varying(255),
    session_state_content_type character varying(255),
    session_state_file_size integer,
    session_state_updated_at timestamp without time zone
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

SET search_path TO datacommon,public;

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

INSERT INTO schema_migrations (version) VALUES ('20141121234755');

INSERT INTO schema_migrations (version) VALUES ('20141122001639');

INSERT INTO schema_migrations (version) VALUES ('20141124155210');

INSERT INTO schema_migrations (version) VALUES ('20141124161012');

INSERT INTO schema_migrations (version) VALUES ('20141203220622');

INSERT INTO schema_migrations (version) VALUES ('20141203222803');

INSERT INTO schema_migrations (version) VALUES ('20141204151129');

INSERT INTO schema_migrations (version) VALUES ('20141204151557');

