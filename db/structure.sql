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
    password_digest character varying(128) NOT NULL,
    is_staff boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    is_superuser boolean DEFAULT false NOT NULL,
    last_login timestamp without time zone DEFAULT ('now'::text)::date NOT NULL,
    date_joined timestamp without time zone DEFAULT ('now'::text)::date NOT NULL,
    remember_digest character varying(255),
    activation_digest character varying(255),
    activated_at timestamp without time zone,
    reset_digest character varying(255),
    reset_sent_at timestamp without time zone,
    activation_token character varying(255),
    reset_token character varying(255)
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
    logos text DEFAULT '[]'::text,
    address character varying(255),
    phone_number character varying(255),
    email character varying(255)
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
    role_id integer NOT NULL
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
    last_modified timestamp without time zone DEFAULT ('now'::text)::date NOT NULL
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
-- Name: snapshots_regionalunit; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE snapshots_regionalunit (
    id integer NOT NULL,
    unitid character varying(255),
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    regiontype_id integer,
    geometry geometry NOT NULL,
    short_desc text,
    short_desc_markup_type character varying(255) NOT NULL,
    _short_desc_rendered text NOT NULL,
    subunit_ids character varying(255),
    institution_id integer DEFAULT 1
);


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
-- Name: snapshots_regionalunit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE snapshots_regionalunit_id_seq OWNED BY snapshots_regionalunit.id;


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
-- Name: weave_visualization; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE weave_visualization (
    id integer NOT NULL,
    title character varying(100),
    abstract text,
    owner_id integer NOT NULL,
    last_modified timestamp without time zone NOT NULL,
    sessionstate text NOT NULL,
    year character varying(50),
    original_id integer,
    featured integer,
    institution_id integer DEFAULT 1,
    permission character varying(255) DEFAULT 'public'::character varying,
    image_file_name character varying(255),
    image_content_type character varying(255),
    image_file_size integer,
    image_updated_at timestamp without time zone
);


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

ALTER TABLE ONLY snapshots_regionalunit ALTER COLUMN id SET DEFAULT nextval('snapshots_regionalunit_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY snapshots_visualization ALTER COLUMN id SET DEFAULT nextval('snapshots_visualization_id_seq'::regclass);


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
-- Name: institutions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY institutions
    ADD CONSTRAINT institutions_pkey PRIMARY KEY (id);


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
-- Name: mbdc_calendar_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mbdc_calendar_sources
    ADD CONSTRAINT mbdc_calendar_sources_pkey PRIMARY KEY (id);


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
-- Name: snapshots_visualization_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY snapshots_visualization
    ADD CONSTRAINT snapshots_visualization_pkey PRIMARY KEY (id);


--
-- Name: snapshots_visualization_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY snapshots_visualization_topics
    ADD CONSTRAINT snapshots_visualization_topics_pkey PRIMARY KEY (id);


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
-- Name: weave_visualization_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY weave_visualization_topics
    ADD CONSTRAINT weave_visualization_topics_pkey PRIMARY KEY (id);


--
-- Name: auth_user_username_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX auth_user_username_key ON auth_user USING btree (username);


--
-- Name: core_genericobjectrolemapping_object_ct_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX core_genericobjectrolemapping_object_ct_id ON core_genericobjectrolemapping USING btree (object_ct_id);


--
-- Name: core_genericobjectrolemapping_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX core_genericobjectrolemapping_role_id ON core_genericobjectrolemapping USING btree (role_id);


--
-- Name: core_genericobjectrolemapping_subject_object_ct_id_object_i_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX core_genericobjectrolemapping_subject_object_ct_id_object_i_key ON core_genericobjectrolemapping USING btree (subject, object_ct_id, object_id, role_id);


--
-- Name: index_auth_user_on_remember_digest; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_auth_user_on_remember_digest ON auth_user USING btree (remember_digest);


--
-- Name: maps_contact_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX maps_contact_user_id ON maps_contact USING btree (user_id);


--
-- Name: mbdc_calendar_sources_calendar_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_calendar_sources_calendar_id ON mbdc_calendar_sources USING btree (calendar_id);


--
-- Name: mbdc_calendar_sources_calendar_id_4b0d4bdf31ddc740_uniq; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX mbdc_calendar_sources_calendar_id_4b0d4bdf31ddc740_uniq ON mbdc_calendar_sources USING btree (calendar_id, datasource_id);


--
-- Name: mbdc_calendar_sources_datasource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_calendar_sources_datasource_id ON mbdc_calendar_sources USING btree (datasource_id);


--
-- Name: mbdc_calendar_topics_calendar_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mbdc_calendar_topics_calendar_id ON mbdc_calendar_topics USING btree (calendar_id);


--
-- Name: mbdc_calendar_topics_calendar_id_38f0752a22458442_uniq; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX mbdc_calendar_topics_calendar_id_38f0752a22458442_uniq ON mbdc_calendar_topics USING btree (calendar_id, topic_id);


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

CREATE INDEX mbdc_datasource_slug_like ON mbdc_datasource USING btree (slug);


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

CREATE INDEX mbdc_topic_slug_like ON mbdc_topic USING btree (slug);


--
-- Name: snapshots_visualization__visualization_id_34c1e30e30858e56_uniq; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX snapshots_visualization__visualization_id_34c1e30e30858e56_uniq ON snapshots_visualization_topics USING btree (visualization_id, topic_id);


--
-- Name: snapshots_visualization_regiontype_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX snapshots_visualization_regiontype_id ON snapshots_visualization USING btree (regiontype_id);


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
-- Name: weave_visualization_data_visualization_id_7910f94c368bebdd_uniq; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX weave_visualization_data_visualization_id_7910f94c368bebdd_uniq ON weave_visualization_datasources USING btree (visualization_id, datasource_id);


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
-- Name: weave_visualization_topi_visualization_id_1f3c9f406802bc09_uniq; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX weave_visualization_topi_visualization_id_1f3c9f406802bc09_uniq ON weave_visualization_topics USING btree (visualization_id, topic_id);


--
-- Name: weave_visualization_topics_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX weave_visualization_topics_topic_id ON weave_visualization_topics USING btree (topic_id);


--
-- Name: weave_visualization_topics_visualization_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX weave_visualization_topics_visualization_id ON weave_visualization_topics USING btree (visualization_id);


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

INSERT INTO schema_migrations (version) VALUES ('20140901211355');

INSERT INTO schema_migrations (version) VALUES ('20140902182153');

INSERT INTO schema_migrations (version) VALUES ('20140903002213');

INSERT INTO schema_migrations (version) VALUES ('20140903033148');

INSERT INTO schema_migrations (version) VALUES ('20141021182918');

INSERT INTO schema_migrations (version) VALUES ('20141021183232');

INSERT INTO schema_migrations (version) VALUES ('20141031173625');

INSERT INTO schema_migrations (version) VALUES ('20141121191140');

INSERT INTO schema_migrations (version) VALUES ('20141121234755');

INSERT INTO schema_migrations (version) VALUES ('20141122001639');

INSERT INTO schema_migrations (version) VALUES ('20141203220622');

INSERT INTO schema_migrations (version) VALUES ('20141204151129');

INSERT INTO schema_migrations (version) VALUES ('20150224203903');

INSERT INTO schema_migrations (version) VALUES ('20150225194939');

INSERT INTO schema_migrations (version) VALUES ('20150226213733');

INSERT INTO schema_migrations (version) VALUES ('20150226215146');

INSERT INTO schema_migrations (version) VALUES ('20150302164055');

