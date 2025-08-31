--
-- PostgreSQL database dump
--

\restrict FlrjEK86CE7WG9JsnytbSE3uPtZrV2b5Z0RfHTNdfoJKcG1cUkgy1r8ZkemHeBb

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: dbo; Type: SCHEMA; Schema: -; Owner: bot_user
--

CREATE SCHEMA dbo;


ALTER SCHEMA dbo OWNER TO bot_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: p1; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.p1 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_problem text,
    edu_describtion text,
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.p1 OWNER TO bot_user;

--
-- Name: p1_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.p1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.p1_id_seq OWNER TO bot_user;

--
-- Name: p1_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.p1_id_seq OWNED BY dbo.p1.id;


--
-- Name: p2; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.p2 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_sphere character varying(255),
    edu_result text,
    edu_describtion text,
    edu_author character varying(255),
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.p2 OWNER TO bot_user;

--
-- Name: p2_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.p2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.p2_id_seq OWNER TO bot_user;

--
-- Name: p2_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.p2_id_seq OWNED BY dbo.p2.id;


--
-- Name: p3; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.p3 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_category character varying(255),
    edu_additional text,
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.p3 OWNER TO bot_user;

--
-- Name: p3_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.p3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.p3_id_seq OWNER TO bot_user;

--
-- Name: p3_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.p3_id_seq OWNED BY dbo.p3.id;


--
-- Name: q1; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.q1 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_problem text,
    edu_grate character varying(50),
    edu_litter character varying(10),
    edu_subject character varying(255),
    edu_problem_date date,
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.q1 OWNER TO bot_user;

--
-- Name: q1_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.q1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.q1_id_seq OWNER TO bot_user;

--
-- Name: q1_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.q1_id_seq OWNED BY dbo.q1.id;


--
-- Name: q2; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.q2 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_problem text,
    edu_grate character varying(50),
    edu_litter character varying(10),
    edu_subject character varying(255),
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.q2 OWNER TO bot_user;

--
-- Name: q2_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.q2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.q2_id_seq OWNER TO bot_user;

--
-- Name: q2_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.q2_id_seq OWNED BY dbo.q2.id;


--
-- Name: q3; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.q3 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_problem text,
    edu_full_name character varying(255),
    edu_grate character varying(50),
    edu_litter character varying(10),
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.q3 OWNER TO bot_user;

--
-- Name: q3_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.q3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.q3_id_seq OWNER TO bot_user;

--
-- Name: q3_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.q3_id_seq OWNED BY dbo.q3.id;


--
-- Name: q4; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.q4 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_problem text,
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.q4 OWNER TO bot_user;

--
-- Name: q4_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.q4_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.q4_id_seq OWNER TO bot_user;

--
-- Name: q4_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.q4_id_seq OWNED BY dbo.q4.id;


--
-- Name: q5; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.q5 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_total integer,
    edu_illnes integer,
    edu_flight integer,
    edu_individual integer,
    edu_cvalification integer,
    edu_other integer,
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.q5 OWNER TO bot_user;

--
-- Name: q5_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.q5_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.q5_id_seq OWNER TO bot_user;

--
-- Name: q5_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.q5_id_seq OWNED BY dbo.q5.id;


--
-- Name: s1; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.s1 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_class_num character varying(50),
    edu_floor character varying(50),
    edu_classroom character varying(100),
    edu_problem text,
    edu_condition character varying(100),
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.s1 OWNER TO bot_user;

--
-- Name: s1_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.s1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.s1_id_seq OWNER TO bot_user;

--
-- Name: s1_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s1_id_seq OWNED BY dbo.s1.id;


--
-- Name: s2; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.s2 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_loc_num character varying(50),
    edu_floor character varying(50),
    edu_location character varying(100),
    edu_place character varying(255),
    edu_problem text,
    edu_condition character varying(100),
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.s2 OWNER TO bot_user;

--
-- Name: s2_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.s2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.s2_id_seq OWNER TO bot_user;

--
-- Name: s2_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s2_id_seq OWNED BY dbo.s2.id;


--
-- Name: s3; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.s3 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_loc_num character varying(50),
    edu_floor character varying(50),
    edu_location character varying(100),
    edu_place character varying(255),
    edu_problem text,
    edu_condition character varying(100),
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.s3 OWNER TO bot_user;

--
-- Name: s3_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.s3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.s3_id_seq OWNER TO bot_user;

--
-- Name: s3_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s3_id_seq OWNED BY dbo.s3.id;


--
-- Name: s4; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.s4 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_problem text,
    edu_condition character varying(100),
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.s4 OWNER TO bot_user;

--
-- Name: s4_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.s4_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.s4_id_seq OWNER TO bot_user;

--
-- Name: s4_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s4_id_seq OWNED BY dbo.s4.id;


--
-- Name: s5; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.s5 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_incident character varying(255),
    edu_describtion text,
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.s5 OWNER TO bot_user;

--
-- Name: s5_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.s5_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.s5_id_seq OWNER TO bot_user;

--
-- Name: s5_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s5_id_seq OWNED BY dbo.s5.id;


--
-- Name: s6; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.s6 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_security text,
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.s6 OWNER TO bot_user;

--
-- Name: s6_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.s6_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.s6_id_seq OWNER TO bot_user;

--
-- Name: s6_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s6_id_seq OWNED BY dbo.s6.id;


--
-- Name: s7; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.s7 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_problem text,
    edu_action text,
    edu_status character varying(100),
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.s7 OWNER TO bot_user;

--
-- Name: s7_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.s7_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.s7_id_seq OWNER TO bot_user;

--
-- Name: s7_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s7_id_seq OWNED BY dbo.s7.id;


--
-- Name: s8; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.s8 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_role character varying(255),
    edu_problem text,
    edu_describtion text,
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.s8 OWNER TO bot_user;

--
-- Name: s8_id_seq; Type: SEQUENCE; Schema: dbo; Owner: bot_user
--

CREATE SEQUENCE dbo.s8_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.s8_id_seq OWNER TO bot_user;

--
-- Name: s8_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s8_id_seq OWNED BY dbo.s8.id;


--
-- Name: p1 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p1 ALTER COLUMN id SET DEFAULT nextval('dbo.p1_id_seq'::regclass);


--
-- Name: p2 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p2 ALTER COLUMN id SET DEFAULT nextval('dbo.p2_id_seq'::regclass);


--
-- Name: p3 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p3 ALTER COLUMN id SET DEFAULT nextval('dbo.p3_id_seq'::regclass);


--
-- Name: q1 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q1 ALTER COLUMN id SET DEFAULT nextval('dbo.q1_id_seq'::regclass);


--
-- Name: q2 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q2 ALTER COLUMN id SET DEFAULT nextval('dbo.q2_id_seq'::regclass);


--
-- Name: q3 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q3 ALTER COLUMN id SET DEFAULT nextval('dbo.q3_id_seq'::regclass);


--
-- Name: q4 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q4 ALTER COLUMN id SET DEFAULT nextval('dbo.q4_id_seq'::regclass);


--
-- Name: q5 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q5 ALTER COLUMN id SET DEFAULT nextval('dbo.q5_id_seq'::regclass);


--
-- Name: s1 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s1 ALTER COLUMN id SET DEFAULT nextval('dbo.s1_id_seq'::regclass);


--
-- Name: s2 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s2 ALTER COLUMN id SET DEFAULT nextval('dbo.s2_id_seq'::regclass);


--
-- Name: s3 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s3 ALTER COLUMN id SET DEFAULT nextval('dbo.s3_id_seq'::regclass);


--
-- Name: s4 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s4 ALTER COLUMN id SET DEFAULT nextval('dbo.s4_id_seq'::regclass);


--
-- Name: s5 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s5 ALTER COLUMN id SET DEFAULT nextval('dbo.s5_id_seq'::regclass);


--
-- Name: s6 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s6 ALTER COLUMN id SET DEFAULT nextval('dbo.s6_id_seq'::regclass);


--
-- Name: s7 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s7 ALTER COLUMN id SET DEFAULT nextval('dbo.s7_id_seq'::regclass);


--
-- Name: s8 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s8 ALTER COLUMN id SET DEFAULT nextval('dbo.s8_id_seq'::regclass);


--
-- Data for Name: p1; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.p1 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_describtion, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: p2; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.p2 (id, edu_school, edu_date, edu_time, edu_role, edu_sphere, edu_result, edu_describtion, edu_author, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: p3; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.p3 (id, edu_school, edu_date, edu_time, edu_role, edu_category, edu_additional, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: q1; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.q1 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_grate, edu_litter, edu_subject, edu_problem_date, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: q2; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.q2 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_grate, edu_litter, edu_subject, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: q3; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.q3 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_full_name, edu_grate, edu_litter, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: q4; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.q4 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: q5; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.q5 (id, edu_school, edu_date, edu_time, edu_role, edu_total, edu_illnes, edu_flight, edu_individual, edu_cvalification, edu_other, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: s1; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s1 (id, edu_school, edu_date, edu_time, edu_role, edu_class_num, edu_floor, edu_classroom, edu_problem, edu_condition, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: s2; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s2 (id, edu_school, edu_date, edu_time, edu_role, edu_loc_num, edu_floor, edu_location, edu_place, edu_problem, edu_condition, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: s3; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s3 (id, edu_school, edu_date, edu_time, edu_role, edu_loc_num, edu_floor, edu_location, edu_place, edu_problem, edu_condition, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: s4; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s4 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_condition, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: s5; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s5 (id, edu_school, edu_date, edu_time, edu_role, edu_incident, edu_describtion, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: s6; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s6 (id, edu_school, edu_date, edu_time, edu_role, edu_security, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: s7; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s7 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Data for Name: s8; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s8 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_describtion, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
\.


--
-- Name: p1_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.p1_id_seq', 1, false);


--
-- Name: p2_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.p2_id_seq', 1, false);


--
-- Name: p3_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.p3_id_seq', 1, false);


--
-- Name: q1_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.q1_id_seq', 1, false);


--
-- Name: q2_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.q2_id_seq', 1, false);


--
-- Name: q3_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.q3_id_seq', 1, false);


--
-- Name: q4_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.q4_id_seq', 1, false);


--
-- Name: q5_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.q5_id_seq', 1, false);


--
-- Name: s1_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s1_id_seq', 1, false);


--
-- Name: s2_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s2_id_seq', 1, false);


--
-- Name: s3_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s3_id_seq', 1, false);


--
-- Name: s4_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s4_id_seq', 1, false);


--
-- Name: s5_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s5_id_seq', 1, false);


--
-- Name: s6_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s6_id_seq', 1, false);


--
-- Name: s7_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s7_id_seq', 1, false);


--
-- Name: s8_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s8_id_seq', 1, false);


--
-- Name: p1 p1_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p1
    ADD CONSTRAINT p1_pkey PRIMARY KEY (id);


--
-- Name: p2 p2_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p2
    ADD CONSTRAINT p2_pkey PRIMARY KEY (id);


--
-- Name: p3 p3_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p3
    ADD CONSTRAINT p3_pkey PRIMARY KEY (id);


--
-- Name: q1 q1_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q1
    ADD CONSTRAINT q1_pkey PRIMARY KEY (id);


--
-- Name: q2 q2_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q2
    ADD CONSTRAINT q2_pkey PRIMARY KEY (id);


--
-- Name: q3 q3_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q3
    ADD CONSTRAINT q3_pkey PRIMARY KEY (id);


--
-- Name: q4 q4_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q4
    ADD CONSTRAINT q4_pkey PRIMARY KEY (id);


--
-- Name: q5 q5_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q5
    ADD CONSTRAINT q5_pkey PRIMARY KEY (id);


--
-- Name: s1 s1_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s1
    ADD CONSTRAINT s1_pkey PRIMARY KEY (id);


--
-- Name: s2 s2_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s2
    ADD CONSTRAINT s2_pkey PRIMARY KEY (id);


--
-- Name: s3 s3_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s3
    ADD CONSTRAINT s3_pkey PRIMARY KEY (id);


--
-- Name: s4 s4_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s4
    ADD CONSTRAINT s4_pkey PRIMARY KEY (id);


--
-- Name: s5 s5_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s5
    ADD CONSTRAINT s5_pkey PRIMARY KEY (id);


--
-- Name: s6 s6_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s6
    ADD CONSTRAINT s6_pkey PRIMARY KEY (id);


--
-- Name: s7 s7_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s7
    ADD CONSTRAINT s7_pkey PRIMARY KEY (id);


--
-- Name: s8 s8_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s8
    ADD CONSTRAINT s8_pkey PRIMARY KEY (id);


--
-- Name: idx_p1_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p1_created_at ON dbo.p1 USING btree (created_at);


--
-- Name: idx_p1_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p1_school_date ON dbo.p1 USING btree (edu_school, edu_date);


--
-- Name: idx_p1_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p1_status ON dbo.p1 USING btree (edu_status);


--
-- Name: idx_p2_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p2_created_at ON dbo.p2 USING btree (created_at);


--
-- Name: idx_p2_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p2_school_date ON dbo.p2 USING btree (edu_school, edu_date);


--
-- Name: idx_p2_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p2_status ON dbo.p2 USING btree (edu_status);


--
-- Name: idx_p3_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p3_created_at ON dbo.p3 USING btree (created_at);


--
-- Name: idx_p3_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p3_school_date ON dbo.p3 USING btree (edu_school, edu_date);


--
-- Name: idx_q1_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q1_created_at ON dbo.q1 USING btree (created_at);


--
-- Name: idx_q1_grate_litter; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q1_grate_litter ON dbo.q1 USING btree (edu_grate, edu_litter);


--
-- Name: idx_q1_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q1_school_date ON dbo.q1 USING btree (edu_school, edu_date);


--
-- Name: idx_q1_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q1_status ON dbo.q1 USING btree (edu_status);


--
-- Name: idx_q2_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q2_created_at ON dbo.q2 USING btree (created_at);


--
-- Name: idx_q2_grate_litter; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q2_grate_litter ON dbo.q2 USING btree (edu_grate, edu_litter);


--
-- Name: idx_q2_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q2_school_date ON dbo.q2 USING btree (edu_school, edu_date);


--
-- Name: idx_q2_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q2_status ON dbo.q2 USING btree (edu_status);


--
-- Name: idx_q3_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q3_created_at ON dbo.q3 USING btree (created_at);


--
-- Name: idx_q3_grate_litter; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q3_grate_litter ON dbo.q3 USING btree (edu_grate, edu_litter);


--
-- Name: idx_q3_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q3_school_date ON dbo.q3 USING btree (edu_school, edu_date);


--
-- Name: idx_q3_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q3_status ON dbo.q3 USING btree (edu_status);


--
-- Name: idx_q4_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q4_created_at ON dbo.q4 USING btree (created_at);


--
-- Name: idx_q4_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q4_school_date ON dbo.q4 USING btree (edu_school, edu_date);


--
-- Name: idx_q4_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q4_status ON dbo.q4 USING btree (edu_status);


--
-- Name: idx_q5_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q5_created_at ON dbo.q5 USING btree (created_at);


--
-- Name: idx_q5_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q5_school_date ON dbo.q5 USING btree (edu_school, edu_date);


--
-- Name: idx_s1_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s1_created_at ON dbo.s1 USING btree (created_at);


--
-- Name: idx_s1_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s1_school_date ON dbo.s1 USING btree (edu_school, edu_date);


--
-- Name: idx_s1_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s1_status ON dbo.s1 USING btree (edu_status);


--
-- Name: idx_s2_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s2_created_at ON dbo.s2 USING btree (created_at);


--
-- Name: idx_s2_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s2_school_date ON dbo.s2 USING btree (edu_school, edu_date);


--
-- Name: idx_s2_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s2_status ON dbo.s2 USING btree (edu_status);


--
-- Name: idx_s3_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s3_created_at ON dbo.s3 USING btree (created_at);


--
-- Name: idx_s3_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s3_school_date ON dbo.s3 USING btree (edu_school, edu_date);


--
-- Name: idx_s3_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s3_status ON dbo.s3 USING btree (edu_status);


--
-- Name: idx_s4_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s4_created_at ON dbo.s4 USING btree (created_at);


--
-- Name: idx_s4_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s4_school_date ON dbo.s4 USING btree (edu_school, edu_date);


--
-- Name: idx_s4_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s4_status ON dbo.s4 USING btree (edu_status);


--
-- Name: idx_s5_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s5_created_at ON dbo.s5 USING btree (created_at);


--
-- Name: idx_s5_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s5_school_date ON dbo.s5 USING btree (edu_school, edu_date);


--
-- Name: idx_s5_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s5_status ON dbo.s5 USING btree (edu_status);


--
-- Name: idx_s6_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s6_created_at ON dbo.s6 USING btree (created_at);


--
-- Name: idx_s6_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s6_school_date ON dbo.s6 USING btree (edu_school, edu_date);


--
-- Name: idx_s6_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s6_status ON dbo.s6 USING btree (edu_status);


--
-- Name: idx_s7_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s7_created_at ON dbo.s7 USING btree (created_at);


--
-- Name: idx_s7_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s7_school_date ON dbo.s7 USING btree (edu_school, edu_date);


--
-- Name: idx_s7_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s7_status ON dbo.s7 USING btree (edu_status);


--
-- Name: idx_s8_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s8_created_at ON dbo.s8 USING btree (created_at);


--
-- Name: idx_s8_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s8_school_date ON dbo.s8 USING btree (edu_school, edu_date);


--
-- PostgreSQL database dump complete
--

\unrestrict FlrjEK86CE7WG9JsnytbSE3uPtZrV2b5Z0RfHTNdfoJKcG1cUkgy1r8ZkemHeBb

