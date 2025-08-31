--
-- PostgreSQL database dump
--

\restrict wxJBYQYn9sCYPRhAHP1PEquEtfrPFKx7av7D6EuTNFqXrjaBL4m9C9VqCSzKRUt

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

-- Started on 2025-08-31 19:49:21 UTC

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

DROP DATABASE IF EXISTS power_bi_bot;
--
-- TOC entry 3668 (class 1262 OID 16384)
-- Name: power_bi_bot; Type: DATABASE; Schema: -; Owner: bot_user
--

CREATE DATABASE power_bi_bot WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE power_bi_bot OWNER TO bot_user;

\unrestrict wxJBYQYn9sCYPRhAHP1PEquEtfrPFKx7av7D6EuTNFqXrjaBL4m9C9VqCSzKRUt
\connect power_bi_bot
\restrict wxJBYQYn9sCYPRhAHP1PEquEtfrPFKx7av7D6EuTNFqXrjaBL4m9C9VqCSzKRUt

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
-- TOC entry 6 (class 2615 OID 16385)
-- Name: dbo; Type: SCHEMA; Schema: -; Owner: bot_user
--

CREATE SCHEMA dbo;


ALTER SCHEMA dbo OWNER TO bot_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 242 (class 1259 OID 16544)
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
-- TOC entry 241 (class 1259 OID 16543)
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
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 241
-- Name: p1_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.p1_id_seq OWNED BY dbo.p1.id;


--
-- TOC entry 244 (class 1259 OID 16555)
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
-- TOC entry 243 (class 1259 OID 16554)
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
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 243
-- Name: p2_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.p2_id_seq OWNED BY dbo.p2.id;


--
-- TOC entry 246 (class 1259 OID 16566)
-- Name: p3; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.p3 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_emotional_state integer DEFAULT 0,
    edu_conflicts_relations integer DEFAULT 0,
    edu_bullying_cyberbullying integer DEFAULT 0,
    edu_learning_problems integer DEFAULT 0,
    edu_crisis_situations integer DEFAULT 0,
    edu_preventive_consultation integer DEFAULT 0,
    edu_other integer DEFAULT 0,
    edu_total_psychologist integer DEFAULT 0,
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.p3 OWNER TO bot_user;

--
-- TOC entry 245 (class 1259 OID 16565)
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
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 245
-- Name: p3_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.p3_id_seq OWNED BY dbo.p3.id;


--
-- TOC entry 232 (class 1259 OID 16483)
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
-- TOC entry 231 (class 1259 OID 16482)
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
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 231
-- Name: q1_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.q1_id_seq OWNED BY dbo.q1.id;


--
-- TOC entry 234 (class 1259 OID 16494)
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
-- TOC entry 233 (class 1259 OID 16493)
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
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 233
-- Name: q2_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.q2_id_seq OWNED BY dbo.q2.id;


--
-- TOC entry 236 (class 1259 OID 16505)
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
-- TOC entry 235 (class 1259 OID 16504)
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
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 235
-- Name: q3_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.q3_id_seq OWNED BY dbo.q3.id;


--
-- TOC entry 238 (class 1259 OID 16516)
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
-- TOC entry 237 (class 1259 OID 16515)
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
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 237
-- Name: q4_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.q4_id_seq OWNED BY dbo.q4.id;


--
-- TOC entry 240 (class 1259 OID 16527)
-- Name: q5; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.q5 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_total_teachers integer DEFAULT 0,
    edu_illness integer DEFAULT 0,
    edu_business_trip integer DEFAULT 0,
    edu_personal_reasons integer DEFAULT 0,
    edu_professional_development integer DEFAULT 0,
    edu_other integer DEFAULT 0,
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.q5 OWNER TO bot_user;

--
-- TOC entry 239 (class 1259 OID 16526)
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
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 239
-- Name: q5_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.q5_id_seq OWNED BY dbo.q5.id;


--
-- TOC entry 216 (class 1259 OID 16387)
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
-- TOC entry 215 (class 1259 OID 16386)
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
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 215
-- Name: s1_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s1_id_seq OWNED BY dbo.s1.id;


--
-- TOC entry 218 (class 1259 OID 16398)
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
-- TOC entry 217 (class 1259 OID 16397)
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
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 217
-- Name: s2_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s2_id_seq OWNED BY dbo.s2.id;


--
-- TOC entry 220 (class 1259 OID 16409)
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
-- TOC entry 219 (class 1259 OID 16408)
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
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 219
-- Name: s3_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s3_id_seq OWNED BY dbo.s3.id;


--
-- TOC entry 222 (class 1259 OID 16420)
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
-- TOC entry 221 (class 1259 OID 16419)
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
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 221
-- Name: s4_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s4_id_seq OWNED BY dbo.s4.id;


--
-- TOC entry 224 (class 1259 OID 16431)
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
-- TOC entry 223 (class 1259 OID 16430)
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
-- TOC entry 3681 (class 0 OID 0)
-- Dependencies: 223
-- Name: s5_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s5_id_seq OWNED BY dbo.s5.id;


--
-- TOC entry 226 (class 1259 OID 16442)
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
-- TOC entry 225 (class 1259 OID 16441)
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
-- TOC entry 3682 (class 0 OID 0)
-- Dependencies: 225
-- Name: s6_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s6_id_seq OWNED BY dbo.s6.id;


--
-- TOC entry 228 (class 1259 OID 16453)
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
-- TOC entry 227 (class 1259 OID 16452)
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
-- TOC entry 3683 (class 0 OID 0)
-- Dependencies: 227
-- Name: s7_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s7_id_seq OWNED BY dbo.s7.id;


--
-- TOC entry 230 (class 1259 OID 16464)
-- Name: s8; Type: TABLE; Schema: dbo; Owner: bot_user
--

CREATE TABLE dbo.s8 (
    id integer NOT NULL,
    edu_school character varying(255),
    edu_date date,
    edu_time time without time zone,
    edu_digestive_system integer DEFAULT 0,
    edu_cold_flu integer DEFAULT 0,
    edu_injuries integer DEFAULT 0,
    edu_allergic_reactions integer DEFAULT 0,
    edu_neurological_general integer DEFAULT 0,
    edu_chronic_diseases integer DEFAULT 0,
    edu_other integer DEFAULT 0,
    edu_total_medical integer DEFAULT 0,
    edu_photo character varying(500),
    edu_data_from character varying(100) DEFAULT 'Telegram Bot'::character varying,
    edu_add_inf text,
    edu_contact character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE dbo.s8 OWNER TO bot_user;

--
-- TOC entry 229 (class 1259 OID 16463)
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
-- TOC entry 3684 (class 0 OID 0)
-- Dependencies: 229
-- Name: s8_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: bot_user
--

ALTER SEQUENCE dbo.s8_id_seq OWNED BY dbo.s8.id;


--
-- TOC entry 3392 (class 2604 OID 16547)
-- Name: p1 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p1 ALTER COLUMN id SET DEFAULT nextval('dbo.p1_id_seq'::regclass);


--
-- TOC entry 3395 (class 2604 OID 16558)
-- Name: p2 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p2 ALTER COLUMN id SET DEFAULT nextval('dbo.p2_id_seq'::regclass);


--
-- TOC entry 3398 (class 2604 OID 16569)
-- Name: p3 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p3 ALTER COLUMN id SET DEFAULT nextval('dbo.p3_id_seq'::regclass);


--
-- TOC entry 3371 (class 2604 OID 16486)
-- Name: q1 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q1 ALTER COLUMN id SET DEFAULT nextval('dbo.q1_id_seq'::regclass);


--
-- TOC entry 3374 (class 2604 OID 16497)
-- Name: q2 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q2 ALTER COLUMN id SET DEFAULT nextval('dbo.q2_id_seq'::regclass);


--
-- TOC entry 3377 (class 2604 OID 16508)
-- Name: q3 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q3 ALTER COLUMN id SET DEFAULT nextval('dbo.q3_id_seq'::regclass);


--
-- TOC entry 3380 (class 2604 OID 16519)
-- Name: q4 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q4 ALTER COLUMN id SET DEFAULT nextval('dbo.q4_id_seq'::regclass);


--
-- TOC entry 3383 (class 2604 OID 16530)
-- Name: q5 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q5 ALTER COLUMN id SET DEFAULT nextval('dbo.q5_id_seq'::regclass);


--
-- TOC entry 3339 (class 2604 OID 16390)
-- Name: s1 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s1 ALTER COLUMN id SET DEFAULT nextval('dbo.s1_id_seq'::regclass);


--
-- TOC entry 3342 (class 2604 OID 16401)
-- Name: s2 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s2 ALTER COLUMN id SET DEFAULT nextval('dbo.s2_id_seq'::regclass);


--
-- TOC entry 3345 (class 2604 OID 16412)
-- Name: s3 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s3 ALTER COLUMN id SET DEFAULT nextval('dbo.s3_id_seq'::regclass);


--
-- TOC entry 3348 (class 2604 OID 16423)
-- Name: s4 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s4 ALTER COLUMN id SET DEFAULT nextval('dbo.s4_id_seq'::regclass);


--
-- TOC entry 3351 (class 2604 OID 16434)
-- Name: s5 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s5 ALTER COLUMN id SET DEFAULT nextval('dbo.s5_id_seq'::regclass);


--
-- TOC entry 3354 (class 2604 OID 16445)
-- Name: s6 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s6 ALTER COLUMN id SET DEFAULT nextval('dbo.s6_id_seq'::regclass);


--
-- TOC entry 3357 (class 2604 OID 16456)
-- Name: s7 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s7 ALTER COLUMN id SET DEFAULT nextval('dbo.s7_id_seq'::regclass);


--
-- TOC entry 3360 (class 2604 OID 16467)
-- Name: s8 id; Type: DEFAULT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s8 ALTER COLUMN id SET DEFAULT nextval('dbo.s8_id_seq'::regclass);


--
-- TOC entry 3658 (class 0 OID 16544)
-- Dependencies: 242
-- Data for Name: p1; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.p1 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_describtion, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom school им. Ы. Алтынсарина	2025-08-21	07:25:51	Ата-ана / родитель	🍽 Тамақ сапасы / Качество питания	плохое качество\n	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
2	Binom school им. Ы. Алтынсарина	2025-08-21	07:26:36	Оқушы / Ученик	🍴 Тамақтануды ұйымдастыру / Организация питания	плохое качество\n	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
3	Binom school им. Ы. Алтынсарина	2025-08-21	07:26:52	Қызметкер / Сотрудник	📚 Оқу процесі / Учебный процесс	плохое качество	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
4	Binom school им. Ы. Алтынсарина	2025-08-21	07:27:11	Оқушы / Ученик	👨‍🏫 Мұғалімдердің жұмысы / Работа учителей	плохое качество	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
5	Binom school им. Ы. Алтынсарина	2025-08-21	07:27:31	Қызметкер / Сотрудник	🧑‍🏫 Сынып жетекшісі / Классный руководитель	плохое качество	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
6	Binom school им. Ы. Алтынсарина	2025-08-21	07:28:12	Ата-ана / родитель	🔄 Коммуникация және ақпарат / Коммуникации и информирование (например: родительские чаты, уведомления, работа администрации)	плохое качество	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
7	Binom school им. Ы. Алтынсарина	2025-08-21	07:28:34	Ата-ана / родитель	🔄 Коммуникация және ақпарат / Коммуникации и информирование (например: родительские чаты, уведомления, работа администрации)	плохое качество	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
8	Binom school им. Ы. Алтынсарина	2025-08-21	07:28:50	Оқушы / Ученик	⚠ Қауіпсіздік / Безопасность	плохое качество\n	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
9	Binom school им. Ы. Алтынсарина	2025-08-21	07:29:42	Оқушы / Ученик	🎭 Кружки және үйірмелер жұмысы / Организация кружковой работы	плохое качество	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
10	Binom school им. Ы. Алтынсарина	2025-08-21	07:30:05	Оқушы / Ученик	🏫 Сыныптан тыс іс-шаралар / Внеклассная работа (мероприятия, конкурсы, экскурсии)	плохое качество	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
11	Binom school им. Ы. Алтынсарина	2025-08-21	07:30:23	Қызметкер / Сотрудник	📖 Ғылыми-әдістемелік жұмыс / Научно-методическая работа (качество программ, методики)	плохое качество	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
12	Binom school им. Ы. Алтынсарина	2025-08-21	07:30:41	Қызметкер / Сотрудник	плохое качество	плохое качество	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
13	Binom school им. А. Байтұрсынұлы 	2025-08-21	09:25:35	Оқушы / Ученик	🔄 Коммуникация және ақпарат / Коммуникации и информирование (например: родительские чаты, уведомления, работа администрации)	562	\N	\N	\N	Forms	35656	232	2025-08-31 19:43:45.337021
14	Binom school им. Ы. Алтынсарина	2025-08-21	09:29:37	Ата-ана / родитель	👨‍🏫 Мұғалімдердің жұмысы / Работа учителей	Лалмли	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.337021
15	Binom school им. Қ. Сәтбаева	2025-08-21	16:08:24	Ата-ана / родитель	🍽 Тамақ сапасы / Качество питания	азат	\N	\N	\N	Forms	паов	\N	2025-08-31 19:43:45.337021
16	Binom school им. Ы. Алтынсарина	2025-08-21	16:11:09	Ата-ана / родитель	🍽 Тамақ сапасы / Качество питания	car	\N	\N	\N	Forms	a	\N	2025-08-31 19:43:45.337021
17	Binom school им. Қ. Сәтбаева	2025-08-21	16:12:18	Ата-ана / родитель	🍴 Тамақтануды ұйымдастыру / Организация питания	ghj	\N	\N	\N	Forms	123	\N	2025-08-31 19:43:45.337021
18	Binom School им. Қадыр Мырза Әлі	2025-08-21	16:13:59	Ата-ана / родитель	🍽 Тамақ сапасы / Качество питания	z	\N	\N	\N	Forms	z	\N	2025-08-31 19:43:45.337021
19	Binom school им. А. Кекилбаева	2025-08-21	16:16:04	Ата-ана / родитель	🍽 Тамақ сапасы / Качество питания	1	\N	\N	\N	Forms	1	\N	2025-08-31 19:43:45.337021
20	Binom school им. А. Кекилбаева	2025-08-21	16:21:24	Ата-ана / родитель	🧑‍🏫 Сынып жетекшісі / Классный руководитель	fffffff	\N	\N	\N	Forms	fffffffffffffffffffffff	\N	2025-08-31 19:43:45.337021
21	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:21:39	Оқушы / Ученик	👨‍🏫 Мұғалімдердің жұмысы / Работа учителей	Мосос	\N	\N	\N	Forms	Лмлм	Осом	2025-08-31 19:43:45.337021
22	Binom School им. А. Бөкейхана	2025-08-21	16:21:58	Қызметкер / Сотрудник	🔄 Коммуникация және ақпарат / Коммуникации и информирование (например: родительские чаты, уведомления, работа администрации)	dddddddd	\N	\N	\N	Forms	ddddddddd	\N	2025-08-31 19:43:45.337021
23	Binom school им. А. Байтұрсынұлы 	2025-08-22	18:12:03	Психолог	🍽 Тамақ сапасы / Качество питания	бұл мен Азат	\N	\N	\N	Forms	Азатик	прпрпрпр	2025-08-31 19:43:45.337021
\.


--
-- TOC entry 3660 (class 0 OID 16555)
-- Dependencies: 244
-- Data for Name: p2; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.p2 (id, edu_school, edu_date, edu_time, edu_role, edu_sphere, edu_result, edu_describtion, edu_author, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom school им. А. Кекилбаева	2025-08-21	11:27:01	Оқушы / Ученик	💧 Ресурстарды үнемдеу / Экономия ресурсов	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
2	Binom School им. А. Бөкейхана	2025-08-21	11:28:25	Ата-ана / родитель	📚 Оқыту сапасын арттыру / Улучшение качества обучения	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
3	Binom school им. Ы. Алтынсарина	2025-08-21	11:30:53	Ата-ана / родитель	⚙ Процесті оңтайландыру / Оптимизация процесса	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
4	Binom School им. Қадыр Мырза Әлі	2025-08-21	11:31:29	Оқушы / Ученик	💻 Цифрландыру / Цифровизация	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
5	Binom School им. Қадыр Мырза Әлі	2025-08-21	11:31:45	Қызметкер / Сотрудник	🛡 Қауіпсіздікті арттыру / Улучшение безопасности	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
6	Binom school им. Ы. Алтынсарина	2025-08-21	11:32:04	Оқушы / Ученик	🛡 Қауіпсіздікті арттыру / Улучшение безопасности	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
7	Binom School им. А. Бөкейхана	2025-08-21	11:32:31	Оқушы / Ученик	💧 Ресурстарды үнемдеу / Экономия ресурсов	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
8	Binom school им. А. Кекилбаева	2025-08-21	11:32:57	Қызметкер / Сотрудник	🪑 Жұмыс орнын жақсарту / Улучшение рабочего места	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
9	Binom School им. А. Бөкейхана	2025-08-21	11:33:16	Қызметкер / Сотрудник	🪑 Жұмыс орнын жақсарту / Улучшение рабочего места	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
10	Binom school им. А. Байтұрсынұлы 	2025-08-21	11:33:33	Ата-ана / родитель	📚 Оқыту сапасын арттыру / Улучшение качества обучения	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
11	Binom school им. Қ. Сәтбаева	2025-08-21	11:33:55	Оқушы / Ученик	💧 Ресурстарды үнемдеу / Экономия ресурсов	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
12	Binom School им. Қадыр Мырза Әлі	2025-08-21	11:34:13	Қызметкер / Сотрудник	🛡 Қауіпсіздікті арттыру / Улучшение безопасности	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
13	Binom school им. А. Кекилбаева	2025-08-21	11:34:29	Қызметкер / Сотрудник	⚙ Процесті оңтайландыру / Оптимизация процесса	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
14	Binom school им. Қ. Сәтбаева	2025-08-21	11:34:56	Ата-ана / родитель	💻 Цифрландыру / Цифровизация	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
15	Binom School им. Қадыр Мырза Әлі	2025-08-21	11:35:21	Ата-ана / родитель	💧 Ресурстарды үнемдеу / Экономия ресурсов	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
16	Binom School им. А. Бөкейхана	2025-08-21	11:35:40	Ата-ана / родитель	💻 Цифрландыру / Цифровизация	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
17	Binom School им. А. Бөкейхана	2025-08-21	11:36:05	Оқушы / Ученик	💧 Ресурстарды үнемдеу / Экономия ресурсов	.	.	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
18	Binom School им. А. Бөкейхана	2025-08-21	12:38:47	Ата-ана / родитель	🪑 Жұмыс орнын жақсарту / Улучшение рабочего места	/	/	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
19	Binom school им. А. Кекилбаева	2025-08-21	12:43:58	Ата-ана / родитель	⚙ Процесті оңтайландыру / Оптимизация процесса	П	М	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
20	Binom school им. А. Кекилбаева	2025-08-21	14:46:00	Ата-ана / родитель	💻 Цифрландыру / Цифровизация	575	587	5687	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
21	Binom school им. А. Кекилбаева	2025-08-21	14:46:32	Ата-ана / родитель	💧 Ресурстарды үнемдеу / Экономия ресурсов	5765	687	68	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
22	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:24:20	Ата-ана / родитель	⚙ Процесті оңтайландыру / Оптимизация процесса	Твомои	Гвгмгм	Рмрмин	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
23	Binom school им. А. Кекилбаева	2025-08-21	16:24:26	Оқушы / Ученик	⚙ Процесті оңтайландыру / Оптимизация процесса	KKK	KKK	KKK	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
24	Binom school им. Ы. Алтынсарина	2025-08-21	16:25:02	Қызметкер / Сотрудник	💻 Цифрландыру / Цифровизация	HHHH	HHHHH	HHHHH	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
25	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:25:05	Қызметкер / Сотрудник	⚙ Процесті оңтайландыру / Оптимизация процесса	Омомои	Шмшмшм	Омшмшмг	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
26	Binom school им. Ы. Алтынсарина	2025-08-22	18:18:35	Медициналық қызметкер	💧 Ресурстарды үнемдеу / Экономия ресурсов	никакой	ничего	Маратов Азат	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.35874
\.


--
-- TOC entry 3662 (class 0 OID 16566)
-- Dependencies: 246
-- Data for Name: p3; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.p3 (id, edu_school, edu_date, edu_time, edu_emotional_state, edu_conflicts_relations, edu_bullying_cyberbullying, edu_learning_problems, edu_crisis_situations, edu_preventive_consultation, edu_other, edu_total_psychologist, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom school им. А. Байтұрсынұлы 	2025-08-22	09:57:11	3	5	3	4	1	1	\N	17	\N	\N	\N	\N	2025-08-31 19:43:45.373011
2	Binom school им. А. Байтұрсынұлы 	2025-08-22	17:25:44	2	3	5	4	\N	\N	\N	14	\N	\N	\N	\N	2025-08-31 19:43:45.373011
3	Binom school им. А. Байтұрсынұлы 	2025-08-29	04:18:05	1	2	4	1	2	5	5	20	\N	Forms	\N	\N	2025-08-31 19:43:45.373011
4	Binom School им. А. Бөкейхана	2025-08-29	04:18:36	2	1	3	1	3	5	1	16	\N	Forms	\N	\N	2025-08-31 19:43:45.373011
5	Binom school им. Қ. Сәтбаева	2025-08-29	04:19:19	3	2	3	2	3	2	3	18	\N	Forms	\N	\N	2025-08-31 19:43:45.373011
6	Binom School им. Қадыр Мырза Әлі	2025-08-29	04:19:50	3	3	3	3	3	3	3	21	\N	Forms	\N	\N	2025-08-31 19:43:45.373011
7	Binom school им. А. Байтұрсынұлы 	2025-08-29	06:14:57	2	2	2	2	2	2	2	14	\N	Forms	\N	\N	2025-08-31 19:43:45.373011
8	Riviera International School	2025-08-29	06:28:26	4	4	3	3	3	3	3	23	\N	Forms	\N	\N	2025-08-31 19:43:45.373011
\.


--
-- TOC entry 3648 (class 0 OID 16483)
-- Dependencies: 232
-- Data for Name: q1; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.q1 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_grate, edu_litter, edu_subject, edu_problem_date, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom school им. Ы. Алтынсарина	2025-08-21	07:14:30	Оқушы / Ученик	⏱ Үзілістер қолайсыз / Перемены слишком короткие или длинные	3	Б	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
2	Binom school им. Ы. Алтынсарина	2025-08-21	07:14:55	Қызметкер / Сотрудник	➕ Кестеде пәндері қиындығы ескерілмеген/ Не учтена сложность предметов	8	В	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
3	Binom school им. Ы. Алтынсарина	2025-08-21	07:15:19	Оқушы / Ученик	⏳ Сабақ толық өткізілмеді / Урок состоялся частично	2	Г	Химия	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
4	Binom school им. Ы. Алтынсарина	2025-08-21	07:15:39	Ата-ана / родитель	🗓 Кестеде қате / Ошибка в расписании	2	Б	Ағылшын тілі	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
5	Binom school им. Ы. Алтынсарина	2025-08-21	07:16:00	Оқушы / Ученик	🔁 Кабинеттер алыс / Длинные переходы между кабинетами	5	Г	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
6	Binom school им. Ы. Алтынсарина	2025-08-21	07:16:23	Ата-ана / родитель	➕ Кестеде пәндері қиындығы ескерілмеген/ Не учтена сложность предметов	9	Г	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
7	Binom school им. Ы. Алтынсарина	2025-08-21	07:16:45	Оқушы / Ученик	🔁 Кабинеттер алыс / Длинные переходы между кабинетами	6	Б	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
8	Binom school им. Ы. Алтынсарина	2025-08-21	07:17:08	Оқушы / Ученик	❌ Сабақ өткізілмеді / Урок не состоялся	3	Б	Қазақ тілі	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
9	Binom school им. Ы. Алтынсарина	2025-08-21	07:17:32	Ата-ана / родитель	➕ Кестеде пәндері қиындығы ескерілмеген/ Не учтена сложность предметов	7	Б	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
10	Binom school им. Ы. Алтынсарина	2025-08-21	07:17:51	Қызметкер / Сотрудник	🔁 Кабинеттер алыс / Длинные переходы между кабинетами	4	А	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
11	Binom school им. Ы. Алтынсарина	2025-08-21	07:18:20	Оқушы / Ученик	🗓 Кестеде қате / Ошибка в расписании	9	Ғ	Биология	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
12	Binom school им. Ы. Алтынсарина	2025-08-21	07:18:44	Оқушы / Ученик	⏱ Үзілістер қолайсыз / Перемены слишком короткие или длинные	11	Л	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
13	Binom school им. Ы. Алтынсарина	2025-08-21	07:19:03	Оқушы / Ученик	🔁 Кабинеттер алыс / Длинные переходы между кабинетами	4	Б	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
14	Binom school им. Ы. Алтынсарина	2025-08-21	07:19:30	Қызметкер / Сотрудник	⏱ Үзілістер қолайсыз / Перемены слишком короткие или длинные	7	Д	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
15	Binom school им. Ы. Алтынсарина	2025-08-21	07:19:54	Ата-ана / родитель	⏳ Сабақ толық өткізілмеді / Урок состоялся частично	10	Д	География	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
16	Binom school им. Ы. Алтынсарина	2025-08-21	07:20:18	Оқушы / Ученик	➕ Кестеде пәндері қиындығы ескерілмеген/ Не учтена сложность предметов	0	И	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
17	Binom school им. Ы. Алтынсарина	2025-08-21	12:38:00	Ата-ана / родитель	🔁 Кабинеттер алыс / Длинные переходы между кабинетами	6	А	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
18	Binom school им. А. Кекилбаева	2025-08-21	12:44:52	Ата-ана / родитель	❌ Сабақ өткізілмеді / Урок не состоялся	4	Б	Химия	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
19	Binom School им. А. Бөкейхана	2025-08-21	15:55:48	Ата-ана / родитель	❌ Сабақ өткізілмеді / Урок не состоялся	1	Ә	Орыс тілі	2025-08-21	\N	\N	\N	Forms	ллл	\N	2025-08-31 19:43:45.381751
20	Binom School им. А. Бөкейхана	2025-08-21	16:01:45	Ата-ана / родитель	❌ Сабақ өткізілмеді / Урок не состоялся	2	А	Орыс тілі	2025-08-21	\N	\N	\N	Forms	булт	\N	2025-08-31 19:43:45.381751
21	Binom School им. А. Бөкейхана	2025-08-21	16:03:21	Ата-ана / родитель	⏳ Сабақ толық өткізілмеді / Урок состоялся частично	4	В	Биология	2025-08-21	\N	\N	\N	Forms	балкан	\N	2025-08-31 19:43:45.381751
22	Binom School им. А. Бөкейхана	2025-08-21	16:06:14	Ата-ана / родитель	❌ Сабақ өткізілмеді / Урок не состоялся	11	Б	Биология	2025-08-21	\N	\N	\N	Forms	""""""""""""""""""""""""	\N	2025-08-31 19:43:45.381751
23	Binom school Школа-лицей им. Аль-Фараби	2025-08-21	16:07:04	Оқушы / Ученик	❌ Сабақ өткізілмеді / Урок не состоялся	5	Б	География	2025-08-21	\N	\N	\N	Forms	твлоыдтиоиварф	\N	2025-08-31 19:43:45.381751
24	Binom school им. Қ. Сәтбаева	2025-08-21	16:07:34	Қызметкер / Сотрудник	❌ Сабақ өткізілмеді / Урок не состоялся	4	В	Химия	2025-08-21	\N	\N	\N	Forms	иавы	\N	2025-08-31 19:43:45.381751
25	Binom school им. А. Кекилбаева	2025-08-21	16:09:31	Ата-ана / родитель	🗓 Кестеде қате / Ошибка в расписании	7	Ғ	Физика	2025-08-21	\N	\N	\N	Forms	azat	\N	2025-08-31 19:43:45.381751
26	Binom school им. А. Кекилбаева	2025-08-21	16:10:06	Қызметкер / Сотрудник	🗓 Кестеде қате / Ошибка в расписании	6	Д	Химия	2025-08-20	\N	\N	\N	Forms	aza	\N	2025-08-31 19:43:45.381751
27	Binom school им. А. Кекилбаева	2025-08-21	16:10:42	Оқушы / Ученик	🗓 Кестеде қате / Ошибка в расписании	5	В	Ағылшын тілі	2025-08-22	\N	\N	\N	Forms	az	\N	2025-08-31 19:43:45.381751
28	Binom School им. Қадыр Мырза Әлі	2025-08-22	18:29:43	ЕҚжЕ инженері (еңбек қорғау және қауіпсіздік инженері) БиОТ	📅 Сабақ кестесі және сабақтың дұрыс өтпеуі / Расписание и срывы уроков	6	Л	Математика	2025-08-22	\N	\N	\N	Forms	пп	рр	2025-08-31 19:43:45.381751
29	Binom school им. А. Байтұрсынұлы 	2025-08-29	06:17:27	Ата-ана / родитель	❌ Сабақ өткізілмеді / Урок не состоялся	2	Ә	Физика	\N	\N	\N	\N	Forms	\N	546	2025-08-31 19:43:45.381751
30	Binom school им. А. Байтұрсынұлы 	2025-08-29	10:46:17	Ата-ана / родитель	🗓 Кестеде қате / Ошибка в расписании	1	Б	Ағылшын тілі	2025-08-28	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.381751
\.


--
-- TOC entry 3650 (class 0 OID 16494)
-- Dependencies: 234
-- Data for Name: q2; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.q2 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_grate, edu_litter, edu_subject, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom school им. Ы. Алтынсарина	2025-08-21	07:48:16	Оқушы / Ученик	📊 Бағалау әдісі / Система оценивания	2	В	Биология	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
2	Binom School им. Қадыр Мырза Әлі	2025-08-21	07:48:47	Қызметкер / Сотрудник	🏠 Үй жұмысы тым көп / Слишком много домашнего задания	5	Г	Қазақ тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
3	Binom school им. Қ. Сәтбаева	2025-08-21	07:49:10	Ата-ана / родитель	➕ Мұғалім тарапынан дөрекілік / Грубость со стороны учителя	4	З	Қазақ тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
4	Binom school им. Ы. Алтынсарина	2025-08-21	07:49:34	Қызметкер / Сотрудник	🤔 Мұғалімнің түсіндіруі қиын / Сложно понять объяснение учителя	11	А	Орыс тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
5	Binom school им. Қ. Сәтбаева	2025-08-21	07:49:56	Ата-ана / родитель	🏠 Үй жұмысы тым көп / Слишком много домашнего задания	6	Ғ	Дене шынықтыру	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
6	Binom School им. Қадыр Мырза Әлі	2025-08-21	07:50:30	Оқушы / Ученик	📊 Бағалау әдісі / Система оценивания	10	Ғ	Ағылшын тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
7	Binom school им. А. Кекилбаева	2025-08-21	07:50:58	Ата-ана / родитель	➕ Мұғалім тарапынан дөрекілік / Грубость со стороны учителя	7	В	Математика	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
8	Binom school им. А. Байтұрсынұлы 	2025-08-21	07:51:30	Ата-ана / родитель	🤔 Мұғалімнің түсіндіруі қиын / Сложно понять объяснение учителя	1	Д	Қазақ тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
9	Binom school им. Ы. Алтынсарина	2025-08-21	07:52:00	Оқушы / Ученик	🤔 Мұғалімнің түсіндіруі қиын / Сложно понять объяснение учителя	11	В	Биология	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
10	Binom school им. А. Байтұрсынұлы 	2025-08-21	09:24:00	Қызметкер / Сотрудник	🤔 Мұғалімнің түсіндіруі қиын / Сложно понять объяснение учителя	5	В	Ағылшын тілі	\N	\N	\N	Forms	\N	59559	2025-08-31 19:43:45.396795
11	Binom school им. А. Кекилбаева	2025-08-21	15:56:12	Оқушы / Ученик	📊 Бағалау әдісі / Система оценивания	5	Б	Физика	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
12	Binom School им. А. Бөкейхана	2025-08-21	15:57:15	Ата-ана / родитель	➕ Мұғалім тарапынан дөрекілік / Грубость со стороны учителя	4	Г	Орыс тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
13	Binom school им. Ы. Алтынсарина	2025-08-21	15:59:41	Ата-ана / родитель	➕ Мұғалім тарапынан дөрекілік / Грубость со стороны учителя	2	Г	Химия	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
14	Binom School им. А. Бөкейхана	2025-08-21	16:03:56	Оқушы / Ученик	🏠 Үй жұмысы тым көп / Слишком много домашнего задания	2	А	Орыс тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
15	Binom school им. А. Кекилбаева	2025-08-21	16:04:24	Оқушы / Ученик	➕ Мұғалім тарапынан дөрекілік / Грубость со стороны учителя	7	В	Ағылшын тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
16	Binom school им. А. Кекилбаева	2025-08-21	16:05:04	Қызметкер / Сотрудник	📊 Бағалау әдісі / Система оценивания	7	Г	Ағылшын тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
17	Binom school Школа-лицей им. Аль-Фараби	2025-08-21	16:17:42	Ата-ана / родитель	📊 Бағалау әдісі / Система оценивания	3	Б	Қазақ тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
18	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:17:51	Ата-ана / родитель	📊 Бағалау әдісі / Система оценивания	3	В	Математика	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
19	Binom school им. Қ. Сәтбаева	2025-08-21	16:18:39	Оқушы / Ученик	➕ Мұғалім тарапынан дөрекілік / Грубость со стороны учителя	3	Г	География	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
20	Binom school им. А. Кекилбаева	2025-08-21	16:18:57	Оқушы / Ученик	🤔 Мұғалімнің түсіндіруі қиын / Сложно понять объяснение учителя	5	Б	Орыс тілі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.396795
21	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:19:10	Қызметкер / Сотрудник	🤔 Мұғалімнің түсіндіруі қиын / Сложно понять объяснение учителя	5	В	Физика	\N	\N	\N	Forms	\N	Омом	2025-08-31 19:43:45.396795
22	FARABI SCHOOL ATYRAU	2025-08-22	18:34:22	Директор	📊 Бағалау әдісі / Система оценивания	0	А	Қазақ тілі	\N	\N	\N	Forms	ййй	ййй	2025-08-31 19:43:45.396795
\.


--
-- TOC entry 3652 (class 0 OID 16505)
-- Dependencies: 236
-- Data for Name: q3; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.q3 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_full_name, edu_grate, edu_litter, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom School им. Қадыр Мырза Әлі	2025-08-21	07:52:37	Қызметкер / Сотрудник	⏱ Сабақтан >10 мин кешігу / Отсутствие на уроке более 10 минут	.	7	В	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.409242
2	Binom school им. Ы. Алтынсарина	2025-08-21	07:53:12	Қызметкер / Сотрудник	🙅‍♂️ Тапсырманы орындаудан бас тарту, дөрекі мінез-құлық / Отказ выполнять задания, дерзкое поведение	.	4	В	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.409242
3	Binom school им. Ы. Алтынсарина	2025-08-21	07:53:41	Оқушы / Ученик	📲 Буллинг / Кибербуллинг	.	0	Д	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.409242
4	Binom School им. А. Бөкейхана	2025-08-21	07:54:06	Ата-ана / родитель	🔊 Шу, назар аудармау, тәртіп бұзу / Шум, отвлечение, нарушение порядка	.	5	Б	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.409242
5	Binom School им. Қадыр Мырза Әлі	2025-08-21	07:54:45	Ата-ана / родитель	🚬 Тыйым салынған заттарды пайдалану (шылым, вейп және т.б.) / Использование запрещённых предметов (сигареты, вейпы и т.п.)	.	0	Ә	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.409242
6	Binom School им. Қадыр Мырза Әлі	2025-08-21	07:55:15	Ата-ана / родитель	📱 Телефон немесе құрылғыны сабақта пайдалану / Использование телефона или гаджета на уроке	.	3	Б	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.409242
7	Binom school им. Қ. Сәтбаева	2025-08-21	07:55:43	Қызметкер / Сотрудник	⏱ Сабақтан >10 мин кешігу / Отсутствие на уроке более 10 минут	ю	2	Б	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.409242
8	Binom school им. А. Кекилбаева	2025-08-21	15:56:40	Қызметкер / Сотрудник	⏱ Сабақтан >10 мин кешігу / Отсутствие на уроке более 10 минут	азат	5	Б	\N	\N	\N	Forms	ууу	\N	2025-08-31 19:43:45.409242
9	Binom School им. А. Бөкейхана	2025-08-21	16:00:31	Ата-ана / родитель	🔊 Шу, назар аудармау, тәртіп бұзу / Шум, отвлечение, нарушение порядка	пппррр	3	В	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.409242
10	Binom School им. А. Бөкейхана	2025-08-21	16:05:38	Ата-ана / родитель	⏱ Сабақтан >10 мин кешігу / Отсутствие на уроке более 10 минут	рев	7	Б	\N	\N	\N	Forms	!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	\N	2025-08-31 19:43:45.409242
11	Binom school им. Қ. Сәтбаева	2025-08-21	16:20:03	Ата-ана / родитель	🙅‍♂️ Тапсырманы орындаудан бас тарту, дөрекі мінез-құлық / Отказ выполнять задания, дерзкое поведение	n	5	Б	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.409242
12	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:20:18	Оқушы / Ученик	🔊 Шу, назар аудармау, тәртіп бұзу / Шум, отвлечение, нарушение порядка	Ьаоаом	4	Г	\N	\N	\N	Forms	Шмшмшм	Тслсом	2025-08-31 19:43:45.409242
13	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:21:01	Ата-ана / родитель	🔊 Шу, назар аудармау, тәртіп бұзу / Шум, отвлечение, нарушение порядка	Омоашс	4	В	\N	\N	\N	Forms	Лмлмои	Лалмли	2025-08-31 19:43:45.409242
14	Binom school им. А. Байтұрсынұлы 	2025-08-22	18:39:02	IT қызметі	🔊 Шу, назар аудармау, тәртіп бұзу / Шум, отвлечение, нарушение порядка	ааа	1	Ә	\N	\N	\N	Forms	ааа	ааа	2025-08-31 19:43:45.409242
\.


--
-- TOC entry 3654 (class 0 OID 16516)
-- Dependencies: 238
-- Data for Name: q4; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.q4 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom School им. А. Бөкейхана	2025-08-21	11:42:23	Қызметкер / Сотрудник	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
2	Binom school им. А. Байтұрсынұлы 	2025-08-21	11:42:33	Ата-ана / родитель	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
3	Binom school им. Қ. Сәтбаева	2025-08-21	11:42:46	Ата-ана / родитель	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
4	Binom School им. А. Бөкейхана	2025-08-21	11:43:05	Оқушы / Ученик	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
5	Binom school им. Қ. Сәтбаева	2025-08-21	11:43:17	Қызметкер / Сотрудник	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
6	Binom School им. Қадыр Мырза Әлі	2025-08-21	11:43:33	Қызметкер / Сотрудник	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
7	Binom school им. А. Кекилбаева	2025-08-21	11:43:46	Оқушы / Ученик	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
8	Binom School им. Қадыр Мырза Әлі	2025-08-21	11:43:59	Ата-ана / родитель	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
9	Binom school им. А. Кекилбаева	2025-08-21	11:44:18	Оқушы / Ученик	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
10	Binom school им. А. Кекилбаева	2025-08-21	11:44:36	Оқушы / Ученик	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
11	Binom school им. Ы. Алтынсарина	2025-08-21	14:40:51	Ата-ана / родитель	54	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
12	Binom school им. А. Байтұрсынұлы 	2025-08-21	14:43:31	Ата-ана / родитель	456	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
13	Binom School им. А. Бөкейхана	2025-08-21	15:14:21	Қызметкер / Сотрудник	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
14	Binom school им. Қ. Сәтбаева	2025-08-21	16:25:27	Ата-ана / родитель	123	\N	\N	\N	Forms	123	\N	2025-08-31 19:43:45.419383
15	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:25:35	Оқушы / Ученик	Омом	\N	\N	\N	Forms	Омом	Омомши	2025-08-31 19:43:45.419383
16	Binom school им. Қ. Сәтбаева	2025-08-21	16:25:44	Қызметкер / Сотрудник	456	\N	\N	\N	Forms	456	\N	2025-08-31 19:43:45.419383
17	FARABI SCHOOL SHYMKENT	2025-08-22	18:22:59	Директор	әіәіә	\N	\N	\N	Forms	әіәіәіәіәі	әіәіәіәіәі	2025-08-31 19:43:45.419383
18	Binom School им. Қадыр Мырза Әлі	2025-08-23	12:05:47	Іс жүргізуші	354	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.419383
\.


--
-- TOC entry 3656 (class 0 OID 16527)
-- Dependencies: 240
-- Data for Name: q5; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.q5 (id, edu_school, edu_date, edu_time, edu_total_teachers, edu_illness, edu_business_trip, edu_personal_reasons, edu_professional_development, edu_other, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom School им. А. Бөкейхана	2025-08-22	18:44:50	12	12	12	12	12	12	\N	Forms	12	12	2025-08-31 19:43:45.428843
\.


--
-- TOC entry 3632 (class 0 OID 16387)
-- Dependencies: 216
-- Data for Name: s1; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s1 (id, edu_school, edu_date, edu_time, edu_role, edu_class_num, edu_floor, edu_classroom, edu_problem, edu_condition, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom school им. А. Байтұрсынұлы 	2025-08-14	03:15:50	Ата-ана / родитель	1	\N	405	Сынған жиһаз / Сломанная мебель	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	87019247106.0	2025-08-31 19:43:45.434911
2	Binom School им. Қадыр Мырза Әлі	2025-08-15	03:19:29	Қызметкер / Сотрудник	1	\N	101	Еден лас / Грязный пол	⚠ Орташа / Удовлетворительное	\N	\N	[{"name":"image_Ержан Жиренбай.jpg","link":"https://ismagulovttbigroup-my.sharepoint.com/personal/kasimov_ba_bi_group/Documents/%D0%9F%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F/Microsoft%20Forms/%D0%9C%D0%B5%D0%BA%D1%82%D0%B5%D0%BF%D1%82%D1%96%20%D0%B1%D1%96%D1%80%D0%B3%D0%B5%20%D0%B6%D0%B0%D2%9B%D1%81%D0%B0%D1%80%D1%82%D0%B0%D0%BC%D1%8B%D0%B7!%20%D0%A1%D0%B4%D0%B5%D0%BB%D0%B0%D0%B5%D0%BC%20%D1%88%D0%BA%D0%BE%D0%BB%D1%83%20%D0%BB%D1%83%D1%87%D1%88%D0%B5%20%D0%B2%D0%BC/%D0%92%D0%BE%D0	Microsoft Forms	Пошпв	87654322115.0	2025-08-31 19:43:45.434911
3	Binom school им. А. Байтұрсынұлы 	2025-08-15	04:57:52	Қызметкер / Сотрудник	1	\N	207	Еден лас / Грязный пол	⚠ Орташа / Удовлетворительное	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
4	Binom school им. Ы. Алтынсарина	2025-08-16	05:02:51	Оқушы / Ученик	1	\N	413	Еден лас / Грязный пол	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
5	Binom school им. Ы. Алтынсарина	2025-08-16	05:06:42	Қызметкер / Сотрудник	1	\N	313	Сынған жиһаз / Сломанная мебель	⚠ Орташа / Удовлетворительное	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
6	Binom school им. А. Байтұрсынұлы 	2025-08-17	05:55:39	Оқушы / Ученик	1	\N	сьмли	Терезе жабылмайды / Не закрывается окно	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	87019257106.0	2025-08-31 19:43:45.434911
7	Binom school им. А. Байтұрсынұлы 	2025-08-17	09:13:43	Ата-ана / родитель	1	\N	316	Қоқыс шығарылмаған / Мусор не вынесен	⚠ Орташа / Удовлетворительное	\N	\N	\N	Microsoft Forms	порл	6695.0	2025-08-31 19:43:45.434911
8	Binom school им. Қ. Сәтбаева	2025-08-18	15:32:50	Оқушы / Ученик	1	\N	123	Қоқыс шығарылмаған / Мусор не вынесен	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
9	Binom school им. А. Байтұрсынұлы 	2025-08-18	15:33:33	Қызметкер / Сотрудник	1	\N	789	\N	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
10	Binom school им. Ы. Алтынсарина	2025-08-19	15:41:23	Оқушы / Ученик	1	\N	123	\N	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
11	Binom school им. Ы. Алтынсарина	2025-08-19	15:41:54	Қызметкер / Сотрудник	1	\N	159	\N	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
12	Binom school им. Ы. Алтынсарина	2025-08-20	15:42:20	Ата-ана / родитель	1	\N	741	\N	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
13	Binom school им. Ы. Алтынсарина	2025-08-20	15:43:48	Ата-ана / родитель	1	\N	555	Сынған жиһаз / Сломанная мебель	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
14	Binom school им. А. Байтұрсынұлы 	2025-08-21	15:44:14	Оқушы / Ученик	1	\N	666	Сынған жиһаз / Сломанная мебель	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
15	Binom School им. А. Бөкейхана	2025-08-21	15:44:37	Қызметкер / Сотрудник	1	\N	777	Сынған жиһаз / Сломанная мебель	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
16	Binom school им. А. Байтұрсынұлы 	2025-08-22	03:11:25	Қызметкер / Сотрудник	1	\N	Лслмл	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
17	Binom school им. А. Байтұрсынұлы 	2025-08-22	03:14:49	Қызметкер / Сотрудник	1	3.0	363	Қоқыс шығарылмаған / Мусор не вынесен	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
18	Binom school им. А. Байтұрсынұлы 	2025-08-22	06:39:49	Ата-ана / родитель	1	1.0	555	Қоқыс шығарылмаған / Мусор не вынесен	⚠ Орташа / Удовлетворительное	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
19	Binom school им. А. Байтұрсынұлы 	2025-08-22	07:07:35	Қызметкер / Сотрудник	1	1.0	111	Сынған жиһаз / Сломанная мебель	⚠ Орташа / Удовлетворительное	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
20	Binom school им. А. Байтұрсынұлы 	2025-08-22	07:08:22	Оқушы / Ученик	1	1.0	222	Қоқыс шығарылмаған / Мусор не вынесен	❌ Нашар / Плохое	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
21	Binom school им. А. Байтұрсынұлы 	2025-08-22	07:12:24	Ата-ана / родитель	1	1.0	44	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
22	Binom school им. А. Байтұрсынұлы 	2025-08-22	07:13:49	Қызметкер / Сотрудник	1	2.0	55	Қоқыс шығарылмаған / Мусор не вынесен	⚠ Орташа / Удовлетворительное	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
23	Riviera International School	2025-08-22	07:22:07	Ата-ана / родитель	1	1.0	777	Сынған жиһаз / Сломанная мебель	⚠ Орташа / Удовлетворительное	\N	\N	\N	Microsoft Forms	41	\N	2025-08-31 19:43:45.434911
24	FARABI SCHOOL ATYRAU	2025-08-22	07:27:52	Ата-ана / родитель	1	1.0	41	Сынған жиһаз / Сломанная мебель	⚠ Орташа / Удовлетворительное	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
25	Binom School им. А. Бөкейхана	2025-08-22	08:47:18	Оқушы / Ученик	1	1.0	11	Қоқыс шығарылмаған / Мусор не вынесен	❌ Нашар / Плохое	\N	\N	\N	Microsoft Forms	\N	\N	2025-08-31 19:43:45.434911
26	Binom school им. А. Байтұрсынұлы 	2025-08-22	09:18:05	Директор	12	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Microsoft Forms	0	0.0	2025-08-31 19:43:45.434911
27	Binom school им. А. Байтұрсынұлы 	2025-08-25	09:30:59	Шаруашылық меңгерушісі	1	2.0	412	Қоқыс шығарылмаған / Мусор не вынесен	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
28	Binom school им. А. Байтұрсынұлы 	2025-08-25	10:46:57	Шаруашылық меңгерушісі	7	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
29	Binom school им. Қ. Сәтбаева	2025-08-25	10:48:59	Директор	5	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
30	Binom school Школа-лицей им. Аль-Фараби	2025-08-26	10:02:59	Директор	4	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
31	Binom school им. Қ. Сәтбаева	2025-08-26	10:03:45	Шаруашылық меңгерушісі	3	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
32	Riviera International School	2025-08-26	10:43:33	Директор	4	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
33	Binom school им. А. Кекилбаева	2025-08-26	00:00:00	Ата-ана / родитель	1	1.0	123	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
34	Binom School им. А. Бөкейхана	2025-08-26	00:00:00	Ата-ана / родитель	1	3.0	14	Қоқыс шығарылмаған / Мусор не вынесен	❌ Нашар / Плохое	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
35	FARABI SCHOOL ATYRAU	2025-08-26	00:00:00	Ата-ана / родитель	1	2.0	456	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
36	Binom school им. А. Кекилбаева	2025-08-26	00:00:00	Оқушы / Ученик	1	4.0	78	Қоқыс шығарылмаған / Мусор не вынесен	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
37	FARABI SCHOOL ATYRAU	2025-08-26	00:00:00	Ата-ана / родитель	1	2.0	456	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
38	FARABI SCHOOL ATYRAU	2025-08-26	00:00:00	Ата-ана / родитель	1	2.0	456	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
39	FARABI SCHOOL ATYRAU	2025-08-26	00:00:00	Ата-ана / родитель	1	2.0	456	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
40	FARABI SCHOOL ATYRAU	2025-08-26	00:00:00	Ата-ана / родитель	1	2.0	456	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
41	FARABI SCHOOL ATYRAU	2025-08-26	00:00:00	Ата-ана / родитель	1	2.0	456	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
42	FARABI SCHOOL ATYRAU	2025-08-26	00:00:00	Ата-ана / родитель	1	2.0	456	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
43	FARABI SCHOOL ATYRAU	2025-08-26	00:00:00	Ата-ана / родитель	1	2.0	456	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
44	FARABI SCHOOL ATYRAU	2025-08-26	00:00:00	Ата-ана / родитель	1	2.0	456	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
45	Binom School им. А. Бөкейхана	2025-08-26	00:00:00	Ата-ана / родитель	1	3.0	453	Сынған жиһаз / Сломанная мебель	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
46	Binom School им. А. Бөкейхана	2025-08-26	11:36:35	Ата-ана / родитель	5	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
47	Binom school им. А. Кекилбаева	2025-08-26	00:00:00	Ата-ана / родитель	1	3.0	123	Еден лас / Грязный пол	✅ Жақсы / Хорошее	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
48	Binom School им. А. Бөкейхана	2025-08-26	13:17:39	Шаруашылық меңгерушісі	6	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
49	Binom school им. Қ. Сәтбаева	2025-08-26	13:18:13	Шаруашылық меңгерушісі	1	3.0	123	\N	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
50	Binom School им. А. Бөкейхана	2025-08-26	13:19:27	Шаруашылық меңгерушісі	1	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
51	Binom school им. Қ. Сәтбаева	2025-08-26	18:08:13	Медициналық қызметкер	6	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	13213	\N	2025-08-31 19:43:45.434911
52	Binom school им. Қ. Сәтбаева	2025-08-26	18:10:33	Шаруашылық меңгерушісі	1	3.0	2345	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	245235	\N	2025-08-31 19:43:45.434911
53	Binom school им. Қ. Сәтбаева	2025-08-26	18:10:33	Шаруашылық меңгерушісі	1	3.0	2345	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	245235	\N	2025-08-31 19:43:45.434911
54	Binom School им. Қадыр Мырза Әлі	2025-08-26	18:13:25	Директордың орынбасарлары	1	3.0	86786	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
55	Binom school им. Қ. Сәтбаева	2025-08-26	18:16:38	Директордың орынбасарлары	1	3.0	46	Қоқыс шығарылмаған / Мусор не вынесен	❌ Нашар / Плохое	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
56	Binom School им. Қадыр Мырза Әлі	2025-08-26	18:13:25	Директордың орынбасарлары	1	3.0	86786	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
57	Binom school им. А. Кекилбаева	2025-08-26	18:20:03	ЕҚжЕ инженері (еңбек қорғау және қауіпсіздік инженері) БиОТ	1	3.0	3456	Еден лас / Грязный пол	❌ Нашар / Плохое	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
58	FARABI SCHOOL SHYMKENT	2025-08-27	03:23:27	Шаруашылық меңгерушісі	4	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
59	Binom school Авангард	2025-08-27	03:24:04	Шаруашылық меңгерушісі	1	1.0	123	Сынған жиһаз / Сломанная мебель	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
60	Binom school им. А. Байтұрсынұлы 	2025-08-27	03:29:39	Шаруашылық меңгерушісі	2	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
61	FARABI SCHOOL ATYRAU	2025-08-27	03:31:05	Шаруашылық меңгерушісі	1	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
62	Binom school им. Ы. Алтынсарина	2025-08-27	03:31:38	Шаруашылық меңгерушісі	1	4.0	111	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
63	Binom school им. Қ. Сәтбаева	2025-08-27	03:40:21	Шаруашылық меңгерушісі	2	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
64	Binom school им. А. Кекилбаева	2025-08-27	03:41:53	Шаруашылық меңгерушісі	1	2.0	123	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
65	Riviera International School	2025-08-27	05:14:39	Шаруашылық меңгерушісі	1	3.0	123	123	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
66	Riviera International School	2025-08-27	05:36:42	Директор	1	3.0	111	Пролита жидкость	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
67	Binom School им. А. Бөкейхана	2025-08-27	09:18:34	Шаруашылық меңгерушісі	1	2.0	12	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
68	Binom school им. Қ. Сәтбаева	2025-08-27	09:19:56	Директор	1	2.0	45	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
69	Binom school Авангард	2025-08-27	09:41:57	Шаруашылық меңгерушісі	1	2.0	41	Сынған жиһаз / Сломанная мебель	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
70	Binom school им. А. Кекилбаева	2025-08-27	00:00:00	Ата-ана / родитель	1	3.0	44	Қоқыс шығарылмаған / Мусор не вынесен	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
71	Binom ​Школа-лицей им. Динмухаммеда Кунаева	2025-08-27	00:00:00	Ата-ана / родитель	1	2.0	11	Терезе жабылмайды / Не закрывается окно	❌ Нашар / Плохое	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
72	Binom School им. А. Бөкейхана	2025-08-27	00:00:00	Ата-ана / родитель	1	4.0	13	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
73	Binom school им. А. Байтұрсынұлы 	2025-08-27	10:11:50	Шаруашылық меңгерушісі	1	2.0	33	Еден лас / Грязный пол	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
74	Binom school им. А. Байтұрсынұлы 	2025-08-27	10:12:26	Шаруашылық меңгерушісі	3	\N	\N	Другое	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
75	Binom School им. А. Бөкейхана	2025-08-27	00:00:00	Ата-ана / родитель	1	3.0	55	Сынған жиһаз / Сломанная мебель	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
76	Binom school Авангард	2025-08-27	00:00:00	Оқушы / Ученик	1	3.0	12	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.434911
77	Binom School им. А. Бөкейхана	2025-08-27	00:00:00	Оқушы / Ученик	0	3.0	0	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
78	Binom School им. А. Бөкейхана	2025-08-27	00:00:00	Ата-ана / родитель	0	4.0	0	Сынған жиһаз / Сломанная мебель	❌ Нашар / Плохое	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
79	Binom School им. Қадыр Мырза Әлі	2025-08-27	00:00:00	Оқушы / Ученик	0	4.0	0	Еден лас / Грязный пол	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
80	Binom school им. А. Кекилбаева	2025-08-27	00:00:00	Ата-ана / родитель	1	3.0	55	Еден лас / Грязный пол	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
81	Binom school им. А. Кекилбаева	2025-08-27	00:00:00	Оқушы / Ученик	1	4.0	66	Еден лас / Грязный пол	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
82	Binom School им. А. Бөкейхана	2025-08-27	00:00:00	Ата-ана / родитель	1	3.0	101	Терезе жабылмайды / Не закрывается окно	❌ Нашар / Плохое	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
83	Binom School им. А. Бөкейхана	2025-08-27	00:00:00	Оқушы / Ученик	1	2.0	1010	Еден лас / Грязный пол	❌ Нашар / Плохое	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
84	Binom School им. А. Бөкейхана	2025-08-27	11:01:46	Оқушы / Ученик	1	3.0	1414	Еден лас / Грязный пол	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
85	Binom School им. А. Бөкейхана	2025-08-27	11:16:43	Оқушы / Ученик	1	3.0	11	Қоқыс шығарылмаған / Мусор не вынесен	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
86	Binom School им. Қадыр Мырза Әлі	2025-08-27	11:19:45	Ата-ана / родитель	1	4.0	333	Қоқыс шығарылмаған / Мусор не вынесен	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
87	Binom School им. А. Бөкейхана	2025-08-27	11:23:22	Оқушы / Ученик	1	1.0	232	Еден лас / Грязный пол	❌ Нашар / Плохое	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
88	Binom School им. А. Бөкейхана	2025-08-27	12:48:00	Шаруашылық меңгерушісі	1	2.0	11	Сынған жиһаз / Сломанная мебель	❌ Нашар / Плохое	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
89	Binom school им. А. Кекилбаева	2025-08-28	06:32:12	Ата-ана / родитель	1	3.0	33	Терезе жабылмайды / Не закрывается окно	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
90	Binom School им. А. Бөкейхана	2025-08-28	06:33:05	Шаруашылық меңгерушісі	1	2.0	44	Еден лас / Грязный пол	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
91	Binom school им. А. Байтұрсынұлы 	2025-08-29	06:16:00	Шаруашылық меңгерушісі	12	\N	\N	Другое	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.434911
\.


--
-- TOC entry 3634 (class 0 OID 16398)
-- Dependencies: 218
-- Data for Name: s2; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s2 (id, edu_school, edu_date, edu_time, edu_role, edu_loc_num, edu_floor, edu_location, edu_place, edu_problem, edu_condition, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom ​Школа-лицей им. Динмухаммеда Кунаева	2025-08-17	04:54:45	Ата-ана / родитель	1	1.0	Дәліз / Коридор	\N	Лас / Грязь – еден, қабырға, иіс / пол, стены, запах	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
2	Binom school им. А. Байтұрсынұлы 	2025-08-18	04:58:18	Оқушы / Ученик	1	2.0	Спортзал / Спортзал	Ьалм	Су ағуы / Утечка воды – кран, құбыр / краны, трубы	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
3	Binom school им. Ы. Алтынсарина	2025-08-18	05:02:16	Оқушы / Ученик	1	2.0	Спортзал / Спортзал	\N	Лас / Грязь – еден, қабырға, иіс / пол, стены, запах	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
4	Binom school им. Ы. Алтынсарина	2025-08-19	05:04:13	Оқушы / Ученик	1	1.0	Баспалдақ / Лестница	\N	Қауіпсіздік бұзушылығы / Нарушение безопасности – сырғанақ еден, сымдар / скользкий пол, провода	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
5	Binom school им. Ы. Алтынсарина	2025-08-19	05:05:29	Ата-ана / родитель	1	1.0	Дәліз / Коридор	\N	Лас / Грязь – еден, қабырға, иіс / пол, стены, запах	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
6	Binom school им. Ы. Алтынсарина	2025-08-20	05:05:59	Қызметкер / Сотрудник	1	4.0	Фойе (холл) / Холл	\N	Лас / Грязь – еден, қабырға, иіс / пол, стены, запах	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
7	Binom School им. А. Бөкейхана	2025-08-20	15:51:35	Оқушы / Ученик	1	3.0	Асхана аймағы / Зона столовой	333	Лас / Грязь – еден, қабырға, иіс / пол, стены, запах	✅ Жақсы / Хорошее	\N	\N	\N	Forms	222	\N	2025-08-31 19:43:45.467592
8	Binom school им. А. Байтұрсынұлы 	2025-08-21	15:52:16	Ата-ана / родитель	1	2.0	Әжетхана / Санузел	444	Лас / Грязь – еден, қабырға, иіс / пол, стены, запах	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	555	\N	2025-08-31 19:43:45.467592
9	Binom school им. А. Байтұрсынұлы 	2025-08-21	15:52:42	Қызметкер / Сотрудник	1	3.0	Әжетхана / Санузел	ффф	Лас / Грязь – еден, қабырға, иіс / пол, стены, запах	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	ыыы	\N	2025-08-31 19:43:45.467592
10	Binom school им. А. Байтұрсынұлы 	2025-08-22	17:34:30	Шаруашылық меңгерушісі	15	\N	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	wwe	wewe	2025-08-31 19:43:45.467592
11	Binom school им. А. Байтұрсынұлы 	2025-08-25	11:31:02	Директор	1	\N	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
12	Binom school им. Қ. Сәтбаева	2025-08-26	18:21:52	ЕҚжЕ инженері (еңбек қорғау және қауіпсіздік инженері) БиОТ	1	\N	Баспалдақ / Лестница	reryhfg	Су ағуы / Утечка воды – кран, құбыр / краны, трубы	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
13	Binom School им. А. Бөкейхана	2025-08-27	03:17:20	Шаруашылық меңгерушісі	12	\N	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
14	Binom school им. Қ. Сәтбаева	2025-08-27	03:18:08	Шаруашылық меңгерушісі	1	\N	Дәліз / Коридор	Спортзал	Су ағуы / Утечка воды – кран, құбыр / краны, трубы	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
15	Binom school им. А. Кекилбаева	2025-08-27	03:19:48	Шаруашылық меңгерушісі	1	\N	Баспалдақ / Лестница	Дәретхана	Жабдықтың ақауы / Неисправное оборудование – шам, техника / освещение, техника	⚠ Орташа / Удовлетворительное	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
16	Binom School им. Қадыр Мырза Әлі	2025-08-27	03:57:44	Шаруашылық меңгерушісі	3	\N	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
17	Binom School им. Қадыр Мырза Әлі	2025-08-27	03:57:44	Шаруашылық меңгерушісі	3	\N	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
18	Binom School им. Қадыр Мырза Әлі	2025-08-27	03:57:44	Шаруашылық меңгерушісі	3	\N	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
19	Binom School им. Қадыр Мырза Әлі	2025-08-27	03:57:44	Шаруашылық меңгерушісі	3	\N	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
20	Binom School им. А. Бөкейхана	2025-08-27	\N	Оқушы / Ученик	1	3.0	Асхана аймағы / Зона столовой	10	Қауіпсіздік бұзушылығы / Нарушение безопасности – сырғанақ еден, сымдар / скользкий пол, провода	❌ Нашар / Плохое	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
21	Binom school им. А. Кекилбаева	2025-08-27	\N	Қызметкер / Сотрудник	1	1.0	Асхана аймағы / Зона столовой	123	Қоқыс шығарылмаған / Мусор не вынесен – қоқыс жәшігі толы / переполненные урны	❌ Нашар / Плохое	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
22	Binom school им. Қ. Сәтбаева	2025-08-27	\N	Оқушы / Ученик	1	2.0	Фойе (холл) / Холл	12	Жабдықтың ақауы / Неисправное оборудование – шам, техника / освещение, техника	❌ Нашар / Плохое	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
23	Binom School им. А. Бөкейхана	2025-08-27	12:33:24	Шаруашылық меңгерушісі	2	\N	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
24	Binom School им. А. Бөкейхана	2025-08-28	04:37:19	Шаруашылық меңгерушісі	20	\N	\N	\N	\N	✅ Жақсы / Хорошее	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.467592
\.


--
-- TOC entry 3636 (class 0 OID 16409)
-- Dependencies: 220
-- Data for Name: s3; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s3 (id, edu_school, edu_date, edu_time, edu_role, edu_loc_num, edu_floor, edu_location, edu_place, edu_problem, edu_condition, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom school им. Ы. Алтынсарина	2025-08-15	05:09:47	Оқушы / Ученик	1	3	Дәліз / Коридор	\N	Ыстық / Жарко	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
2	Binom school им. А. Байтұрсынұлы 	2025-08-15	05:10:04	Оқушы / Ученик	1	3	Кабинет	\N	Суық / Холодно	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
3	Binom school им. А. Байтұрсынұлы 	2025-08-16	05:10:15	Ата-ана / родитель	1	3	Баспалдақ / Лестница	Ьалм	Суық / Холодно	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
4	Binom school им. Ы. Алтынсарина	2025-08-16	05:10:22	Оқушы / Ученик	1	4	Кабинет	\N	Ыстық / Жарко	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
5	Binom school им. Ы. Алтынсарина	2025-08-17	05:10:41	Қызметкер / Сотрудник	1	2	Спортзал / Спортзал	\N	Суық / Холодно	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
6	Binom school им. Ы. Алтынсарина	2025-08-17	05:10:57	Ата-ана / родитель	1	2	Кабинет	\N	Суық / Холодно	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
7	Binom school им. Ы. Алтынсарина	2025-08-18	05:11:18	Ата-ана / родитель	1	1	Кабинет	\N	Ыстық / Жарко	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
8	Binom school им. Ы. Алтынсарина	2025-08-18	05:11:41	Қызметкер / Сотрудник	1	2	Кабинет	\N	Ыстық / Жарко	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
9	Binom school им. Ы. Алтынсарина	2025-08-19	05:12:04	Оқушы / Ученик	1	4	Фойе (холл) / Холл	\N	Ыстық / Жарко	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
10	Binom school им. Ы. Алтынсарина	2025-08-19	05:12:22	Ата-ана / родитель	1	5	Әжетхана / Санузел	\N	Суық / Холодно	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
11	Binom school им. Ы. Алтынсарина	2025-08-20	05:12:47	Ата-ана / родитель	1	4	Асхана аймағы / Зона столовой	\N	Суық / Холодно	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
12	Binom school им. Ы. Алтынсарина	2025-08-20	05:13:19	Қызметкер / Сотрудник	1	1	Фойе (холл) / Холл	\N	Ыстық / Жарко	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
13	Binom school им. Қ. Сәтбаева	2025-08-21	15:53:15	Оқушы / Ученик	1	2	Фойе (холл) / Холл	место	Суық / Холодно	\N	\N	\N	\N	Forms	п	\N	2025-08-31 19:43:45.480551
14	Binom school им. А. Кекилбаева	2025-08-21	15:53:45	Қызметкер / Сотрудник	1	1	Асхана аймағы / Зона столовой	мпро	Суық / Холодно	\N	\N	\N	\N	Forms	то	\N	2025-08-31 19:43:45.480551
15	Binom school им. А. Байтұрсынұлы 	2025-08-22	15:54:13	Ата-ана / родитель	1	2	Дәліз / Коридор	про	Ыстық / Жарко	\N	\N	\N	\N	Forms	олд	\N	2025-08-31 19:43:45.480551
16	Binom school им. А. Байтұрсынұлы 	2025-08-22	03:05:33	Ата-ана / родитель	1	2	Дәліз / Коридор	Бмлми	Ыстық / Жарко	\N	\N	\N	\N	Forms	Ьмлииом	Лсомои	2025-08-31 19:43:45.480551
17	Binom school им. А. Байтұрсынұлы 	2025-08-22	03:15:00	Директор	1	1	Әжетхана / Санузел	санузел	Ыстық / Жарко	\N	\N	\N	\N	Forms	фффффф	ййййййй	2025-08-31 19:43:45.480551
18	Binom school им. А. Кекилбаева	2025-08-27	\N	Ата-ана / родитель	1	1	Баспалдақ / Лестница	вап	Суық / Холодно	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
19	Binom School им. А. Бөкейхана	2025-08-28	\N	Оқушы / Ученик	1	3	Дәліз / Коридор	12	Ыстық / Жарко	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.480551
\.


--
-- TOC entry 3638 (class 0 OID 16420)
-- Dependencies: 222
-- Data for Name: s4; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s4 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_condition, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom school им. А. Байтұрсынұлы 	2025-08-20	03:36:27	Қызметкер / Сотрудник	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
2	Binom school им. А. Байтұрсынұлы 	2025-08-20	03:51:12	Қызметкер / Сотрудник	Ыстық тамақтың болмауы / Отсутствие горячего питания	Жоғары/Высокий	\N	\N	[{"name":"17557482241511191039183376660974_Балкан Касимов.jpg","link":"https://ismagulovttbigroup-my.sharepoint.com/personal/kasimov_ba_bi_group/Documents/%D0%9F%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F/Microsoft%20Forms/%D0%9C%D0%B5%D0%BA%D1%82%D0%B5%D0%BF%D1%82%D1%96%20%D0%B1%D1%96%D1%80%D0%B3%D0%B5%20%D0%B6%D0%B0%D2%9B%D1%81%D0%B0%D1%80%D1%82%D0%B0%D0%BC%D1%8B%D0%B7!%20%D0%A1%D0%B4%D0%B5%D0%BB%D0%B0%D0%B5%D0%BC%20%D1%88%D0%BA%D0%BE%D0%BB%D1%83%20%D0%BB%D1%83%D1%87%D1%88%D0%B5%20%	Forms	Бүл тест рнжиміндегі ақпарат	87019247106	2025-08-31 19:43:45.491207
3	Binom school им. А. Байтұрсынұлы 	2025-08-20	03:36:27	Оқушы / Ученик	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
4	Binom school им. А. Байтұрсынұлы 	2025-08-21	03:51:12	Оқушы / Ученик	Ыстық тамақтың болмауы / Отсутствие горячего питания	Жоғары/Высокий	\N	\N	[{"name":"17557482241511191039183376660974_Балкан Касимов.jpg","link":"https://ismagulovttbigroup-my.sharepoint.com/personal/kasimov_ba_bi_group/Documents/%D0%9F%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F/Microsoft%20Forms/%D0%9C%D0%B5%D0%BA%D1%82%D0%B5%D0%BF%D1%82%D1%96%20%D0%B1%D1%96%D1%80%D0%B3%D0%B5%20%D0%B6%D0%B0%D2%9B%D1%81%D0%B0%D1%80%D1%82%D0%B0%D0%BC%D1%8B%D0%B7!%20%D0%A1%D0%B4%D0%B5%D0%BB%D0%B0%D0%B5%D0%BC%20%D1%88%D0%BA%D0%BE%D0%BB%D1%83%20%D0%BB%D1%83%D1%87%D1%88%D0%B5%20%	Forms	Бүл тест рнжиміндегі ақпарат	87019247106	2025-08-31 19:43:45.491207
5	Binom school им. А. Кекилбаева	2025-08-21	04:39:01	Оқушы / Ученик	Кезек > 10 минут / Очереди > 10 мин	Төмен/Низкий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
6	Binom school им. Ы. Алтынсарина	2025-08-21	04:48:30	Оқушы / Ученик	Тамақтанудың бірсарындығы / Однообразие питания	Төмен/Низкий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
7	Binom school им. Ы. Алтынсарина	2025-08-14	05:14:02	Қызметкер / Сотрудник	Бағаның жоғары болуы / Завышенные цены	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
8	Binom school им. А. Байтұрсынұлы 	2025-08-14	05:14:16	Оқушы / Ученик	Бағаның жоғары болуы / Завышенные цены	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
9	Binom school им. Ы. Алтынсарина	2025-08-14	05:14:41	Оқушы / Ученик	Санитарлық нормалардың бұзылуы / Нарушение санитарных норм	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
10	Binom school им. Ы. Алтынсарина	2025-08-14	05:15:01	Қызметкер / Сотрудник	Уақыт жетіспеуі / Не хватает времени	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
11	Binom school им. Ы. Алтынсарина	2025-08-15	05:15:18	Қызметкер / Сотрудник	Тамақтанудың бірсарындығы / Однообразие питания	Төмен/Низкий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
12	Binom school им. Қ. Сәтбаева	2025-08-15	05:15:31	Қызметкер / Сотрудник	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
13	Binom school им. Ы. Алтынсарина	2025-08-16	05:15:56	Оқушы / Ученик	Уақыт жетіспеуі / Не хватает времени	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
14	Binom school им. Қ. Сәтбаева	2025-08-16	05:16:15	Ата-ана / родитель	Тәтті сусындардың (газдалған) сатылуы / Продажа сладких (газированных) напитков	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
15	Binom school им. Ы. Алтынсарина	2025-08-17	05:16:37	Оқушы / Ученик	Тамақтанудың бірсарындығы / Однообразие питания	Төмен/Низкий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
16	Binom school им. Ы. Алтынсарина	2025-08-17	05:17:02	Ата-ана / родитель	Уақыт жетіспеуі / Не хватает времени	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
17	Binom school им. Ы. Алтынсарина	2025-08-18	05:17:39	Ата-ана / родитель	Тәтті сусындардың (газдалған) сатылуы / Продажа сладких (газированных) напитков	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
18	Binom school им. Ы. Алтынсарина	2025-08-18	05:17:50	Оқушы / Ученик	Кезек > 10 минут / Очереди > 10 мин	Төмен/Низкий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
19	Binom school им. А. Байтұрсынұлы 	2025-08-19	05:18:01	Қызметкер / Сотрудник	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
20	Binom school им. Ы. Алтынсарина	2025-08-19	05:18:17	Оқушы / Ученик	Тамақтанудың бірсарындығы / Однообразие питания	Төмен/Низкий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
21	Binom school им. А. Байтұрсынұлы 	2025-08-20	09:15:17	Оқушы / Ученик	Ыстық тамақтың болмауы / Отсутствие горячего питания	Жоғары/Высокий	\N	\N	\N	Forms	43355	465656	2025-08-31 19:43:45.491207
22	Binom school им. А. Байтұрсынұлы 	2025-08-20	11:00:39	Оқушы / Ученик	Ыстық тамақтың болмауы / Отсутствие горячего питания	Жоғары/Высокий	\N	\N	\N	Forms	Карным аш	87019247106	2025-08-31 19:43:45.491207
23	Binom school им. А. Байтұрсынұлы 	2025-08-21	12:40:26	Ата-ана / родитель	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
24	Binom School им. А. Бөкейхана	2025-08-21	15:54:40	Ата-ана / родитель	Ыстық тамақтың болмауы / Отсутствие горячего питания	Жоғары/Высокий	\N	\N	\N	Forms	ммм	\N	2025-08-31 19:43:45.491207
25	Binom school им. Қ. Сәтбаева	2025-08-22	15:55:02	Оқушы / Ученик	Санитарлық нормалардың бұзылуы / Нарушение санитарных норм	Жоғары/Высокий	\N	\N	\N	Forms	ккк	\N	2025-08-31 19:43:45.491207
26	Binom School им. А. Бөкейхана	2025-08-22	15:55:17	Қызметкер / Сотрудник	Тамақтанудың бірсарындығы / Однообразие питания	Төмен/Низкий	\N	\N	\N	Forms	еее	\N	2025-08-31 19:43:45.491207
27	Binom school им. А. Байтұрсынұлы 	2025-08-22	17:24:27	Директордың орынбасарлары	Кезек > 10 минут / Очереди > 10 мин	Төмен/Низкий	\N	\N	\N	\N	ііі	фффф	2025-08-31 19:43:45.491207
28	Binom school Школа-лицей им. Аль-Фараби	2025-08-23	10:47:57	Директор	Ыстық тамақтың болмауы / Отсутствие горячего питания	Жоғары/Высокий	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.491207
29	Binom school им. Қ. Сәтбаева	2025-08-23	10:52:47	Директор	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	\N	\N	\N	2025-08-31 19:43:45.491207
30	Binom School им. А. Бөкейхана	2025-08-28	05:17:28	Директор	Ыстық тамақтың болмауы / Отсутствие горячего питания	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
31	Binom school им. Қ. Сәтбаева	2025-08-28	10:52:47	Оқушы / Ученик	Бағаның жоғары болуы / Завышенные цены	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
32	Binom school им. Қ. Сәтбаева	2025-08-28	10:52:47	Ата-ана / родитель	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
33	Binom School им. А. Бөкейхана	2025-08-28	10:52:47	Оқушы / Ученик	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
34	Binom school им. А. Кекилбаева	2025-08-28	06:35:19	Директор	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
35	Binom School им. А. Бөкейхана	2025-08-28	10:52:47	Оқушы / Ученик	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
36	Binom School им. А. Бөкейхана	2025-08-28	06:49:14	Оқушы / Ученик	Кезек > 10 минут / Очереди > 10 мин	Төмен/Низкий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
37	Binom school им. А. Байтұрсынұлы 	2025-08-28	10:18:52	Ата-ана / родитель	Ыстық тамақтың болмауы / Отсутствие горячего питания	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
38	FARABI SCHOOL ATYRAU	2025-08-28	10:32:13	Ата-ана / родитель	Тәтті сусындардың (газдалған) сатылуы / Продажа сладких (газированных) напитков	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
39	FARABI SCHOOL SHYMKENT	2025-08-28	10:32:31	Оқушы / Ученик	Санитарлық нормалардың бұзылуы / Нарушение санитарных норм	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
40	Riviera International School	2025-08-28	10:32:48	Ата-ана / родитель	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
41	Binom school Авангард	2025-08-28	10:33:04	Оқушы / Ученик	Тамақтанудың бірсарындығы / Однообразие питания	Төмен/Низкий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
42	Binom ​Школа-лицей им. Динмухаммеда Кунаева	2025-08-28	10:33:23	Ата-ана / родитель	Уақыт жетіспеуі / Не хватает времени	Жоғары/Высокий	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
43	Binom School им. Қадыр Мырза Әлі	2025-08-28	10:34:16	Ата-ана / родитель	Салқын тағамдар / Блюда холодные	Орташа/Средний	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.491207
\.


--
-- TOC entry 3640 (class 0 OID 16431)
-- Dependencies: 224
-- Data for Name: s5; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s5 (id, edu_school, edu_date, edu_time, edu_role, edu_incident, edu_describtion, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom school им. Қ. Сәтбаева	2025-08-21	10:12:20	Ата-ана / родитель	🤕 Жеңіл жарақат / Лёгкая травма	/\n	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
2	Binom school им. А. Кекилбаева	2025-08-21	10:12:56	Ата-ана / родитель	🏥 Ауыр жарақат / Тяжёлая травма	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
3	Binom school им. А. Кекилбаева	2025-08-21	10:13:26	Ата-ана / родитель	👊 Төбелес / Драка (оқушылар арасында / между учениками)	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
4	Binom school им. А. Кекилбаева	2025-08-21	10:13:52	Ата-ана / родитель	🏥 Ауыр жарақат / Тяжёлая травма	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
5	Binom school им. Қ. Сәтбаева	2025-08-21	10:14:11	Оқушы / Ученик	🧑‍🏫 Мұғаліммен немесе қызметкермен қақтығыс / Конфликт с учителем или сотрудником	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
6	Binom school им. Ы. Алтынсарина	2025-08-21	10:15:07	Оқушы / Ученик	🧑‍🏫 Мұғаліммен немесе қызметкермен қақтығыс / Конфликт с учителем или сотрудником	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
7	Binom School им. А. Бөкейхана	2025-08-21	10:15:25	Оқушы / Ученик	🔥 Өртке байланысты жағдай / Ситуация, связанная с огнём	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
8	Binom school им. Ы. Алтынсарина	2025-08-21	10:15:46	Оқушы / Ученик	🔥 Өртке байланысты жағдай / Ситуация, связанная с огнём	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
9	Binom School им. Қадыр Мырза Әлі	2025-08-21	10:16:07	Ата-ана / родитель	💊 Дәрі-дәрмек немесе заттарды қолдану / Употребление подозрительных веществ	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
10	Binom school им. Ы. Алтынсарина	2025-08-21	10:16:33	Оқушы / Ученик	🪑 Мүлікті зақымдау қауіптілікпен / Повреждение имущества с риском	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
11	Binom school им. Ы. Алтынсарина	2025-08-21	10:16:52	Қызметкер / Сотрудник	🔥 Өртке байланысты жағдай / Ситуация, связанная с огнём	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
12	Binom school Школа-лицей им. Аль-Фараби	2025-08-21	10:17:15	Қызметкер / Сотрудник	😵 Естен тану немесе өзін жайсыз сезіну / Обморок или недомогание	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
13	Binom school им. А. Байтұрсынұлы 	2025-08-21	10:17:34	Қызметкер / Сотрудник	👊 Төбелес / Драка (оқушылар арасында / между учениками)	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
14	Binom School им. А. Бөкейхана	2025-08-21	10:18:22	Ата-ана / родитель	⚔ Қақтығыс қауіппен / Конфликт с угрозами	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
15	Binom school им. Қ. Сәтбаева	2025-08-21	10:18:44	Қызметкер / Сотрудник	⚔ Қақтығыс қауіппен / Конфликт с угрозами	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
16	Binom school им. А. Кекилбаева	2025-08-21	10:19:03	Ата-ана / родитель	🔥 Өртке байланысты жағдай / Ситуация, связанная с огнём	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
17	Binom School им. Қадыр Мырза Әлі	2025-08-21	10:19:22	Ата-ана / родитель	⚔ Қақтығыс қауіппен / Конфликт с угрозами	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
18	Binom school им. Қ. Сәтбаева	2025-08-21	10:19:45	Қызметкер / Сотрудник	🤕 Жеңіл жарақат / Лёгкая травма	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
19	Binom school им. Қ. Сәтбаева	2025-08-21	10:20:00	Ата-ана / родитель	🏥 Ауыр жарақат / Тяжёлая травма	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
20	Binom school им. А. Байтұрсынұлы 	2025-08-21	10:20:16	Ата-ана / родитель	🪑 Мүлікті зақымдау қауіптілікпен / Повреждение имущества с риском	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
21	Binom school им. Ы. Алтынсарина	2025-08-21	10:20:42	Ата-ана / родитель	😵 Естен тану немесе өзін жайсыз сезіну / Обморок или недомогание	//////	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
22	Binom school им. А. Кекилбаева	2025-08-21	10:21:00	Қызметкер / Сотрудник	🏥 Ауыр жарақат / Тяжёлая травма	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
23	Binom school им. Қ. Сәтбаева	2025-08-21	10:21:16	Оқушы / Ученик	😵 Естен тану немесе өзін жайсыз сезіну / Обморок или недомогание	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
24	Binom School им. А. Бөкейхана	2025-08-21	10:21:32	Ата-ана / родитель	💊 Дәрі-дәрмек немесе заттарды қолдану / Употребление подозрительных веществ	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
25	Binom School им. А. Бөкейхана	2025-08-21	12:38:23	Ата-ана / родитель	🪑 Мүлікті зақымдау қауіптілікпен / Повреждение имущества с риском	/	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
26	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:22:17	Ата-ана / родитель	🤕 Жеңіл жарақат / Лёгкая травма	Омоаоа	\N	\N	\N	Forms	Оаомом	Ососшм	2025-08-31 19:43:45.508925
27	Binom School им. Қадыр Мырза Әлі	2025-08-21	16:22:27	Оқушы / Ученик	🤕 Жеңіл жарақат / Лёгкая травма	aaaa	\N	\N	\N	Forms	a	\N	2025-08-31 19:43:45.508925
28	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:22:48	Қызметкер / Сотрудник	📱 Буллинг / кибербуллинг / Буллинг / кибербуллинг	Осомши	\N	\N	\N	Forms	Омомгм	Лсомши	2025-08-31 19:43:45.508925
29	Binom School им. А. Бөкейхана	2025-08-23	11:10:09	Директор	🩹 Орташа жарақат / Средняя травма	"әі	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.508925
\.


--
-- TOC entry 3642 (class 0 OID 16442)
-- Dependencies: 226
-- Data for Name: s6; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s6 (id, edu_school, edu_date, edu_time, edu_role, edu_security, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom school им. А. Байтұрсынұлы 	2025-08-21	10:23:12	Оқушы / Ученик	🚫 Пост бос тұр / Пост пустой ( работник охраны отсутствует на месте)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
2	Binom school им. Ы. Алтынсарина	2025-08-21	10:24:08	Ата-ана / родитель	🚶‍♂️ Посторонний адамның кіруі / Пропуск посторонних (охранник пропустил постороннего без проверки)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
3	Binom school им. А. Кекилбаева	2025-08-21	10:24:24	Оқушы / Ученик	🚪 Оқушыны рұқсатсыз жіберу / Несанкционированный выход ученика (отпустили ребёнка без звонка родителям или без разрешения)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
4	Binom school им. А. Кекилбаева	2025-08-21	10:24:44	Ата-ана / родитель	🗣 Қақтығыс постта / Конфликт на посту (ата-анамен жанжал, ақпарат бермеді / спор с родителем, отказ в информации, неприятный диалог)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
5	Binom school им. Ы. Алтынсарина	2025-08-21	10:25:00	Оқушы / Ученик	🗣 Қақтығыс постта / Конфликт на посту (ата-анамен жанжал, ақпарат бермеді / спор с родителем, отказ в информации, неприятный диалог)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
6	Binom school им. А. Кекилбаева	2025-08-21	10:25:12	Оқушы / Ученик	🚶‍♂️ Посторонний адамның кіруі / Пропуск посторонних (охранник пропустил постороннего без проверки)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
7	Binom school им. А. Байтұрсынұлы 	2025-08-21	10:25:30	Ата-ана / родитель	⏱ Уақтылы әрекет жасалмады / Нет реакции вовремя (охранник не вмешался, проигнорировал ситуацию)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
8	Binom School им. А. Бөкейхана	2025-08-21	10:25:47	Ата-ана / родитель	🙅 Дөрекі қарым-қатынас / Грубое поведение (грубость, невежливое обращение к ученикам или родителям)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
9	Binom school им. Қ. Сәтбаева	2025-08-21	10:26:05	Ата-ана / родитель	🙅 Дөрекі қарым-қатынас / Грубое поведение (грубость, невежливое обращение к ученикам или родителям)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
10	Binom school им. Қ. Сәтбаева	2025-08-21	10:26:20	Қызметкер / Сотрудник	🚪 Оқушыны рұқсатсыз жіберу / Несанкционированный выход ученика (отпустили ребёнка без звонка родителям или без разрешения)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
11	Binom school им. Ы. Алтынсарина	2025-08-21	10:26:37	Қызметкер / Сотрудник	🚫 Пост бос тұр / Пост пустой ( работник охраны отсутствует на месте)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
12	Binom school им. Ы. Алтынсарина	2025-08-21	10:26:52	Ата-ана / родитель	🙅 Дөрекі қарым-қатынас / Грубое поведение (грубость, невежливое обращение к ученикам или родителям)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
13	Binom School им. Қадыр Мырза Әлі	2025-08-21	10:27:08	Оқушы / Ученик	🚪 Оқушыны рұқсатсыз жіберу / Несанкционированный выход ученика (отпустили ребёнка без звонка родителям или без разрешения)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
14	Binom School им. Қадыр Мырза Әлі	2025-08-21	10:27:26	Оқушы / Ученик	🙅 Дөрекі қарым-қатынас / Грубое поведение (грубость, невежливое обращение к ученикам или родителям)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
15	Binom school им. Қ. Сәтбаева	2025-08-21	10:27:44	Ата-ана / родитель	🚪 Оқушыны рұқсатсыз жіберу / Несанкционированный выход ученика (отпустили ребёнка без звонка родителям или без разрешения)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
16	Binom School им. А. Бөкейхана	2025-08-21	10:28:02	Оқушы / Ученик	⏱ Уақтылы әрекет жасалмады / Нет реакции вовремя (охранник не вмешался, проигнорировал ситуацию)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
17	Binom School им. Қадыр Мырза Әлі	2025-08-21	10:28:43	Қызметкер / Сотрудник	🗣 Қақтығыс постта / Конфликт на посту (ата-анамен жанжал, ақпарат бермеді / спор с родителем, отказ в информации, неприятный диалог)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
18	Binom School им. Қадыр Мырза Әлі	2025-08-21	10:29:14	Қызметкер / Сотрудник	⏱ Уақтылы әрекет жасалмады / Нет реакции вовремя (охранник не вмешался, проигнорировал ситуацию)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
19	Binom school им. А. Байтұрсынұлы 	2025-08-21	10:29:32	Ата-ана / родитель	🚶‍♂️ Посторонний адамның кіруі / Пропуск посторонних (охранник пропустил постороннего без проверки)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
20	Binom ​Школа-лицей им. Динмухаммеда Кунаева	2025-08-21	10:29:49	Оқушы / Ученик	🙅 Дөрекі қарым-қатынас / Грубое поведение (грубость, невежливое обращение к ученикам или родителям)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
21	Binom School им. Қадыр Мырза Әлі	2025-08-21	10:30:08	Оқушы / Ученик	🙅 Дөрекі қарым-қатынас / Грубое поведение (грубость, невежливое обращение к ученикам или родителям)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
22	Binom school им. А. Кекилбаева	2025-08-21	10:30:26	Қызметкер / Сотрудник	⏱ Уақтылы әрекет жасалмады / Нет реакции вовремя (охранник не вмешался, проигнорировал ситуацию)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
23	Binom School им. А. Бөкейхана	2025-08-21	10:30:52	Ата-ана / родитель	🚶‍♂️ Посторонний адамның кіруі / Пропуск посторонних (охранник пропустил постороннего без проверки)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
24	Binom school им. Қ. Сәтбаева	2025-08-21	10:31:10	Ата-ана / родитель	⏱ Уақтылы әрекет жасалмады / Нет реакции вовремя (охранник не вмешался, проигнорировал ситуацию)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
25	Binom school Школа-лицей им. Аль-Фараби	2025-08-21	10:31:31	Ата-ана / родитель	🙅 Дөрекі қарым-қатынас / Грубое поведение (грубость, невежливое обращение к ученикам или родителям)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
26	Riviera International School	2025-08-21	10:31:45	Оқушы / Ученик	🚶‍♂️ Посторонний адамның кіруі / Пропуск посторонних (охранник пропустил постороннего без проверки)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
27	Binom school им. Қ. Сәтбаева	2025-08-21	10:32:14	Оқушы / Ученик	⏱ Уақтылы әрекет жасалмады / Нет реакции вовремя (охранник не вмешался, проигнорировал ситуацию)	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.523004
28	Binom School им. Қадыр Мырза Әлі	2025-08-21	16:22:50	Ата-ана / родитель	🚫 Пост бос тұр / Пост пустой ( работник охраны отсутствует на месте)	\N	\N	\N	Forms	aaaaa	\N	2025-08-31 19:43:45.523004
29	Binom school им. Қ. Сәтбаева	2025-08-21	16:23:17	Қызметкер / Сотрудник	🙅 Дөрекі қарым-қатынас / Грубое поведение (грубость, невежливое обращение к ученикам или родителям)	\N	\N	\N	Forms	dddddd	\N	2025-08-31 19:43:45.523004
30	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:23:21	Оқушы / Ученик	⏱ Уақтылы әрекет жасалмады / Нет реакции вовремя (охранник не вмешался, проигнорировал ситуацию)	\N	\N	\N	Forms	Тмомо 	Осомм	2025-08-31 19:43:45.523004
31	Binom School им. А. Бөкейхана	2025-08-22	17:26:46	Директордың орынбасарлары	🚫 Пост бос тұр / Пост пустой ( работник охраны отсутствует на месте)	\N	\N	\N	Forms	азат	азат	2025-08-31 19:43:45.523004
32	Binom school им. А. Байтұрсынұлы 	2025-08-22	17:56:46	Директор	🚶‍♂️ Посторонний адамның кіруі / Пропуск посторонних (охранник пропустил постороннего без проверки)	\N	\N	\N	Forms	ddd	ddd	2025-08-31 19:43:45.523004
\.


--
-- TOC entry 3644 (class 0 OID 16453)
-- Dependencies: 228
-- Data for Name: s7; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s7 (id, edu_school, edu_date, edu_time, edu_role, edu_problem, edu_action, edu_status, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
1	Binom School им. А. Бөкейхана	2025-08-21	10:12:38	Оқушы / Ученик	❄ Кіреберісте немесе жолдағы мұз / Обледенение у входа или на дорожках	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
2	Binom school им. Ы. Алтынсарина	2025-08-21	11:38:24	Қызметкер / Сотрудник	🪟 Терезе ашық тұр / Окно открыто без фиксации в опасной зоне	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
3	Binom School им. Қадыр Мырза Әлі	2025-08-21	11:39:32	Қызметкер / Сотрудник	⚠ Шығып тұрған қауіпті элемент / Выступающий элемент с риском травмы	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
4	Binom school им. Ы. Алтынсарина	2025-08-21	11:39:49	Оқушы / Ученик	🪟 Терезе ашық тұр / Окно открыто без фиксации в опасной зоне	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
5	Binom school им. Қ. Сәтбаева	2025-08-21	11:41:57	Оқушы / Ученик	🪟 Терезе ашық тұр / Окно открыто без фиксации в опасной зоне	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
6	Binom school им. А. Кекилбаева	2025-08-21	11:44:55	Ата-ана / родитель	💧 Еден дымқыл немесе тайғақ, (ескерту белгісі жоқ)  / Мокрый или скользкий пол без предупреждения	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
7	Binom School им. Қадыр Мырза Әлі	2025-08-21	11:45:12	Ата-ана / родитель	⚠ Шығып тұрған қауіпті элемент / Выступающий элемент с риском травмы	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
8	Binom School им. А. Бөкейхана	2025-08-21	11:45:29	Оқушы / Ученик	💧 Еден дымқыл немесе тайғақ, (ескерту белгісі жоқ)  / Мокрый или скользкий пол без предупреждения	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
9	Binom School им. А. Бөкейхана	2025-08-21	11:45:47	Ата-ана / родитель	🪟 Терезе ашық тұр / Окно открыто без фиксации в опасной зоне	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
10	Binom school им. Қ. Сәтбаева	2025-08-21	11:46:02	Оқушы / Ученик	💧 Еден дымқыл немесе тайғақ, (ескерту белгісі жоқ)  / Мокрый или скользкий пол без предупреждения	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
11	Binom School им. А. Бөкейхана	2025-08-21	11:46:18	Қызметкер / Сотрудник	🔌 Ашық немесе зақымдалған электр сымдары / Открытая или повреждённая электропроводка	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
12	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:23:40	Ата-ана / родитель	🚪 Эвакуациялық есік жабық немесе бітелген / Эвакуационный выход закрыт или загромождён	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.536924
13	Binom school им. А. Байтұрсынұлы 	2025-08-21	16:23:52	Оқушы / Ученик	🪟 Терезе ашық тұр / Окно открыто без фиксации в опасной зоне	\N	\N	\N	Forms	Тсом	Аомом	2025-08-31 19:43:45.536924
14	Binom school им. А. Кекилбаева	2025-08-21	16:23:56	Қызметкер / Сотрудник	🚪 Эвакуациялық есік жабық немесе бітелген / Эвакуационный выход закрыт или загромождён	\N	\N	\N	Forms	aaa	\N	2025-08-31 19:43:45.536924
15	Binom school им. Қ. Сәтбаева	2025-08-22	18:02:29	IT қызметі	🪟 Терезе ашық тұр / Окно открыто без фиксации в опасной зоне	\N	\N	\N	Forms	проверка	проверка	2025-08-31 19:43:45.536924
\.


--
-- TOC entry 3646 (class 0 OID 16464)
-- Dependencies: 230
-- Data for Name: s8; Type: TABLE DATA; Schema: dbo; Owner: bot_user
--

COPY dbo.s8 (id, edu_school, edu_date, edu_time, edu_digestive_system, edu_cold_flu, edu_injuries, edu_allergic_reactions, edu_neurological_general, edu_chronic_diseases, edu_other, edu_total_medical, edu_photo, edu_data_from, edu_add_inf, edu_contact, created_at) FROM stdin;
13	FARABI SCHOOL ATYRAU	2025-08-29	07:51:43	2	2	2	2	2	3	3	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
12	FARABI SCHOOL SHYMKENT	2025-08-29	07:51:11	\N	\N	2	\N	2	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
11	Riviera International School	2025-08-29	07:50:47	2	2	\N	\N	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
10	Binom school Авангард	2025-08-29	07:50:23	\N	\N	\N	3	1	3	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
9	Binom ​Школа-лицей им. Динмухаммеда Кунаева	2025-08-27	07:49:38	\N	\N	\N	\N	3	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
8	Binom school Школа-лицей им. Аль-Фараби	2025-08-26	07:49:15	2	\N	\N	2	\N	\N	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
7	Binom school им. Ы. Алтынсарина	2025-08-26	07:48:50	3	3	3	3	\N	3	\N	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
6	Binom School им. Қадыр Мырза Әлі	2025-08-26	07:48:24	1	2	3	2	1	3	3	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
5	Binom school им. Қ. Сәтбаева	2025-08-25	07:47:48	3	3	2	2	3	1	3	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
4	Binom school им. А. Кекилбаева	2025-08-25	07:47:17	2	2	3	1	3	1	2	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
3	Binom School им. А. Бөкейхана	2025-08-24	07:46:47	1	2	2	1	2	2	2	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
2	Binom school им. А. Байтұрсынұлы 	2025-08-23	07:46:21	2	2	2	2	2	2	2	\N	\N	Forms	\N	\N	2025-08-31 19:43:45.546611
1	FARABI SCHOOL SHYMKENT	2025-08-22	10:02:01	2	3	4	5	2	3	1	\N	\N	Forms	0.0	0.0	2025-08-31 19:43:45.546611
\.


--
-- TOC entry 3685 (class 0 OID 0)
-- Dependencies: 241
-- Name: p1_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.p1_id_seq', 23, true);


--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 243
-- Name: p2_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.p2_id_seq', 26, true);


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 245
-- Name: p3_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.p3_id_seq', 8, true);


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 231
-- Name: q1_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.q1_id_seq', 30, true);


--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 233
-- Name: q2_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.q2_id_seq', 22, true);


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 235
-- Name: q3_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.q3_id_seq', 14, true);


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 237
-- Name: q4_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.q4_id_seq', 18, true);


--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 239
-- Name: q5_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.q5_id_seq', 1, true);


--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 215
-- Name: s1_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s1_id_seq', 91, true);


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 217
-- Name: s2_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s2_id_seq', 24, true);


--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 219
-- Name: s3_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s3_id_seq', 19, true);


--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 221
-- Name: s4_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s4_id_seq', 43, true);


--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 223
-- Name: s5_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s5_id_seq', 29, true);


--
-- TOC entry 3698 (class 0 OID 0)
-- Dependencies: 225
-- Name: s6_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s6_id_seq', 32, true);


--
-- TOC entry 3699 (class 0 OID 0)
-- Dependencies: 227
-- Name: s7_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s7_id_seq', 15, true);


--
-- TOC entry 3700 (class 0 OID 0)
-- Dependencies: 229
-- Name: s8_id_seq; Type: SEQUENCE SET; Schema: dbo; Owner: bot_user
--

SELECT pg_catalog.setval('dbo.s8_id_seq', 13, true);


--
-- TOC entry 3479 (class 2606 OID 16553)
-- Name: p1 p1_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p1
    ADD CONSTRAINT p1_pkey PRIMARY KEY (id);


--
-- TOC entry 3484 (class 2606 OID 16564)
-- Name: p2 p2_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p2
    ADD CONSTRAINT p2_pkey PRIMARY KEY (id);


--
-- TOC entry 3488 (class 2606 OID 16583)
-- Name: p3 p3_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.p3
    ADD CONSTRAINT p3_pkey PRIMARY KEY (id);


--
-- TOC entry 3453 (class 2606 OID 16492)
-- Name: q1 q1_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q1
    ADD CONSTRAINT q1_pkey PRIMARY KEY (id);


--
-- TOC entry 3459 (class 2606 OID 16503)
-- Name: q2 q2_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q2
    ADD CONSTRAINT q2_pkey PRIMARY KEY (id);


--
-- TOC entry 3465 (class 2606 OID 16514)
-- Name: q3 q3_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q3
    ADD CONSTRAINT q3_pkey PRIMARY KEY (id);


--
-- TOC entry 3470 (class 2606 OID 16525)
-- Name: q4 q4_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q4
    ADD CONSTRAINT q4_pkey PRIMARY KEY (id);


--
-- TOC entry 3474 (class 2606 OID 16542)
-- Name: q5 q5_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.q5
    ADD CONSTRAINT q5_pkey PRIMARY KEY (id);


--
-- TOC entry 3413 (class 2606 OID 16396)
-- Name: s1 s1_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s1
    ADD CONSTRAINT s1_pkey PRIMARY KEY (id);


--
-- TOC entry 3418 (class 2606 OID 16407)
-- Name: s2 s2_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s2
    ADD CONSTRAINT s2_pkey PRIMARY KEY (id);


--
-- TOC entry 3423 (class 2606 OID 16418)
-- Name: s3 s3_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s3
    ADD CONSTRAINT s3_pkey PRIMARY KEY (id);


--
-- TOC entry 3428 (class 2606 OID 16429)
-- Name: s4 s4_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s4
    ADD CONSTRAINT s4_pkey PRIMARY KEY (id);


--
-- TOC entry 3433 (class 2606 OID 16440)
-- Name: s5 s5_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s5
    ADD CONSTRAINT s5_pkey PRIMARY KEY (id);


--
-- TOC entry 3438 (class 2606 OID 16451)
-- Name: s6 s6_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s6
    ADD CONSTRAINT s6_pkey PRIMARY KEY (id);


--
-- TOC entry 3443 (class 2606 OID 16462)
-- Name: s7 s7_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s7
    ADD CONSTRAINT s7_pkey PRIMARY KEY (id);


--
-- TOC entry 3447 (class 2606 OID 16481)
-- Name: s8 s8_pkey; Type: CONSTRAINT; Schema: dbo; Owner: bot_user
--

ALTER TABLE ONLY dbo.s8
    ADD CONSTRAINT s8_pkey PRIMARY KEY (id);


--
-- TOC entry 3475 (class 1259 OID 16626)
-- Name: idx_p1_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p1_created_at ON dbo.p1 USING btree (created_at);


--
-- TOC entry 3476 (class 1259 OID 16624)
-- Name: idx_p1_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p1_school_date ON dbo.p1 USING btree (edu_school, edu_date);


--
-- TOC entry 3477 (class 1259 OID 16625)
-- Name: idx_p1_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p1_status ON dbo.p1 USING btree (edu_status);


--
-- TOC entry 3480 (class 1259 OID 16629)
-- Name: idx_p2_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p2_created_at ON dbo.p2 USING btree (created_at);


--
-- TOC entry 3481 (class 1259 OID 16627)
-- Name: idx_p2_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p2_school_date ON dbo.p2 USING btree (edu_school, edu_date);


--
-- TOC entry 3482 (class 1259 OID 16628)
-- Name: idx_p2_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p2_status ON dbo.p2 USING btree (edu_status);


--
-- TOC entry 3485 (class 1259 OID 16631)
-- Name: idx_p3_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p3_created_at ON dbo.p3 USING btree (created_at);


--
-- TOC entry 3486 (class 1259 OID 16630)
-- Name: idx_p3_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_p3_school_date ON dbo.p3 USING btree (edu_school, edu_date);


--
-- TOC entry 3448 (class 1259 OID 16609)
-- Name: idx_q1_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q1_created_at ON dbo.q1 USING btree (created_at);


--
-- TOC entry 3449 (class 1259 OID 16610)
-- Name: idx_q1_grate_litter; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q1_grate_litter ON dbo.q1 USING btree (edu_grate, edu_litter);


--
-- TOC entry 3450 (class 1259 OID 16607)
-- Name: idx_q1_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q1_school_date ON dbo.q1 USING btree (edu_school, edu_date);


--
-- TOC entry 3451 (class 1259 OID 16608)
-- Name: idx_q1_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q1_status ON dbo.q1 USING btree (edu_status);


--
-- TOC entry 3454 (class 1259 OID 16613)
-- Name: idx_q2_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q2_created_at ON dbo.q2 USING btree (created_at);


--
-- TOC entry 3455 (class 1259 OID 16614)
-- Name: idx_q2_grate_litter; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q2_grate_litter ON dbo.q2 USING btree (edu_grate, edu_litter);


--
-- TOC entry 3456 (class 1259 OID 16611)
-- Name: idx_q2_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q2_school_date ON dbo.q2 USING btree (edu_school, edu_date);


--
-- TOC entry 3457 (class 1259 OID 16612)
-- Name: idx_q2_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q2_status ON dbo.q2 USING btree (edu_status);


--
-- TOC entry 3460 (class 1259 OID 16617)
-- Name: idx_q3_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q3_created_at ON dbo.q3 USING btree (created_at);


--
-- TOC entry 3461 (class 1259 OID 16618)
-- Name: idx_q3_grate_litter; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q3_grate_litter ON dbo.q3 USING btree (edu_grate, edu_litter);


--
-- TOC entry 3462 (class 1259 OID 16615)
-- Name: idx_q3_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q3_school_date ON dbo.q3 USING btree (edu_school, edu_date);


--
-- TOC entry 3463 (class 1259 OID 16616)
-- Name: idx_q3_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q3_status ON dbo.q3 USING btree (edu_status);


--
-- TOC entry 3466 (class 1259 OID 16621)
-- Name: idx_q4_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q4_created_at ON dbo.q4 USING btree (created_at);


--
-- TOC entry 3467 (class 1259 OID 16619)
-- Name: idx_q4_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q4_school_date ON dbo.q4 USING btree (edu_school, edu_date);


--
-- TOC entry 3468 (class 1259 OID 16620)
-- Name: idx_q4_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q4_status ON dbo.q4 USING btree (edu_status);


--
-- TOC entry 3471 (class 1259 OID 16623)
-- Name: idx_q5_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q5_created_at ON dbo.q5 USING btree (created_at);


--
-- TOC entry 3472 (class 1259 OID 16622)
-- Name: idx_q5_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_q5_school_date ON dbo.q5 USING btree (edu_school, edu_date);


--
-- TOC entry 3409 (class 1259 OID 16586)
-- Name: idx_s1_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s1_created_at ON dbo.s1 USING btree (created_at);


--
-- TOC entry 3410 (class 1259 OID 16584)
-- Name: idx_s1_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s1_school_date ON dbo.s1 USING btree (edu_school, edu_date);


--
-- TOC entry 3411 (class 1259 OID 16585)
-- Name: idx_s1_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s1_status ON dbo.s1 USING btree (edu_status);


--
-- TOC entry 3414 (class 1259 OID 16589)
-- Name: idx_s2_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s2_created_at ON dbo.s2 USING btree (created_at);


--
-- TOC entry 3415 (class 1259 OID 16587)
-- Name: idx_s2_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s2_school_date ON dbo.s2 USING btree (edu_school, edu_date);


--
-- TOC entry 3416 (class 1259 OID 16588)
-- Name: idx_s2_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s2_status ON dbo.s2 USING btree (edu_status);


--
-- TOC entry 3419 (class 1259 OID 16592)
-- Name: idx_s3_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s3_created_at ON dbo.s3 USING btree (created_at);


--
-- TOC entry 3420 (class 1259 OID 16590)
-- Name: idx_s3_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s3_school_date ON dbo.s3 USING btree (edu_school, edu_date);


--
-- TOC entry 3421 (class 1259 OID 16591)
-- Name: idx_s3_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s3_status ON dbo.s3 USING btree (edu_status);


--
-- TOC entry 3424 (class 1259 OID 16595)
-- Name: idx_s4_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s4_created_at ON dbo.s4 USING btree (created_at);


--
-- TOC entry 3425 (class 1259 OID 16593)
-- Name: idx_s4_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s4_school_date ON dbo.s4 USING btree (edu_school, edu_date);


--
-- TOC entry 3426 (class 1259 OID 16594)
-- Name: idx_s4_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s4_status ON dbo.s4 USING btree (edu_status);


--
-- TOC entry 3429 (class 1259 OID 16598)
-- Name: idx_s5_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s5_created_at ON dbo.s5 USING btree (created_at);


--
-- TOC entry 3430 (class 1259 OID 16596)
-- Name: idx_s5_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s5_school_date ON dbo.s5 USING btree (edu_school, edu_date);


--
-- TOC entry 3431 (class 1259 OID 16597)
-- Name: idx_s5_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s5_status ON dbo.s5 USING btree (edu_status);


--
-- TOC entry 3434 (class 1259 OID 16601)
-- Name: idx_s6_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s6_created_at ON dbo.s6 USING btree (created_at);


--
-- TOC entry 3435 (class 1259 OID 16599)
-- Name: idx_s6_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s6_school_date ON dbo.s6 USING btree (edu_school, edu_date);


--
-- TOC entry 3436 (class 1259 OID 16600)
-- Name: idx_s6_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s6_status ON dbo.s6 USING btree (edu_status);


--
-- TOC entry 3439 (class 1259 OID 16604)
-- Name: idx_s7_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s7_created_at ON dbo.s7 USING btree (created_at);


--
-- TOC entry 3440 (class 1259 OID 16602)
-- Name: idx_s7_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s7_school_date ON dbo.s7 USING btree (edu_school, edu_date);


--
-- TOC entry 3441 (class 1259 OID 16603)
-- Name: idx_s7_status; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s7_status ON dbo.s7 USING btree (edu_status);


--
-- TOC entry 3444 (class 1259 OID 16606)
-- Name: idx_s8_created_at; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s8_created_at ON dbo.s8 USING btree (created_at);


--
-- TOC entry 3445 (class 1259 OID 16605)
-- Name: idx_s8_school_date; Type: INDEX; Schema: dbo; Owner: bot_user
--

CREATE INDEX idx_s8_school_date ON dbo.s8 USING btree (edu_school, edu_date);


-- Completed on 2025-08-31 19:49:21 UTC

--
-- PostgreSQL database dump complete
--

\unrestrict wxJBYQYn9sCYPRhAHP1PEquEtfrPFKx7av7D6EuTNFqXrjaBL4m9C9VqCSzKRUt

