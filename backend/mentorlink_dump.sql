--
-- PostgreSQL database dump
--

\restrict CIQ0ONqjVIJlaL4jWi38p6QAYGmBbotTOuztqilmrSeSO0nY2uFZRhQcIteMqal

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

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

ALTER TABLE IF EXISTS ONLY public.verification_documents DROP CONSTRAINT IF EXISTS verification_documents_user_id_adcd77e6_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.verification_documents DROP CONSTRAINT IF EXISTS verification_documents_reviewed_by_id_67481493_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.users_user_permissions DROP CONSTRAINT IF EXISTS users_user_permissions_user_id_92473840_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.users_user_permissions DROP CONSTRAINT IF EXISTS users_user_permissio_permission_id_6d08dcd2_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.users_groups DROP CONSTRAINT IF EXISTS users_groups_user_id_f500bee5_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.users_groups DROP CONSTRAINT IF EXISTS users_groups_group_id_2f3517aa_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.user_skills DROP CONSTRAINT IF EXISTS user_skills_skill_id_1a55c9b3_fk_skills_id;
ALTER TABLE IF EXISTS ONLY public.user_skills DROP CONSTRAINT IF EXISTS user_skills_profile_id_4ff2a56e_fk_profiles_id;
ALTER TABLE IF EXISTS ONLY public.token_blacklist_outstandingtoken DROP CONSTRAINT IF EXISTS token_blacklist_outstandingtoken_user_id_83bc629a_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.token_blacklist_blacklistedtoken DROP CONSTRAINT IF EXISTS token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_reviewer_id_dbb954a8_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_reviewed_id_26ab5b38_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_match_id_df422061_fk_matches_id;
ALTER TABLE IF EXISTS ONLY public.profiles DROP CONSTRAINT IF EXISTS profiles_user_id_36580373_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_user_id_468e288d_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_sender_id_dc5a0bbd_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_conversation_id_5ef638db_fk_conversations_id;
ALTER TABLE IF EXISTS ONLY public.mentorship_posts DROP CONSTRAINT IF EXISTS mentorship_posts_creator_id_6ae72afe_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.matches DROP CONSTRAINT IF EXISTS matches_request_id_b2653ba8_fk_mentorship_posts_id;
ALTER TABLE IF EXISTS ONLY public.matches DROP CONSTRAINT IF EXISTS matches_offer_id_91e0d674_fk_mentorship_posts_id;
ALTER TABLE IF EXISTS ONLY public.matches DROP CONSTRAINT IF EXISTS matches_mentor_id_59b76bab_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.matches DROP CONSTRAINT IF EXISTS matches_mentee_id_d1f950e2_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.conversation_members DROP CONSTRAINT IF EXISTS conversation_members_user_id_3bfe90c8_fk_users_id;
ALTER TABLE IF EXISTS ONLY public.conversation_members DROP CONSTRAINT IF EXISTS conversation_members_conversation_id_570068ad_fk_conversat;
ALTER TABLE IF EXISTS ONLY public.availability_slots DROP CONSTRAINT IF EXISTS availability_slots_profile_id_0c5edf97_fk_profiles_id;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
DROP INDEX IF EXISTS public.verification_documents_reviewed_by_id_67481493;
DROP INDEX IF EXISTS public.verificatio_user_id_d15fbf_idx;
DROP INDEX IF EXISTS public.verificatio_status_a43286_idx;
DROP INDEX IF EXISTS public.users_user_permissions_user_id_92473840;
DROP INDEX IF EXISTS public.users_user_permissions_permission_id_6d08dcd2;
DROP INDEX IF EXISTS public.users_phone_af6883_idx;
DROP INDEX IF EXISTS public.users_phone_2b77170a_like;
DROP INDEX IF EXISTS public.users_is_acti_847b48_idx;
DROP INDEX IF EXISTS public.users_groups_user_id_f500bee5;
DROP INDEX IF EXISTS public.users_groups_group_id_2f3517aa;
DROP INDEX IF EXISTS public.users_email_4b85f2_idx;
DROP INDEX IF EXISTS public.users_email_0ea73cca_like;
DROP INDEX IF EXISTS public.users_created_6541e9_idx;
DROP INDEX IF EXISTS public.user_skills_skill_id_1a55c9b3;
DROP INDEX IF EXISTS public.user_skills_profile_id_4ff2a56e;
DROP INDEX IF EXISTS public.token_blacklist_outstandingtoken_user_id_83bc629a;
DROP INDEX IF EXISTS public.token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like;
DROP INDEX IF EXISTS public.skills_name_3120df3a_like;
DROP INDEX IF EXISTS public.reviews_reviewer_id_dbb954a8;
DROP INDEX IF EXISTS public.reviews_reviewed_id_26ab5b38;
DROP INDEX IF EXISTS public.reviews_reviewe_fe0fd6_idx;
DROP INDEX IF EXISTS public.reviews_reviewe_965d53_idx;
DROP INDEX IF EXISTS public.reviews_rating_17e8a4_idx;
DROP INDEX IF EXISTS public.reviews_match_id_df422061;
DROP INDEX IF EXISTS public.profiles_departm_ffdbbc_idx;
DROP INDEX IF EXISTS public.profiles_academi_e4a1e1_idx;
DROP INDEX IF EXISTS public.notifications_user_id_468e288d;
DROP INDEX IF EXISTS public.notificatio_user_id_a4dd5c_idx;
DROP INDEX IF EXISTS public.notificatio_created_e4c995_idx;
DROP INDEX IF EXISTS public.messages_sender_id_dc5a0bbd;
DROP INDEX IF EXISTS public.messages_sender__6ae55a_idx;
DROP INDEX IF EXISTS public.messages_conversation_id_5ef638db;
DROP INDEX IF EXISTS public.messages_convers_3ebb41_idx;
DROP INDEX IF EXISTS public.mentorship_posts_creator_id_6ae72afe;
DROP INDEX IF EXISTS public.mentorship__type_2b976d_idx;
DROP INDEX IF EXISTS public.mentorship__subject_4b0ea6_idx;
DROP INDEX IF EXISTS public.mentorship__creator_6feaca_idx;
DROP INDEX IF EXISTS public.mentorship__created_280abb_idx;
DROP INDEX IF EXISTS public.matches_status_639056_idx;
DROP INDEX IF EXISTS public.matches_request_id_b2653ba8;
DROP INDEX IF EXISTS public.matches_offer_id_91e0d674;
DROP INDEX IF EXISTS public.matches_mentor_id_59b76bab;
DROP INDEX IF EXISTS public.matches_mentor__fb198d_idx;
DROP INDEX IF EXISTS public.matches_mentee_id_d1f950e2;
DROP INDEX IF EXISTS public.matches_mentee__3d25ef_idx;
DROP INDEX IF EXISTS public.matches_compati_0bce3a_idx;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.conversation_members_user_id_3bfe90c8;
DROP INDEX IF EXISTS public.conversation_members_conversation_id_570068ad;
DROP INDEX IF EXISTS public.availability_slots_profile_id_0c5edf97;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
ALTER TABLE IF EXISTS ONLY public.verification_documents DROP CONSTRAINT IF EXISTS verification_documents_user_id_key;
ALTER TABLE IF EXISTS ONLY public.verification_documents DROP CONSTRAINT IF EXISTS verification_documents_pkey;
ALTER TABLE IF EXISTS ONLY public.users_user_permissions DROP CONSTRAINT IF EXISTS users_user_permissions_user_id_permission_id_3b86cbdf_uniq;
ALTER TABLE IF EXISTS ONLY public.users_user_permissions DROP CONSTRAINT IF EXISTS users_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_phone_key;
ALTER TABLE IF EXISTS ONLY public.users_groups DROP CONSTRAINT IF EXISTS users_groups_user_id_group_id_fc7788e8_uniq;
ALTER TABLE IF EXISTS ONLY public.users_groups DROP CONSTRAINT IF EXISTS users_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY public.user_skills DROP CONSTRAINT IF EXISTS user_skills_profile_id_skill_id_632d0408_uniq;
ALTER TABLE IF EXISTS ONLY public.user_skills DROP CONSTRAINT IF EXISTS user_skills_pkey;
ALTER TABLE IF EXISTS ONLY public.token_blacklist_outstandingtoken DROP CONSTRAINT IF EXISTS token_blacklist_outstandingtoken_pkey;
ALTER TABLE IF EXISTS ONLY public.token_blacklist_outstandingtoken DROP CONSTRAINT IF EXISTS token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq;
ALTER TABLE IF EXISTS ONLY public.token_blacklist_blacklistedtoken DROP CONSTRAINT IF EXISTS token_blacklist_blacklistedtoken_token_id_key;
ALTER TABLE IF EXISTS ONLY public.token_blacklist_blacklistedtoken DROP CONSTRAINT IF EXISTS token_blacklist_blacklistedtoken_pkey;
ALTER TABLE IF EXISTS ONLY public.skills DROP CONSTRAINT IF EXISTS skills_pkey;
ALTER TABLE IF EXISTS ONLY public.skills DROP CONSTRAINT IF EXISTS skills_name_key;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_pkey;
ALTER TABLE IF EXISTS ONLY public.profiles DROP CONSTRAINT IF EXISTS profiles_user_id_key;
ALTER TABLE IF EXISTS ONLY public.profiles DROP CONSTRAINT IF EXISTS profiles_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_pkey;
ALTER TABLE IF EXISTS ONLY public.mentorship_posts DROP CONSTRAINT IF EXISTS mentorship_posts_pkey;
ALTER TABLE IF EXISTS ONLY public.matches DROP CONSTRAINT IF EXISTS matches_pkey;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.conversations DROP CONSTRAINT IF EXISTS conversations_pkey;
ALTER TABLE IF EXISTS ONLY public.conversation_members DROP CONSTRAINT IF EXISTS conversation_members_pkey;
ALTER TABLE IF EXISTS ONLY public.conversation_members DROP CONSTRAINT IF EXISTS conversation_members_conversation_id_user_id_f14fcbc6_uniq;
ALTER TABLE IF EXISTS ONLY public.availability_slots DROP CONSTRAINT IF EXISTS availability_slots_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
DROP TABLE IF EXISTS public.verification_documents;
DROP TABLE IF EXISTS public.users_user_permissions;
DROP TABLE IF EXISTS public.users_groups;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.user_skills;
DROP TABLE IF EXISTS public.token_blacklist_outstandingtoken;
DROP TABLE IF EXISTS public.token_blacklist_blacklistedtoken;
DROP TABLE IF EXISTS public.skills;
DROP TABLE IF EXISTS public.reviews;
DROP TABLE IF EXISTS public.profiles;
DROP TABLE IF EXISTS public.notifications;
DROP TABLE IF EXISTS public.messages;
DROP TABLE IF EXISTS public.mentorship_posts;
DROP TABLE IF EXISTS public.matches;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.conversations;
DROP TABLE IF EXISTS public.conversation_members;
DROP TABLE IF EXISTS public.availability_slots;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO mentorlink;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: mentorlink
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO mentorlink;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: mentorlink
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO mentorlink;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: mentorlink
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: availability_slots; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.availability_slots (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    day_of_week character varying(10) NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    profile_id uuid NOT NULL
);


ALTER TABLE public.availability_slots OWNER TO mentorlink;

--
-- Name: conversation_members; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.conversation_members (
    id uuid NOT NULL,
    joined_at timestamp with time zone NOT NULL,
    conversation_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.conversation_members OWNER TO mentorlink;

--
-- Name: conversations; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.conversations (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.conversations OWNER TO mentorlink;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id uuid NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO mentorlink;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: mentorlink
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO mentorlink;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: mentorlink
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO mentorlink;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: mentorlink
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO mentorlink;

--
-- Name: matches; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.matches (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    compatibility_score double precision NOT NULL,
    status character varying(10) NOT NULL,
    matched_at timestamp with time zone NOT NULL,
    mentee_id uuid NOT NULL,
    mentor_id uuid NOT NULL,
    offer_id uuid,
    request_id uuid
);


ALTER TABLE public.matches OWNER TO mentorlink;

--
-- Name: mentorship_posts; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.mentorship_posts (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    type character varying(10) NOT NULL,
    subject character varying(255) NOT NULL,
    description text,
    format character varying(10) NOT NULL,
    status character varying(10) NOT NULL,
    creator_id uuid NOT NULL
);


ALTER TABLE public.mentorship_posts OWNER TO mentorlink;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.messages (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    content text NOT NULL,
    read_at timestamp with time zone,
    conversation_id uuid NOT NULL,
    sender_id uuid NOT NULL
);


ALTER TABLE public.messages OWNER TO mentorlink;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.notifications (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    type character varying(30) NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    is_read boolean NOT NULL,
    metadata jsonb,
    user_id uuid NOT NULL
);


ALTER TABLE public.notifications OWNER TO mentorlink;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    profile_photo character varying(100),
    department character varying(255),
    academic_level character varying(100),
    bio text,
    user_id uuid NOT NULL
);


ALTER TABLE public.profiles OWNER TO mentorlink;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.reviews (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    rating integer NOT NULL,
    content text,
    session_type character varying(50),
    match_id uuid,
    reviewed_id uuid NOT NULL,
    reviewer_id uuid NOT NULL
);


ALTER TABLE public.reviews OWNER TO mentorlink;

--
-- Name: skills; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.skills (
    id uuid NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.skills OWNER TO mentorlink;

--
-- Name: token_blacklist_blacklistedtoken; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.token_blacklist_blacklistedtoken (
    id bigint NOT NULL,
    blacklisted_at timestamp with time zone NOT NULL,
    token_id bigint NOT NULL
);


ALTER TABLE public.token_blacklist_blacklistedtoken OWNER TO mentorlink;

--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: mentorlink
--

ALTER TABLE public.token_blacklist_blacklistedtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.token_blacklist_blacklistedtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: token_blacklist_outstandingtoken; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.token_blacklist_outstandingtoken (
    id bigint NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone,
    expires_at timestamp with time zone NOT NULL,
    user_id uuid,
    jti character varying(255) NOT NULL
);


ALTER TABLE public.token_blacklist_outstandingtoken OWNER TO mentorlink;

--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: mentorlink
--

ALTER TABLE public.token_blacklist_outstandingtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.token_blacklist_outstandingtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_skills; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.user_skills (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    type character varying(10) NOT NULL,
    profile_id uuid NOT NULL,
    skill_id uuid NOT NULL
);


ALTER TABLE public.user_skills OWNER TO mentorlink;

--
-- Name: users; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.users (
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    email character varying(254) NOT NULL,
    phone character varying(20),
    is_verified boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.users OWNER TO mentorlink;

--
-- Name: users_groups; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.users_groups (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_groups OWNER TO mentorlink;

--
-- Name: users_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: mentorlink
--

ALTER TABLE public.users_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_user_permissions; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.users_user_permissions (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.users_user_permissions OWNER TO mentorlink;

--
-- Name: users_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: mentorlink
--

ALTER TABLE public.users_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: verification_documents; Type: TABLE; Schema: public; Owner: mentorlink
--

CREATE TABLE public.verification_documents (
    id uuid NOT NULL,
    file character varying(100) NOT NULL,
    status character varying(10) NOT NULL,
    rejection_reason text,
    reviewed_by_id uuid,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.verification_documents OWNER TO mentorlink;

--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add blacklisted token	6	add_blacklistedtoken
22	Can change blacklisted token	6	change_blacklistedtoken
23	Can delete blacklisted token	6	delete_blacklistedtoken
24	Can view blacklisted token	6	view_blacklistedtoken
25	Can add outstanding token	7	add_outstandingtoken
26	Can change outstanding token	7	change_outstandingtoken
27	Can delete outstanding token	7	delete_outstandingtoken
28	Can view outstanding token	7	view_outstandingtoken
29	Can add user	8	add_user
30	Can change user	8	change_user
31	Can delete user	8	delete_user
32	Can view user	8	view_user
33	Can add skill	9	add_skill
34	Can change skill	9	change_skill
35	Can delete skill	9	delete_skill
36	Can view skill	9	view_skill
37	Can add profile	10	add_profile
38	Can change profile	10	change_profile
39	Can delete profile	10	delete_profile
40	Can view profile	10	view_profile
41	Can add availability slot	11	add_availabilityslot
42	Can change availability slot	11	change_availabilityslot
43	Can delete availability slot	11	delete_availabilityslot
44	Can view availability slot	11	view_availabilityslot
45	Can add user skill	12	add_userskill
46	Can change user skill	12	change_userskill
47	Can delete user skill	12	delete_userskill
48	Can view user skill	12	view_userskill
49	Can add mentorship post	13	add_mentorshippost
50	Can change mentorship post	13	change_mentorshippost
51	Can delete mentorship post	13	delete_mentorshippost
52	Can view mentorship post	13	view_mentorshippost
53	Can add match	14	add_match
54	Can change match	14	change_match
55	Can delete match	14	delete_match
56	Can view match	14	view_match
57	Can add conversation	15	add_conversation
58	Can change conversation	15	change_conversation
59	Can delete conversation	15	delete_conversation
60	Can view conversation	15	view_conversation
61	Can add conversation member	16	add_conversationmember
62	Can change conversation member	16	change_conversationmember
63	Can delete conversation member	16	delete_conversationmember
64	Can view conversation member	16	view_conversationmember
65	Can add message	17	add_message
66	Can change message	17	change_message
67	Can delete message	17	delete_message
68	Can view message	17	view_message
69	Can add notification	18	add_notification
70	Can change notification	18	change_notification
71	Can delete notification	18	delete_notification
72	Can view notification	18	view_notification
73	Can add verification document	19	add_verificationdocument
74	Can change verification document	19	change_verificationdocument
75	Can delete verification document	19	delete_verificationdocument
76	Can view verification document	19	view_verificationdocument
77	Can add review	20	add_review
78	Can change review	20	change_review
79	Can delete review	20	delete_review
80	Can view review	20	view_review
\.


--
-- Data for Name: availability_slots; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.availability_slots (id, created_at, updated_at, deleted_at, day_of_week, start_time, end_time, profile_id) FROM stdin;
d6f8fb8f-f50e-4cd8-a9c2-781e2e3a0448	2026-06-10 14:25:27.160085+00	2026-06-10 14:25:27.160104+00	\N	MONDAY	09:00:00	12:00:00	08ac6245-6b77-45f1-9893-a3c923dc507e
608edf07-ddb8-4356-86e8-600efaf9c524	2026-06-10 14:25:27.233647+00	2026-06-10 14:25:27.233684+00	\N	WEDNESDAY	14:00:00	17:00:00	08ac6245-6b77-45f1-9893-a3c923dc507e
ceeeb6e2-0fea-442a-86b5-c8a1bb5cd7af	2026-06-10 14:25:27.30738+00	2026-06-10 14:25:27.307401+00	\N	FRIDAY	10:00:00	13:00:00	08ac6245-6b77-45f1-9893-a3c923dc507e
73fdc6c3-6b5e-427e-8375-5015340ed524	2026-06-10 14:25:27.399593+00	2026-06-10 14:25:27.399629+00	\N	MONDAY	10:00:00	12:00:00	9ec37782-f01d-4322-b5a2-b00a5f83ad6e
dd9c3f42-1b59-45e8-8bce-b86d6010499c	2026-06-10 14:25:27.477852+00	2026-06-10 14:25:27.47788+00	\N	TUESDAY	14:00:00	16:00:00	9ec37782-f01d-4322-b5a2-b00a5f83ad6e
853837ec-c97e-40d7-9387-2fa49937841a	2026-06-10 14:25:27.563936+00	2026-06-10 14:25:27.563971+00	\N	TUESDAY	09:00:00	12:00:00	aa841022-0523-4f34-bed7-b6960d284da4
2fa90d46-020e-46f2-b143-a49c6aff90f2	2026-06-10 14:25:27.653642+00	2026-06-10 14:25:27.653661+00	\N	THURSDAY	15:00:00	17:00:00	aa841022-0523-4f34-bed7-b6960d284da4
62abf1ef-56fa-43d2-b144-dc15a3ad8d54	2026-06-10 14:25:27.739251+00	2026-06-10 14:25:27.739269+00	\N	SATURDAY	09:00:00	12:00:00	aa841022-0523-4f34-bed7-b6960d284da4
8c8db109-d226-48ef-9d5d-0f8511a3c5ae	2026-06-10 14:25:27.808065+00	2026-06-10 14:25:27.808085+00	\N	WEDNESDAY	09:00:00	11:00:00	757c574b-9719-4c7b-9e00-21a7ee1d4093
3046421d-2d28-4d9a-afa2-b53f89cea39e	2026-06-10 14:25:27.882941+00	2026-06-10 14:25:27.882954+00	\N	FRIDAY	14:00:00	16:00:00	757c574b-9719-4c7b-9e00-21a7ee1d4093
a1a39f82-0ce4-4f71-a355-c288966b7db3	2026-06-10 14:25:27.953068+00	2026-06-10 14:25:27.953103+00	\N	MONDAY	13:00:00	15:00:00	48969b1c-1316-4814-b05a-2fcb821d31a1
313b1d1a-6cd3-4fa9-ac0c-582c49086714	2026-06-10 14:25:28.018348+00	2026-06-10 14:25:28.018367+00	\N	FRIDAY	09:00:00	12:00:00	48969b1c-1316-4814-b05a-2fcb821d31a1
c6c4c23e-7b03-4509-8e6a-d6cac9595ab5	2026-06-10 14:25:28.130239+00	2026-06-10 14:25:28.130274+00	\N	TUESDAY	10:00:00	14:00:00	bf8442cd-e57f-4394-bc9f-f711703cb479
c7fa506f-5dce-467a-aa03-93b1b9693222	2026-06-10 14:25:28.216871+00	2026-06-10 14:25:28.216889+00	\N	THURSDAY	14:00:00	18:00:00	bf8442cd-e57f-4394-bc9f-f711703cb479
af9b2482-ebcc-4267-8ddd-f14b8e41f095	2026-06-10 14:25:28.320285+00	2026-06-10 14:25:28.320321+00	\N	WEDNESDAY	13:00:00	15:00:00	181e73d9-825b-445a-9989-6c195b2c3054
eb47d929-0023-4fcb-b8e5-937433865428	2026-06-10 14:25:28.392265+00	2026-06-10 14:25:28.39228+00	\N	SATURDAY	10:00:00	13:00:00	181e73d9-825b-445a-9989-6c195b2c3054
09ac025a-29f3-4d45-a924-9478d7b2309d	2026-06-10 14:25:28.449596+00	2026-06-10 14:25:28.449619+00	\N	MONDAY	14:00:00	17:00:00	ac24a8bd-3c25-4af6-b72b-1da9e004200e
65756e4b-e057-47af-bb09-d7e2faf42981	2026-06-10 14:25:28.503398+00	2026-06-10 14:25:28.503416+00	\N	WEDNESDAY	09:00:00	12:00:00	ac24a8bd-3c25-4af6-b72b-1da9e004200e
a1532e33-a58e-4f5c-85d1-865615569a45	2026-06-10 14:25:28.563223+00	2026-06-10 14:25:28.563263+00	\N	THURSDAY	09:00:00	12:00:00	c20a1276-4b3b-442c-a33f-03039f42eb8b
919a2af9-ac0a-4f0d-9513-43bb74b5e82d	2026-06-10 14:25:28.650454+00	2026-06-10 14:25:28.650475+00	\N	FRIDAY	10:00:00	14:00:00	c20a1276-4b3b-442c-a33f-03039f42eb8b
56721916-f4a9-4d48-94c3-a5ae5e0ca3f5	2026-06-10 14:25:28.716194+00	2026-06-10 14:25:28.716213+00	\N	MONDAY	15:00:00	18:00:00	173ed165-b675-4ef2-b46b-693495010ef5
fc9929d9-ec78-49c9-8e70-4e1af6e671aa	2026-06-10 14:25:28.783752+00	2026-06-10 14:25:28.783776+00	\N	WEDNESDAY	10:00:00	13:00:00	173ed165-b675-4ef2-b46b-693495010ef5
1704c425-ed1d-4fa1-9312-32fc09f1c62c	2026-06-10 18:09:10.197547+00	2026-06-10 18:09:10.197577+00	2026-06-11 16:37:29.031521+00	FRIDAY	14:00:00	16:00:00	6da8523a-b47c-4702-b967-6c64655652b8
e491f3cc-4761-4087-95cc-545a38ce7b47	2026-06-10 18:09:10.422468+00	2026-06-10 18:09:10.422496+00	2026-06-11 16:37:29.108691+00	FRIDAY	16:00:00	18:00:00	6da8523a-b47c-4702-b967-6c64655652b8
3d4d12ae-6dd6-4d7f-b112-7db00619885b	2026-06-10 18:09:10.426905+00	2026-06-10 18:09:10.426925+00	2026-06-11 16:37:29.186591+00	MONDAY	08:00:00	10:00:00	6da8523a-b47c-4702-b967-6c64655652b8
b861bf8b-6001-4c3a-a421-e7040c2493d1	2026-06-10 18:09:10.425267+00	2026-06-10 18:09:10.425294+00	2026-06-11 16:37:29.278265+00	SUNDAY	14:00:00	16:00:00	6da8523a-b47c-4702-b967-6c64655652b8
9a5deadd-f70c-49d4-b697-af8155ca7f97	2026-06-10 18:09:10.103055+00	2026-06-10 18:09:10.103204+00	2026-06-11 16:37:29.36386+00	WEDNESDAY	20:00:00	20:00:00	6da8523a-b47c-4702-b967-6c64655652b8
dd43faec-644f-4d88-ac2f-43986369c9e7	2026-06-11 16:37:29.479764+00	2026-06-11 16:37:29.479794+00	2026-06-11 16:54:01.122592+00	MONDAY	08:00:00	12:00:00	6da8523a-b47c-4702-b967-6c64655652b8
3b818d3f-58e2-4548-b24a-73923d920b2b	2026-06-11 17:07:58.738658+00	2026-06-11 17:07:58.738673+00	\N	MONDAY	09:00:00	12:00:00	e6fc12d2-364c-48b3-b630-6103216ca9a2
8830ee5a-a221-464e-aad5-25f3cc5bda1c	2026-06-11 16:54:01.271578+00	2026-06-11 16:54:01.271602+00	2026-06-11 17:18:23.510534+00	MONDAY	08:00:00	12:00:00	6da8523a-b47c-4702-b967-6c64655652b8
17026d30-94cc-4d0a-a857-2300f2d53940	2026-06-11 17:18:23.689938+00	2026-06-11 17:18:23.689962+00	2026-06-11 17:19:04.181873+00	MONDAY	08:00:00	12:00:00	6da8523a-b47c-4702-b967-6c64655652b8
755eaec7-d4cc-47aa-86d7-90a37d5b33fb	2026-06-11 17:19:04.559126+00	2026-06-11 17:19:04.559142+00	2026-06-11 17:22:48.290056+00	MONDAY	08:00:00	12:00:00	6da8523a-b47c-4702-b967-6c64655652b8
8db11ded-0447-4dd7-9144-1262a7f59a37	2026-06-11 17:22:48.550331+00	2026-06-11 17:22:48.550373+00	2026-06-11 17:23:09.648525+00	MONDAY	08:00:00	12:00:00	6da8523a-b47c-4702-b967-6c64655652b8
13d8579a-3caa-4e7f-afe1-c7b7f8ca6aec	2026-06-11 17:22:48.641042+00	2026-06-11 17:22:48.641057+00	2026-06-11 17:23:09.747863+00	MONDAY	14:00:00	18:00:00	6da8523a-b47c-4702-b967-6c64655652b8
f4cc0ea6-b63a-45b9-a831-66dedba41fbe	2026-06-11 17:22:48.728894+00	2026-06-11 17:22:48.728921+00	2026-06-11 17:23:09.870702+00	MONDAY	19:00:00	22:00:00	6da8523a-b47c-4702-b967-6c64655652b8
6802cda3-0d89-491e-9467-74f407c04032	2026-06-11 17:23:10.026352+00	2026-06-11 17:23:10.026368+00	\N	MONDAY	08:00:00	12:00:00	6da8523a-b47c-4702-b967-6c64655652b8
879f26af-1c5c-4743-b868-91be016d842e	2026-06-11 17:23:10.126499+00	2026-06-11 17:23:10.126518+00	\N	MONDAY	14:00:00	18:00:00	6da8523a-b47c-4702-b967-6c64655652b8
1849f3e0-1a65-4af4-a6f5-aab031d10417	2026-06-11 17:23:10.21373+00	2026-06-11 17:23:10.213744+00	\N	TUESDAY	08:00:00	12:00:00	6da8523a-b47c-4702-b967-6c64655652b8
ce4c194e-9a4f-4889-97b4-380ac01172c5	2026-06-11 17:23:10.297225+00	2026-06-11 17:23:10.297243+00	\N	TUESDAY	14:00:00	18:00:00	6da8523a-b47c-4702-b967-6c64655652b8
4dda8aaa-40a3-4bba-a4eb-a1d06ffc2619	2026-06-11 17:23:10.384918+00	2026-06-11 17:23:10.384942+00	\N	WEDNESDAY	08:00:00	12:00:00	6da8523a-b47c-4702-b967-6c64655652b8
ac53a31c-90e9-4a24-ae05-7c8989ff41a8	2026-06-11 17:23:10.482182+00	2026-06-11 17:23:10.482201+00	\N	WEDNESDAY	14:00:00	18:00:00	6da8523a-b47c-4702-b967-6c64655652b8
f7f8574e-58f2-4307-8f94-1412b82cc849	2026-06-11 17:23:10.577942+00	2026-06-11 17:23:10.577956+00	\N	SATURDAY	08:00:00	12:00:00	6da8523a-b47c-4702-b967-6c64655652b8
55f9b915-b2c0-4546-8f58-a655bb3b715e	2026-06-11 17:23:10.691511+00	2026-06-11 17:23:10.691525+00	\N	SATURDAY	14:00:00	18:00:00	6da8523a-b47c-4702-b967-6c64655652b8
\.


--
-- Data for Name: conversation_members; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.conversation_members (id, joined_at, conversation_id, user_id) FROM stdin;
2cb1a94e-0169-4e8e-be90-80f7dde2993c	2026-06-10 14:25:31.080313+00	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
ac0af5a2-5f41-43e9-9395-1ad764302777	2026-06-10 14:25:31.135179+00	c6adebb0-838a-4574-ae2b-332258d320db	3f1f157d-98f6-4907-8c7c-165e573a186a
30d3de7f-fe9c-48a7-9c6a-fefbdf986145	2026-06-10 14:25:32.296994+00	6f543bb5-f963-4abf-be67-017313aa693a	e876f033-f143-4f4b-9adc-71642419144a
3a3fd43e-6c74-4d7f-b103-9a740c169fc8	2026-06-10 14:25:32.341429+00	6f543bb5-f963-4abf-be67-017313aa693a	a097155f-18d3-401f-b023-a0e05b8a6753
4053c424-f5b7-4376-aa38-415e61cc36e4	2026-06-10 14:25:33.736484+00	aa3c0b6d-7d42-4f34-8b81-e907c32f82a5	7d28b09c-b8fd-45bf-806d-ad82d4884774
9107a670-a7f3-4cd1-96c3-75489bc20dd9	2026-06-10 14:25:33.791696+00	aa3c0b6d-7d42-4f34-8b81-e907c32f82a5	3f1f157d-98f6-4907-8c7c-165e573a186a
b269cdc1-8923-4fa9-bed5-50786b822eb7	2026-06-10 14:25:34.666263+00	e2c82824-1eb6-4cc9-9e17-470cf927e6b0	d5626e1d-fd73-4d98-8086-552536eadf39
5cdc86fd-9cc2-4307-b5b6-09191a89ac6c	2026-06-10 14:25:34.73251+00	e2c82824-1eb6-4cc9-9e17-470cf927e6b0	717f97b9-6de0-4c33-8c5c-61c9abdebed4
c210a243-adf7-4924-a634-dc69863da48d	2026-06-10 14:25:36.464313+00	f6247269-527c-4758-a721-d4f334b9d278	02d56625-7584-447e-8ad0-838c2beeaaf4
0a265863-bc93-4526-899e-4ccd88071846	2026-06-10 14:25:36.702897+00	f6247269-527c-4758-a721-d4f334b9d278	2e624d5c-4afa-475d-9083-9877614d6d06
8a098ef9-7c46-414e-95ca-c312a140d850	2026-06-10 17:12:27.051898+00	cec86833-fedb-4c98-8c71-70409ef56abf	c156fde9-c5db-49d6-bd58-2844fd4ef021
6759f5b6-c0de-4740-a15f-68f0987e2b27	2026-06-10 17:12:27.262288+00	cec86833-fedb-4c98-8c71-70409ef56abf	717f97b9-6de0-4c33-8c5c-61c9abdebed4
c84bda94-945a-4ac3-89c5-0adaf61b9f7a	2026-06-11 15:33:31.77756+00	d9e83586-f916-4f41-8203-7cfd7d44d018	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
a965557f-7c59-4805-a318-f1db1d9b4722	2026-06-11 15:33:31.899056+00	d9e83586-f916-4f41-8203-7cfd7d44d018	717f97b9-6de0-4c33-8c5c-61c9abdebed4
b9f053ff-d8f7-45be-8c8f-889b618d3146	2026-06-11 15:45:14.223452+00	73dec969-ad14-413e-9151-28dfdcad917c	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
5f121033-0ff0-427f-8e31-cce7c40300a2	2026-06-11 15:45:14.290039+00	73dec969-ad14-413e-9151-28dfdcad917c	cd9bd543-becf-4a12-b672-47bcd0d4c95e
7a2e0de2-46a3-48c9-8d8d-08b94842ba3a	2026-06-11 16:04:55.692277+00	a3bbcaeb-e60b-4fdf-b03f-d88dcf00549e	cd9bd543-becf-4a12-b672-47bcd0d4c95e
6c591da7-007d-47b1-8198-5696943f74b0	2026-06-11 16:04:55.946187+00	a3bbcaeb-e60b-4fdf-b03f-d88dcf00549e	717f97b9-6de0-4c33-8c5c-61c9abdebed4
d475f502-b248-4e36-8e8a-96b51f05aba7	2026-06-11 17:04:51.879361+00	b9aa586f-25e1-442e-8966-04f97cac29e0	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
fc1bd314-0e0b-41de-a8c6-614ea9f8e10a	2026-06-11 17:04:51.945579+00	b9aa586f-25e1-442e-8966-04f97cac29e0	3f1f157d-98f6-4907-8c7c-165e573a186a
032e2d86-6a88-4b95-9d25-74bc00fb053e	2026-06-11 17:04:53.15238+00	707c9a99-965b-457d-8795-a991136438d3	e876f033-f143-4f4b-9adc-71642419144a
6ead86b8-ec2d-41e1-8fc6-1ec97a283f9e	2026-06-11 17:04:53.208015+00	707c9a99-965b-457d-8795-a991136438d3	a097155f-18d3-401f-b023-a0e05b8a6753
0407ca0a-2862-44e8-ab03-c0513ad13f38	2026-06-11 17:04:54.580144+00	cad3c041-8738-4441-9dbf-9b58d15fa1ae	7d28b09c-b8fd-45bf-806d-ad82d4884774
aaa6b093-83eb-4677-b659-fb4a0371d7bd	2026-06-11 17:04:54.646493+00	cad3c041-8738-4441-9dbf-9b58d15fa1ae	3f1f157d-98f6-4907-8c7c-165e573a186a
919fa6cd-4c25-467a-a890-e40d2b7a6017	2026-06-11 17:04:55.787411+00	1d2d0710-2060-427d-95c3-71a04ad40cf8	d5626e1d-fd73-4d98-8086-552536eadf39
6dedd6c1-19d7-4cab-8499-919d131bb506	2026-06-11 17:04:55.842803+00	1d2d0710-2060-427d-95c3-71a04ad40cf8	717f97b9-6de0-4c33-8c5c-61c9abdebed4
714d7b38-ebad-442d-85d4-ce00b301df50	2026-06-11 17:04:56.606763+00	3ba92218-b98c-4eab-84b7-0d76f4cd8b2f	02d56625-7584-447e-8ad0-838c2beeaaf4
ad2236f0-59b9-4202-85a4-472b125d8ae6	2026-06-11 17:04:56.672516+00	3ba92218-b98c-4eab-84b7-0d76f4cd8b2f	2e624d5c-4afa-475d-9083-9877614d6d06
4c0d2dd3-5e5e-408d-9795-36a1b8c710f8	2026-06-11 18:17:03.709516+00	8d71e52f-e705-4a32-9b38-40223ef36869	db488050-f420-4024-830b-bc6b7507ac94
f98d6aea-1e00-4501-9fec-3bd7b8484fd3	2026-06-11 18:17:03.76446+00	8d71e52f-e705-4a32-9b38-40223ef36869	717f97b9-6de0-4c33-8c5c-61c9abdebed4
c0897929-03e7-4163-9717-3f2e589bf864	2026-06-11 18:17:27.180668+00	032e3493-7e12-4946-bd36-c17b728ccd66	db488050-f420-4024-830b-bc6b7507ac94
ee6e11d1-6ff3-4dd0-8796-d17429eee21d	2026-06-11 18:17:27.234517+00	2d897011-eaba-4425-83e6-75fcc271a691	db488050-f420-4024-830b-bc6b7507ac94
a88f99d2-d107-4969-b47a-57a866c7a49e	2026-06-11 18:17:27.287683+00	032e3493-7e12-4946-bd36-c17b728ccd66	27517d56-3f32-4ff1-a77e-ec55d96f903a
4b12521b-05d4-49b4-ba9b-ba6b0f00632f	2026-06-11 18:17:27.345902+00	2d897011-eaba-4425-83e6-75fcc271a691	27517d56-3f32-4ff1-a77e-ec55d96f903a
76b08692-0acd-4458-960b-d33891fda0bc	2026-06-11 18:20:16.246992+00	f0d6ecbc-5bf7-4388-a8af-f137134c374a	db488050-f420-4024-830b-bc6b7507ac94
f2be4b88-0b04-4e8a-9e7b-538c8946f6ca	2026-06-11 18:20:16.305935+00	324e5a64-6a9c-41ad-bfe6-f59182af1ebe	db488050-f420-4024-830b-bc6b7507ac94
4b51cfe7-4e1f-4b09-9145-524709f98df9	2026-06-11 18:20:16.372743+00	f0d6ecbc-5bf7-4388-a8af-f137134c374a	cd9bd543-becf-4a12-b672-47bcd0d4c95e
3c35661a-4e5c-480f-bb84-024f60a0b262	2026-06-11 18:20:16.442032+00	324e5a64-6a9c-41ad-bfe6-f59182af1ebe	cd9bd543-becf-4a12-b672-47bcd0d4c95e
1edc1245-0631-40a2-badb-3c89270156f6	2026-06-11 20:54:38.52593+00	f07b0be6-4071-4b37-988c-13d86bfd21cc	0289dffa-d174-4241-95e2-a6e004cfa72c
c13bd0c2-cf66-4f29-bf95-64604c424262	2026-06-11 20:54:38.586032+00	8f45415d-edce-47ab-be91-1b325b5d763f	0289dffa-d174-4241-95e2-a6e004cfa72c
76ebdf77-f68e-40c6-94cb-875ecaa34b1d	2026-06-11 20:54:38.752154+00	8f45415d-edce-47ab-be91-1b325b5d763f	27517d56-3f32-4ff1-a77e-ec55d96f903a
7e3dbdfd-d7d8-4717-aed7-40e8ad8dfcfc	2026-06-11 20:54:38.829733+00	f07b0be6-4071-4b37-988c-13d86bfd21cc	27517d56-3f32-4ff1-a77e-ec55d96f903a
a13f0a8b-9ad7-4836-a985-76bd98e63f16	2026-06-11 20:55:17.254665+00	bd8db874-bd1a-4f65-9fb1-6c8116845e16	0289dffa-d174-4241-95e2-a6e004cfa72c
aa8efcd5-cc05-4d5d-aeab-099dbb23aa00	2026-06-11 20:55:17.365136+00	4bc171e0-37ed-45de-a893-8fbc7e23fb9f	0289dffa-d174-4241-95e2-a6e004cfa72c
93ef2c33-ae10-451a-8996-ff7f2c362169	2026-06-11 20:55:17.486949+00	bd8db874-bd1a-4f65-9fb1-6c8116845e16	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
6a545837-4ff5-466a-8cff-c425de8cfb3c	2026-06-11 20:55:17.586711+00	4bc171e0-37ed-45de-a893-8fbc7e23fb9f	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.conversations (id, created_at, updated_at, deleted_at) FROM stdin;
c6adebb0-838a-4574-ae2b-332258d320db	2026-06-10 14:25:31.02682+00	2026-06-10 14:25:31.026856+00	\N
6f543bb5-f963-4abf-be67-017313aa693a	2026-06-10 14:25:32.24197+00	2026-06-10 14:25:32.242049+00	\N
aa3c0b6d-7d42-4f34-8b81-e907c32f82a5	2026-06-10 14:25:33.669988+00	2026-06-10 14:25:33.670078+00	\N
e2c82824-1eb6-4cc9-9e17-470cf927e6b0	2026-06-10 14:25:34.599715+00	2026-06-10 14:25:34.599748+00	\N
f6247269-527c-4758-a721-d4f334b9d278	2026-06-10 14:25:36.14995+00	2026-06-10 14:25:36.149987+00	\N
cec86833-fedb-4c98-8c71-70409ef56abf	2026-06-10 17:12:26.96717+00	2026-06-10 17:12:26.967187+00	\N
d9e83586-f916-4f41-8203-7cfd7d44d018	2026-06-11 15:33:31.70353+00	2026-06-11 15:33:31.703555+00	\N
73dec969-ad14-413e-9151-28dfdcad917c	2026-06-11 15:45:14.137976+00	2026-06-11 15:45:14.137992+00	\N
a3bbcaeb-e60b-4fdf-b03f-d88dcf00549e	2026-06-11 16:04:55.608692+00	2026-06-11 16:04:55.608812+00	\N
b9aa586f-25e1-442e-8966-04f97cac29e0	2026-06-11 17:04:51.815671+00	2026-06-11 17:04:51.815703+00	\N
707c9a99-965b-457d-8795-a991136438d3	2026-06-11 17:04:53.098674+00	2026-06-11 17:04:53.098712+00	\N
cad3c041-8738-4441-9dbf-9b58d15fa1ae	2026-06-11 17:04:54.513695+00	2026-06-11 17:04:54.513717+00	\N
1d2d0710-2060-427d-95c3-71a04ad40cf8	2026-06-11 17:04:55.731888+00	2026-06-11 17:04:55.731939+00	\N
3ba92218-b98c-4eab-84b7-0d76f4cd8b2f	2026-06-11 17:04:56.551009+00	2026-06-11 17:04:56.551044+00	\N
8d71e52f-e705-4a32-9b38-40223ef36869	2026-06-11 18:17:03.644009+00	2026-06-11 18:17:03.644048+00	\N
032e3493-7e12-4946-bd36-c17b728ccd66	2026-06-11 18:17:27.108333+00	2026-06-11 18:17:27.108365+00	\N
2d897011-eaba-4425-83e6-75fcc271a691	2026-06-11 18:17:27.137838+00	2026-06-11 18:17:27.137863+00	\N
f0d6ecbc-5bf7-4388-a8af-f137134c374a	2026-06-11 18:20:16.175013+00	2026-06-11 18:20:16.17504+00	\N
324e5a64-6a9c-41ad-bfe6-f59182af1ebe	2026-06-11 18:20:16.234534+00	2026-06-11 18:20:16.234561+00	\N
f07b0be6-4071-4b37-988c-13d86bfd21cc	2026-06-11 20:54:38.446127+00	2026-06-11 20:54:38.446149+00	\N
8f45415d-edce-47ab-be91-1b325b5d763f	2026-06-11 20:54:38.466586+00	2026-06-11 20:54:38.466623+00	\N
bd8db874-bd1a-4f65-9fb1-6c8116845e16	2026-06-11 20:55:17.033287+00	2026-06-11 20:55:17.033326+00	\N
4bc171e0-37ed-45de-a893-8fbc7e23fb9f	2026-06-11 20:55:17.083123+00	2026-06-11 20:55:17.083155+00	\N
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2026-06-11 15:25:45.714264+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	alice@example.com	2	[{"changed": {"fields": ["password"]}}]	8	cef5d0be-9064-4305-9468-bd3900d374a1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	token_blacklist	blacklistedtoken
7	token_blacklist	outstandingtoken
8	accounts	user
9	profiles	skill
10	profiles	profile
11	profiles	availabilityslot
12	profiles	userskill
13	mentoring	mentorshippost
14	mentoring	match
15	chat	conversation
16	chat	conversationmember
17	chat	message
18	notifications	notification
19	onboarding	verificationdocument
20	mentoring	review
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-06-10 12:08:33.86302+00
2	contenttypes	0002_remove_content_type_name	2026-06-10 12:08:34.060902+00
3	auth	0001_initial	2026-06-10 12:08:37.400383+00
4	auth	0002_alter_permission_name_max_length	2026-06-10 12:08:37.749206+00
5	auth	0003_alter_user_email_max_length	2026-06-10 12:08:37.899105+00
6	auth	0004_alter_user_username_opts	2026-06-10 12:08:38.168072+00
7	auth	0005_alter_user_last_login_null	2026-06-10 12:08:38.368581+00
8	auth	0006_require_contenttypes_0002	2026-06-10 12:08:38.576113+00
9	auth	0007_alter_validators_add_error_messages	2026-06-10 12:08:38.769736+00
10	auth	0008_alter_user_username_max_length	2026-06-10 12:08:39.038681+00
11	auth	0009_alter_user_last_name_max_length	2026-06-10 12:08:39.223901+00
12	auth	0010_alter_group_name_max_length	2026-06-10 12:08:39.478943+00
13	auth	0011_update_proxy_permissions	2026-06-10 12:08:39.886456+00
14	auth	0012_alter_user_first_name_max_length	2026-06-10 12:08:40.08408+00
15	accounts	0001_initial	2026-06-10 12:08:46.389251+00
16	admin	0001_initial	2026-06-10 12:08:48.271078+00
17	admin	0002_logentry_remove_auto_add	2026-06-10 12:08:48.447247+00
18	admin	0003_logentry_add_action_flag_choices	2026-06-10 12:08:57.962425+00
19	chat	0001_initial	2026-06-10 12:09:00.470403+00
20	mentoring	0001_initial	2026-06-10 12:09:02.62857+00
21	notifications	0001_initial	2026-06-10 12:09:03.249839+00
22	notifications	0002_alter_notification_type_max_length	2026-06-10 12:09:03.346204+00
23	onboarding	0001_initial	2026-06-10 12:09:04.056872+00
24	onboarding	0002_rename_vd_status_idx_verificatio_status_a43286_idx_and_more	2026-06-10 12:09:04.232107+00
25	profiles	0001_initial	2026-06-10 12:09:05.628534+00
26	sessions	0001_initial	2026-06-10 12:09:06.049855+00
27	token_blacklist	0001_initial	2026-06-10 12:09:06.902302+00
28	token_blacklist	0002_outstandingtoken_jti_hex	2026-06-10 12:09:07.16292+00
29	token_blacklist	0003_auto_20171017_2007	2026-06-10 12:09:07.303646+00
30	token_blacklist	0004_auto_20171017_2013	2026-06-10 12:09:07.599582+00
31	token_blacklist	0005_remove_outstandingtoken_jti	2026-06-10 12:09:07.74163+00
32	token_blacklist	0006_auto_20171017_2113	2026-06-10 12:09:07.847473+00
33	token_blacklist	0007_auto_20171017_2214	2026-06-10 12:09:08.044795+00
34	token_blacklist	0008_migrate_to_bigautofield	2026-06-10 12:09:08.852747+00
35	token_blacklist	0010_fix_migrate_to_bigautofield	2026-06-10 12:09:09.152415+00
36	token_blacklist	0011_linearizes_history	2026-06-10 12:09:09.337298+00
37	token_blacklist	0012_alter_outstandingtoken_user	2026-06-10 12:09:09.538193+00
38	mentoring	0002_review	2026-06-10 15:03:19.590995+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
sm7vnvnqqr28dgb3muqsr6kct0eboxld	.eJxVzMsOwiAQheF3YW3JwEBhXLr3GZqBAVs1bdLLyvju2qQLXZ__Oy_V8bb23baUuRtEnVUu1Quk0hC0rnEIviHXxiYJEoBgcGzU6Zclzo8y7lbuPN4mnadxnYek90Qf66Kvk5Tn5Wj_Dnpe-q8OViJDIrbOZgE0AWqtuRqKwWGy5IOvxEBW0KYawcSKTBA9eOTs1PsDrjZAIA:1wXhHu:mez7Qq-tw_9CAO473wiHLYZ8ild5XTIF51cRMyuGstU	2026-06-25 15:25:46.026468+00
\.


--
-- Data for Name: matches; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.matches (id, created_at, updated_at, deleted_at, compatibility_score, status, matched_at, mentee_id, mentor_id, offer_id, request_id) FROM stdin;
d1ccb750-5cff-433e-af22-e5da0c76b1a7	2026-06-10 14:25:30.125632+00	2026-06-11 17:04:51.175848+00	\N	85.5	PENDING	2026-06-10 14:25:13.858442+00	3f1f157d-98f6-4907-8c7c-165e573a186a	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	c3fb5fb5-65e4-482d-8b02-3d43a6e07604	32933d29-3c36-4355-b3ed-7262e6dc3cb0
729ebb4c-d6c5-4515-9d7e-ccf87cf668a0	2026-06-10 14:25:30.26604+00	2026-06-11 17:04:51.416203+00	\N	92	ACCEPTED	2026-06-07 14:25:13.858442+00	a097155f-18d3-401f-b023-a0e05b8a6753	e876f033-f143-4f4b-9adc-71642419144a	89fb4e17-f6ef-4c3a-942d-c770803925db	43e607af-f3d7-4668-b8ed-4450c4ec8501
3147eb6e-86a9-4dea-9a48-bd75a4bbfac8	2026-06-10 14:25:30.421272+00	2026-06-11 17:04:51.472563+00	\N	78	ACCEPTED	2026-06-04 14:25:13.858442+00	3f1f157d-98f6-4907-8c7c-165e573a186a	7d28b09c-b8fd-45bf-806d-ad82d4884774	9f2c7ea6-484e-4b8b-81e0-d75ef4ee241e	\N
4d1a5c0a-b84b-403b-b6d9-8dd412065a3f	2026-06-10 14:25:30.552605+00	2026-06-11 17:04:51.539456+00	\N	65	PENDING	2026-06-01 14:25:13.858442+00	2e624d5c-4afa-475d-9083-9877614d6d06	02d56625-7584-447e-8ad0-838c2beeaaf4	0bc73ee9-88d4-47ce-a072-cd77aab3c0bd	a59b5500-b50a-492a-8601-e7ab2f88b540
08242230-05c5-4f04-b41a-18e6ea54559b	2026-06-10 14:25:30.663322+00	2026-06-11 17:04:51.604753+00	\N	71	ACCEPTED	2026-05-29 14:25:13.858442+00	717f97b9-6de0-4c33-8c5c-61c9abdebed4	d5626e1d-fd73-4d98-8086-552536eadf39	bb632acc-d1e1-47d3-86f9-32484f9bffdd	14b0554b-06b5-4acd-8258-9bcae096eacd
ac6f5344-2544-4f02-9a98-c4ac871b7234	2026-06-10 14:25:30.785512+00	2026-06-11 17:04:51.673299+00	\N	88	FINISHED	2026-05-26 14:25:13.858442+00	a097155f-18d3-401f-b023-a0e05b8a6753	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	d50cdd95-63e8-4e88-a868-8900fa07777c	\N
b3d8fc07-e68a-4470-8c6d-9801184492c0	2026-06-10 14:25:30.915188+00	2026-06-11 17:04:51.737029+00	\N	45	REJECTED	2026-05-23 14:25:13.858442+00	2e624d5c-4afa-475d-9083-9877614d6d06	3e8bb4c1-0d5a-4bc5-bcd6-95598f4f7363	84f078d6-1436-4b7a-a84e-3775b3148f3e	\N
5e1268af-d7f2-47c8-ab02-effa59a0786a	2026-06-11 17:11:54.818367+00	2026-06-11 17:11:54.818391+00	\N	49.5	PENDING	2026-06-11 17:11:54.818445+00	3f1f157d-98f6-4907-8c7c-165e573a186a	27517d56-3f32-4ff1-a77e-ec55d96f903a	10c91a51-8cb5-49df-9c5f-4a656d476bea	\N
d5c12c10-c2e0-4774-9d23-1d0414c4faf0	2026-06-11 17:11:54.891385+00	2026-06-11 17:11:54.891406+00	\N	29.67	PENDING	2026-06-11 17:11:54.89145+00	a097155f-18d3-401f-b023-a0e05b8a6753	27517d56-3f32-4ff1-a77e-ec55d96f903a	10c91a51-8cb5-49df-9c5f-4a656d476bea	\N
affbcefc-b9f4-4596-921b-f2d2ab2fd315	2026-06-11 17:11:54.984802+00	2026-06-11 17:11:54.984821+00	\N	25.33	PENDING	2026-06-11 17:11:54.984859+00	2e624d5c-4afa-475d-9083-9877614d6d06	27517d56-3f32-4ff1-a77e-ec55d96f903a	10c91a51-8cb5-49df-9c5f-4a656d476bea	\N
c55cc5d6-f16c-4cd0-9aed-9031a7a81b8b	2026-06-11 17:11:55.083036+00	2026-06-11 17:11:55.08313+00	\N	19.71	PENDING	2026-06-11 17:11:55.083202+00	717f97b9-6de0-4c33-8c5c-61c9abdebed4	27517d56-3f32-4ff1-a77e-ec55d96f903a	10c91a51-8cb5-49df-9c5f-4a656d476bea	\N
\.


--
-- Data for Name: mentorship_posts; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.mentorship_posts (id, created_at, updated_at, deleted_at, type, subject, description, format, status, creator_id) FROM stdin;
c3fb5fb5-65e4-482d-8b02-3d43a6e07604	2026-06-10 14:25:28.848698+00	2026-06-10 14:25:28.848721+00	\N	OFFER	Python Programming for Beginners	I can help you learn Python from scratch. We'll cover basics, OOP, and small projects.	ONLINE	OPEN	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
d50cdd95-63e8-4e88-a868-8900fa07777c	2026-06-10 14:25:28.924967+00	2026-06-10 14:25:28.925001+00	\N	OFFER	Java Fundamentals	Learn Java from the ground up. Topics: syntax, OOP, collections, and basic algorithms.	BOTH	OPEN	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
9f2c7ea6-484e-4b8b-81e0-d75ef4ee241e	2026-06-10 14:25:29.013446+00	2026-06-10 14:25:29.013481+00	\N	OFFER	Mathematics Tutoring (All Levels)	Available for math tutoring up to M1 level. Algebra, calculus, statistics.	BOTH	OPEN	7d28b09c-b8fd-45bf-806d-ad82d4884774
188889a5-f248-4019-adb8-6f9b3b66a791	2026-06-10 14:25:29.089119+00	2026-06-10 14:25:29.089141+00	\N	OFFER	Physics for Engineers	Help with mechanics, thermodynamics, and electromagnetism.	PHYSICAL	OPEN	7d28b09c-b8fd-45bf-806d-ad82d4884774
84f078d6-1436-4b7a-a84e-3775b3148f3e	2026-06-10 14:25:29.167199+00	2026-06-10 14:25:29.167234+00	\N	OFFER	Quantum Physics Mentorship	Deep dive into quantum mechanics for advanced students.	ONLINE	OPEN	3e8bb4c1-0d5a-4bc5-bcd6-95598f4f7363
6c899934-d735-4921-a3b8-6208160de983	2026-06-10 14:25:29.23232+00	2026-06-10 14:25:29.232338+00	\N	OFFER	Machine Learning from Scratch	Understand the math behind ML algorithms. From linear regression to neural networks.	ONLINE	OPEN	3e8bb4c1-0d5a-4bc5-bcd6-95598f4f7363
73ec3db7-fbaf-4493-9da9-b758efe07d1b	2026-06-10 14:25:29.299655+00	2026-06-10 14:25:29.299693+00	\N	OFFER	React & TypeScript Crash Course	Modern frontend development with React, hooks, and TypeScript.	ONLINE	OPEN	e876f033-f143-4f4b-9adc-71642419144a
89fb4e17-f6ef-4c3a-942d-c770803925db	2026-06-10 14:25:29.389858+00	2026-06-10 14:25:29.389894+00	\N	OFFER	Full-Stack Web Development	From database to deployment. Django + React + Docker.	BOTH	OPEN	e876f033-f143-4f4b-9adc-71642419144a
0bc73ee9-88d4-47ce-a072-cd77aab3c0bd	2026-06-10 14:25:29.479239+00	2026-06-10 14:25:29.479281+00	\N	OFFER	Cybersecurity 101	Learn ethical hacking, network security, and penetration testing basics.	ONLINE	OPEN	02d56625-7584-447e-8ad0-838c2beeaaf4
a37c29a5-b7dd-45cc-887a-487af85e5223	2026-06-10 14:25:29.55494+00	2026-06-10 14:25:29.554973+00	\N	OFFER	Network Architecture	Understanding TCP/IP, routing, switching, and network design.	PHYSICAL	OPEN	02d56625-7584-447e-8ad0-838c2beeaaf4
bb632acc-d1e1-47d3-86f9-32484f9bffdd	2026-06-10 14:25:29.621773+00	2026-06-10 14:25:29.621802+00	\N	OFFER	Data Science with Python	Pandas, NumPy, visualization, and basic ML models.	ONLINE	OPEN	d5626e1d-fd73-4d98-8086-552536eadf39
59ff55c4-fdf5-4759-8b9d-f8c4bee4566d	2026-06-10 14:25:29.688658+00	2026-06-10 14:25:29.688679+00	\N	OFFER	Deep Learning Specialization	Neural networks, CNNs, RNNs, and Transformers with PyTorch.	ONLINE	OPEN	d5626e1d-fd73-4d98-8086-552536eadf39
32933d29-3c36-4355-b3ed-7262e6dc3cb0	2026-06-10 14:25:29.753573+00	2026-06-10 14:25:29.753596+00	\N	REQUEST	Looking for Python Mentor	Need help with Python and algorithms for my L3 project.	ONLINE	OPEN	3f1f157d-98f6-4907-8c7c-165e573a186a
43e607af-f3d7-4668-b8ed-4450c4ec8501	2026-06-10 14:25:29.820965+00	2026-06-10 14:25:29.820993+00	\N	REQUEST	Web Development Help	Looking for guidance on building my first web project.	PHYSICAL	OPEN	a097155f-18d3-401f-b023-a0e05b8a6753
a59b5500-b50a-492a-8601-e7ab2f88b540	2026-06-10 14:25:29.885528+00	2026-06-10 14:25:29.885551+00	\N	REQUEST	Java Programming Tutor	Beginner in Java, need help understanding OOP concepts.	BOTH	OPEN	2e624d5c-4afa-475d-9083-9877614d6d06
d43cd568-4f88-46c3-b928-d58bd86e94f3	2026-06-10 14:25:29.943633+00	2026-06-10 14:25:29.943686+00	\N	REQUEST	Mobile App Development	Want to learn Android or Flutter development.	ONLINE	OPEN	2e624d5c-4afa-475d-9083-9877614d6d06
14b0554b-06b5-4acd-8258-9bcae096eacd	2026-06-10 14:25:30.00738+00	2026-06-10 14:25:30.007399+00	\N	REQUEST	Frontend Development Mentor	I know design but need help with HTML, CSS, and JavaScript.	ONLINE	OPEN	717f97b9-6de0-4c33-8c5c-61c9abdebed4
84c49969-096d-4b99-98f1-2c8fd92b7406	2026-06-10 14:25:30.064166+00	2026-06-10 14:25:30.064184+00	\N	REQUEST	React.js Learning Partner	Looking for someone to learn React with.	BOTH	OPEN	717f97b9-6de0-4c33-8c5c-61c9abdebed4
d8b2ab92-a078-43b1-9b18-fa13be4f48bb	2026-06-10 17:49:37.895619+00	2026-06-10 17:49:37.895656+00	\N	OFFER	bhjk,lm	hijokplé	ONLINE	OPEN	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
ab6af5cc-90cf-4f15-ae18-4b7a9a8b2efc	2026-06-10 18:09:10.948289+00	2026-06-10 18:09:10.948305+00	\N	OFFER	Alex		ONLINE	OPEN	cd9bd543-becf-4a12-b672-47bcd0d4c95e
10c91a51-8cb5-49df-9c5f-4a656d476bea	2026-06-11 17:11:31.344944+00	2026-06-11 17:11:31.344959+00	\N	OFFER	Python & JavaScript Mentoring	I can help with Python and JavaScript programming.	ONLINE	OPEN	27517d56-3f32-4ff1-a77e-ec55d96f903a
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.messages (id, created_at, updated_at, deleted_at, content, read_at, conversation_id, sender_id) FROM stdin;
6106a5de-7f9a-43a9-8ffb-8f3c5aaffd87	2026-06-10 15:41:30.8807+00	2026-06-10 15:41:30.88072+00	\N	Test message from API at 16:41:30	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
f5b5deb0-98cd-42cb-84ab-04c3702f5d11	2026-05-28 12:25:13.858442+00	2026-06-10 14:25:31.191353+00	\N	Hi Bob! I saw your request for a Python mentor. I'd be happy to help you!	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
89224ed1-51eb-4507-b119-ccd0c6b652f9	2026-06-10 15:42:52.509187+00	2026-06-10 15:42:52.509211+00	\N	Test depuis le navigateur virtuel	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
d1066d1b-1bd5-47a9-b7db-70980960233b	2026-06-10 16:07:57.993807+00	2026-06-10 16:07:57.993822+00	\N	Bonjour via WebSocket!	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
d8d70f86-8739-4c30-bf76-dbcfdc58acad	2026-05-28 14:25:13.858442+00	2026-06-10 14:25:31.479511+00	\N	No worries, we all start somewhere. Let's begin with the basics of Python syntax and gradually move to OOP. Are you free this Monday?	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
45821a7d-2ad7-421e-8412-ecae34b9a165	2026-06-10 16:28:31.984819+00	2026-06-10 16:28:31.984847+00	\N	Message test depuis le script!	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
a3fc4a96-15f8-412c-b021-d81e3be146c6	2026-06-10 16:28:32.069428+00	2026-06-10 16:28:32.069443+00	\N	Hello via WebSocket!	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
c467baca-6b72-4645-96ec-9511acfc66c0	2026-05-28 20:25:13.858442+00	2026-06-10 14:25:31.766387+00	\N	Perfect! Let's meet Monday at 10am. I'll send you a Google Meet link. For the first session, please review Python data types and loops.	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
08f87e25-b4fd-42df-b5e4-700b71b9df6e	2026-06-10 16:31:20.09071+00	2026-06-10 16:31:20.090729+00	\N	Test message via WS!	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
b7cad75c-311e-4b37-9d25-63d9adac29fb	2026-06-10 16:31:20.186929+00	2026-06-10 16:31:20.186942+00	\N	Message via REST API!	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
2f17d7e6-9dd4-4f36-8cca-93be0cf8a30e	2026-05-31 13:25:13.858442+00	2026-06-10 14:25:32.009311+00	\N	Great session today Bob! You did well with the exercises. For next time, practice classes and inheritance.	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
e9e087bc-996e-48a8-927c-d234e4eb4a19	2026-06-10 17:12:27.366227+00	2026-06-10 17:12:27.366243+00	\N	Salut	\N	cec86833-fedb-4c98-8c71-70409ef56abf	c156fde9-c5db-49d6-bd58-2844fd4ef021
b0b423dd-e0e6-469c-8387-7536e3060048	2026-06-10 17:51:50.558445+00	2026-06-10 17:51:50.558464+00	\N	E,fo	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
3ce145a9-1a3e-4a89-aed3-b090b8e2e882	2026-06-02 11:25:13.858442+00	2026-06-10 14:25:32.397245+00	\N	Hey Dave! I saw you need help with web development. I'm a full-stack dev, happy to mentor you!	\N	6f543bb5-f963-4abf-be67-017313aa693a	e876f033-f143-4f4b-9adc-71642419144a
cfcba480-4d27-4003-8011-5a4bb3396508	2026-06-10 17:51:55.536718+00	2026-06-10 17:51:55.536743+00	\N	f	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
a9abbf25-441c-4260-8060-72700fa04071	2026-06-02 12:25:13.858442+00	2026-06-10 14:25:32.529438+00	\N	Awesome Frank! I've been trying to build a portfolio site but I'm stuck.	\N	6f543bb5-f963-4abf-be67-017313aa693a	a097155f-18d3-401f-b023-a0e05b8a6753
f50a9acf-5a80-4a92-b5f9-f12589e9b209	2026-06-10 17:52:10.362412+00	2026-06-10 17:52:10.362433+00	\N	Alex	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
22408edc-9a16-498d-932b-33ff5f36790b	2026-06-02 13:25:13.858442+00	2026-06-10 14:25:32.66238+00	\N	Let's start with the basics. Have you worked with HTML, CSS, and JavaScript yet?	\N	6f543bb5-f963-4abf-be67-017313aa693a	e876f033-f143-4f4b-9adc-71642419144a
ffb05922-087f-4a7c-8727-64dea88a3229	2026-06-11 15:27:12.890114+00	2026-06-11 15:27:12.890137+00	\N	cc	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
51b0afc1-6707-4b8a-9eb3-dfca23b5a70b	2026-06-02 14:25:13.858442+00	2026-06-10 14:25:32.795802+00	\N	I know some HTML and CSS from class, but JavaScript is new to me.	\N	6f543bb5-f963-4abf-be67-017313aa693a	a097155f-18d3-401f-b023-a0e05b8a6753
e15fa150-c195-4077-adb2-69cfebb25774	2026-06-11 15:33:32.008928+00	2026-06-11 15:33:32.008944+00	\N	CC	\N	d9e83586-f916-4f41-8203-7cfd7d44d018	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
09ba84dc-3038-48a5-b61d-30344703db0d	2026-06-02 16:25:13.858442+00	2026-06-10 14:25:32.93941+00	\N	Perfect! That's a good start. Let me create a roadmap for you. First two weeks: JavaScript fundamentals. Then we'll move to React.	\N	6f543bb5-f963-4abf-be67-017313aa693a	e876f033-f143-4f4b-9adc-71642419144a
62f877aa-3e30-450b-9c73-fdfa3a3b3814	2026-06-02 17:25:13.858442+00	2026-06-10 14:25:33.050281+00	\N	Here's a good resource: https://javascript.info/ — start with the first 5 chapters.	\N	6f543bb5-f963-4abf-be67-017313aa693a	e876f033-f143-4f4b-9adc-71642419144a
232eb4c0-1555-4354-9242-814690a38083	2026-06-04 02:25:13.858442+00	2026-06-10 14:25:33.172177+00	\N	Thanks Frank! I've started reading. The explanations are really clear.	\N	6f543bb5-f963-4abf-be67-017313aa693a	a097155f-18d3-401f-b023-a0e05b8a6753
d55679c1-865b-406e-bad1-dff766ac49a7	2026-06-08 13:25:13.858442+00	2026-06-10 14:25:33.304927+00	\N	Great progress Dave! Your JavaScript is coming along nicely. Next week we start React!	\N	6f543bb5-f963-4abf-be67-017313aa693a	e876f033-f143-4f4b-9adc-71642419144a
f4470e19-bd05-4b60-9c1a-6f2d2dcbb8a7	2026-06-08 14:25:13.858442+00	2026-06-10 14:25:33.437849+00	\N	Can't wait! I built a small calculator project with vanilla JS this week.	\N	6f543bb5-f963-4abf-be67-017313aa693a	a097155f-18d3-401f-b023-a0e05b8a6753
b0f30f8b-b98c-4fed-8cc7-2080c16bf390	2026-06-08 16:25:13.858442+00	2026-06-10 14:25:33.559935+00	\N	That's excellent! Share it with me, I'll review the code.	\N	6f543bb5-f963-4abf-be67-017313aa693a	e876f033-f143-4f4b-9adc-71642419144a
af00bea0-b134-4fcd-baab-6fd9ef98c4b5	2026-06-05 10:25:13.858442+00	2026-06-10 14:25:33.847224+00	\N	Hi Bob! I'm available to help you with mathematics. What topics are you working on?	\N	aa3c0b6d-7d42-4f34-8b81-e907c32f82a5	7d28b09c-b8fd-45bf-806d-ad82d4884774
3691d849-6ee7-4b47-af67-c64b0af15176	2026-06-05 11:25:13.858442+00	2026-06-10 14:25:33.980279+00	\N	Hi Carol! I need help with statistics and probability for my data science class.	\N	aa3c0b6d-7d42-4f34-8b81-e907c32f82a5	3f1f157d-98f6-4907-8c7c-165e573a186a
1c4c32ff-8e7c-442b-ac86-b1d82949e5e0	2026-06-05 12:25:13.858442+00	2026-06-10 14:25:34.101975+00	\N	Great, statistics is my favorite! Let's start with descriptive statistics and probability distributions.	\N	aa3c0b6d-7d42-4f34-8b81-e907c32f82a5	7d28b09c-b8fd-45bf-806d-ad82d4884774
d5060dfe-8046-4cca-be45-63ed0c74e3e6	2026-06-05 14:25:13.858442+00	2026-06-10 14:25:34.223245+00	\N	Perfect, I have an exam in 3 weeks so the sooner the better!	\N	aa3c0b6d-7d42-4f34-8b81-e907c32f82a5	3f1f157d-98f6-4907-8c7c-165e573a186a
4f27bc6a-beae-4857-9492-ef81d25ead6a	2026-06-05 18:25:13.858442+00	2026-06-10 14:25:34.333988+00	\N	We have plenty of time. I'll prepare some exercises for our first session.	\N	aa3c0b6d-7d42-4f34-8b81-e907c32f82a5	7d28b09c-b8fd-45bf-806d-ad82d4884774
0428a37c-ac9d-4e80-9de1-eb87e4f7c7d5	2026-06-05 20:25:13.858442+00	2026-06-10 14:25:34.466858+00	\N	Thank you Carol! See you Thursday.	\N	aa3c0b6d-7d42-4f34-8b81-e907c32f82a5	3f1f157d-98f6-4907-8c7c-165e573a186a
a6b508d6-ce33-479d-af25-c9133b1b59cd	2026-06-07 09:25:13.858442+00	2026-06-10 14:25:34.798776+00	\N	Hi Iris! I saw we matched. Even though my expertise is data science, I can help you with Python basics which is useful for web dev too!	\N	e2c82824-1eb6-4cc9-9e17-470cf927e6b0	d5626e1d-fd73-4d98-8086-552536eadf39
23cce7ab-3f16-4893-ac97-4c0a0a4cb039	2026-06-07 10:25:13.858442+00	2026-06-10 14:25:34.932518+00	\N	Hi James! That sounds good. I actually want to understand how to make data visualizations for my portfolio.	\N	e2c82824-1eb6-4cc9-9e17-470cf927e6b0	717f97b9-6de0-4c33-8c5c-61c9abdebed4
da20c00f-77ad-48e9-8288-616c3246df26	2026-06-07 11:25:13.858442+00	2026-06-10 14:25:35.065172+00	\N	Perfect! Python has great libraries for data viz. Let me show you Matplotlib and Plotly.	\N	e2c82824-1eb6-4cc9-9e17-470cf927e6b0	d5626e1d-fd73-4d98-8086-552536eadf39
ef9f1d57-0215-4f71-9427-1ecd1f549654	2026-06-07 12:25:13.858442+00	2026-06-10 14:25:35.19726+00	\N	I love design, and I think data visualization combines both design and programming perfectly!	\N	e2c82824-1eb6-4cc9-9e17-470cf927e6b0	717f97b9-6de0-4c33-8c5c-61c9abdebed4
0ee51ead-4be7-4778-9217-ef9fe4df6f01	2026-06-07 13:25:13.858442+00	2026-06-10 14:25:35.728753+00	\N	Absolutely! Good design is crucial for data viz. We'll work on both the technical and visual aspects.	\N	e2c82824-1eb6-4cc9-9e17-470cf927e6b0	d5626e1d-fd73-4d98-8086-552536eadf39
e8c52bcc-a720-4f25-89ad-60d75deaaca4	2026-06-09 08:25:13.858442+00	2026-06-10 14:25:37.954484+00	\N	Hello Grace! I saw you need a Java tutor, but I also offer cybersecurity mentoring if you're interested.	\N	f6247269-527c-4758-a721-d4f334b9d278	02d56625-7584-447e-8ad0-838c2beeaaf4
32e0f573-45d0-40e7-a7d9-844babd75866	2026-06-09 09:25:13.858442+00	2026-06-10 14:25:38.120389+00	\N	Hi Henry! Cybersecurity sounds really interesting! Can I try both Java and security?	\N	f6247269-527c-4758-a721-d4f334b9d278	2e624d5c-4afa-475d-9083-9877614d6d06
62cfca05-b265-4ab2-908e-fe19440e1fa0	2026-06-09 10:25:13.858442+00	2026-06-10 14:25:38.252512+00	\N	Of course! Java is actually widely used in security. We can learn Java by building security tools!	\N	f6247269-527c-4758-a721-d4f334b9d278	02d56625-7584-447e-8ad0-838c2beeaaf4
f1780d26-3476-4ca5-a24a-3a3f097ffd83	2026-06-09 11:25:13.858442+00	2026-06-10 14:25:38.375073+00	\N	That's a great approach! When can we start?	\N	f6247269-527c-4758-a721-d4f334b9d278	2e624d5c-4afa-475d-9083-9877614d6d06
32825bb6-92ac-4a72-8fa0-79268ebc7fe2	2026-06-09 12:25:13.858442+00	2026-06-10 14:25:38.507925+00	\N	Let's meet this Wednesday at 2pm. I'll prepare a Java security beginner roadmap.	\N	f6247269-527c-4758-a721-d4f334b9d278	02d56625-7584-447e-8ad0-838c2beeaaf4
a615db17-eeac-4057-bda8-8596099b4e1a	2026-06-09 13:25:13.858442+00	2026-06-10 14:25:38.629551+00	\N	Perfect, see you Wednesday!	\N	f6247269-527c-4758-a721-d4f334b9d278	2e624d5c-4afa-475d-9083-9877614d6d06
2c441fd3-1681-420f-8fc7-3d385ce32850	2026-06-11 16:04:56.044039+00	2026-06-11 16:04:56.044055+00	\N	cc	\N	a3bbcaeb-e60b-4fdf-b03f-d88dcf00549e	cd9bd543-becf-4a12-b672-47bcd0d4c95e
fcea23fc-6839-4f77-9e6d-08afc53070e0	2026-05-29 15:04:43.009454+00	2026-06-11 17:04:52.013246+00	\N	Hi Bob! I saw your request for a Python mentor. I'd be happy to help you!	\N	b9aa586f-25e1-442e-8966-04f97cac29e0	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
48596780-3c00-4d80-a70b-c040842ae5e3	2026-05-29 17:04:43.009454+00	2026-06-11 17:04:52.289274+00	\N	No worries, we all start somewhere. Let's begin with the basics of Python syntax and gradually move to OOP. Are you free this Monday?	\N	b9aa586f-25e1-442e-8966-04f97cac29e0	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
b5b02d79-9aa9-4438-a7fb-bda903cc2631	2026-05-29 23:04:43.009454+00	2026-06-11 17:04:52.532738+00	\N	Perfect! Let's meet Monday at 10am. I'll send you a Google Meet link. For the first session, please review Python data types and loops.	\N	b9aa586f-25e1-442e-8966-04f97cac29e0	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
1c096e9e-3192-4178-8425-5e666ca37566	2026-06-01 16:04:43.009454+00	2026-06-11 17:04:52.820076+00	\N	Great session today Bob! You did well with the exercises. For next time, practice classes and inheritance.	\N	b9aa586f-25e1-442e-8966-04f97cac29e0	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
5511a314-039e-453d-bd23-79f6540a87cb	2026-06-03 14:04:43.009454+00	2026-06-11 17:04:53.273968+00	\N	Hey Dave! I saw you need help with web development. I'm a full-stack dev, happy to mentor you!	\N	707c9a99-965b-457d-8795-a991136438d3	e876f033-f143-4f4b-9adc-71642419144a
bc4f3081-9056-4116-a46f-8da7603f35ec	2026-06-03 15:04:43.009454+00	2026-06-11 17:04:53.407221+00	\N	Awesome Frank! I've been trying to build a portfolio site but I'm stuck.	\N	707c9a99-965b-457d-8795-a991136438d3	a097155f-18d3-401f-b023-a0e05b8a6753
7a913e13-90c0-4976-91db-df305d10805c	2026-06-03 16:04:43.009454+00	2026-06-11 17:04:53.519001+00	\N	Let's start with the basics. Have you worked with HTML, CSS, and JavaScript yet?	\N	707c9a99-965b-457d-8795-a991136438d3	e876f033-f143-4f4b-9adc-71642419144a
8806b6fe-888f-46fe-8fea-c1d1d13603db	2026-06-03 17:04:43.009454+00	2026-06-11 17:04:53.639311+00	\N	I know some HTML and CSS from class, but JavaScript is new to me.	\N	707c9a99-965b-457d-8795-a991136438d3	a097155f-18d3-401f-b023-a0e05b8a6753
780a9140-589a-4680-8763-12ba995339c1	2026-06-03 19:04:43.009454+00	2026-06-11 17:04:53.761654+00	\N	Perfect! That's a good start. Let me create a roadmap for you. First two weeks: JavaScript fundamentals. Then we'll move to React.	\N	707c9a99-965b-457d-8795-a991136438d3	e876f033-f143-4f4b-9adc-71642419144a
ee460b65-9be8-4da5-95dc-abc183906b73	2026-06-03 20:04:43.009454+00	2026-06-11 17:04:53.872293+00	\N	Here's a good resource: https://javascript.info/ — start with the first 5 chapters.	\N	707c9a99-965b-457d-8795-a991136438d3	e876f033-f143-4f4b-9adc-71642419144a
87e46a3f-d132-44e1-9832-dd489a5be15e	2026-06-05 05:04:43.009454+00	2026-06-11 17:04:54.005288+00	\N	Thanks Frank! I've started reading. The explanations are really clear.	\N	707c9a99-965b-457d-8795-a991136438d3	a097155f-18d3-401f-b023-a0e05b8a6753
57e5108b-c178-4ef4-97dc-5f02bbfe81d6	2026-06-09 16:04:43.009454+00	2026-06-11 17:04:54.137613+00	\N	Great progress Dave! Your JavaScript is coming along nicely. Next week we start React!	\N	707c9a99-965b-457d-8795-a991136438d3	e876f033-f143-4f4b-9adc-71642419144a
7eccab2b-2a4f-4c27-88c6-911c86377538	2026-06-09 17:04:43.009454+00	2026-06-11 17:04:54.247976+00	\N	Can't wait! I built a small calculator project with vanilla JS this week.	\N	707c9a99-965b-457d-8795-a991136438d3	a097155f-18d3-401f-b023-a0e05b8a6753
397e5ee1-c8cc-42d0-803a-55d0bedd2d99	2026-06-09 19:04:43.009454+00	2026-06-11 17:04:54.381484+00	\N	That's excellent! Share it with me, I'll review the code.	\N	707c9a99-965b-457d-8795-a991136438d3	e876f033-f143-4f4b-9adc-71642419144a
865a73c8-4572-45aa-a730-b7494eec67e7	2026-06-06 13:04:43.009454+00	2026-06-11 17:04:54.713578+00	\N	Hi Bob! I'm available to help you with mathematics. What topics are you working on?	\N	cad3c041-8738-4441-9dbf-9b58d15fa1ae	7d28b09c-b8fd-45bf-806d-ad82d4884774
62808fbd-d13e-4ca3-80c5-f73d0a55eb82	2026-06-06 14:04:43.009454+00	2026-06-11 17:04:54.846163+00	\N	Hi Carol! I need help with statistics and probability for my data science class.	\N	cad3c041-8738-4441-9dbf-9b58d15fa1ae	3f1f157d-98f6-4907-8c7c-165e573a186a
41154d9d-2a23-48fd-9dcd-041e5bb9a8bb	2026-06-06 15:04:43.009454+00	2026-06-11 17:04:54.967763+00	\N	Great, statistics is my favorite! Let's start with descriptive statistics and probability distributions.	\N	cad3c041-8738-4441-9dbf-9b58d15fa1ae	7d28b09c-b8fd-45bf-806d-ad82d4884774
770abefe-2369-46fc-bae4-2c11dab520d9	2026-06-06 17:04:43.009454+00	2026-06-11 17:04:55.090062+00	\N	Perfect, I have an exam in 3 weeks so the sooner the better!	\N	cad3c041-8738-4441-9dbf-9b58d15fa1ae	3f1f157d-98f6-4907-8c7c-165e573a186a
3da5424f-b27a-4620-8845-4c1ff1f753b2	2026-06-06 21:04:43.009454+00	2026-06-11 17:04:55.465924+00	\N	We have plenty of time. I'll prepare some exercises for our first session.	\N	cad3c041-8738-4441-9dbf-9b58d15fa1ae	7d28b09c-b8fd-45bf-806d-ad82d4884774
c55a7cd1-5c20-4913-bbcc-1cc24ee24d49	2026-06-06 23:04:43.009454+00	2026-06-11 17:04:55.599218+00	\N	Thank you Carol! See you Thursday.	\N	cad3c041-8738-4441-9dbf-9b58d15fa1ae	3f1f157d-98f6-4907-8c7c-165e573a186a
e0f44371-abf9-408d-a101-e84cf0d3d9e8	2026-06-08 12:04:43.009454+00	2026-06-11 17:04:55.908591+00	\N	Hi Iris! I saw we matched. Even though my expertise is data science, I can help you with Python basics which is useful for web dev too!	\N	1d2d0710-2060-427d-95c3-71a04ad40cf8	d5626e1d-fd73-4d98-8086-552536eadf39
d92311ec-9219-478e-9e81-d376f567e21d	2026-06-08 13:04:43.009454+00	2026-06-11 17:04:56.030478+00	\N	Hi James! That sounds good. I actually want to understand how to make data visualizations for my portfolio.	\N	1d2d0710-2060-427d-95c3-71a04ad40cf8	717f97b9-6de0-4c33-8c5c-61c9abdebed4
c78112eb-904f-4167-b7ef-0f853eb2ebf3	2026-06-08 14:04:43.009454+00	2026-06-11 17:04:56.152872+00	\N	Perfect! Python has great libraries for data viz. Let me show you Matplotlib and Plotly.	\N	1d2d0710-2060-427d-95c3-71a04ad40cf8	d5626e1d-fd73-4d98-8086-552536eadf39
5162d2a2-55ce-4dff-aba4-4c7b52333ab5	2026-06-08 15:04:43.009454+00	2026-06-11 17:04:56.285609+00	\N	I love design, and I think data visualization combines both design and programming perfectly!	\N	1d2d0710-2060-427d-95c3-71a04ad40cf8	717f97b9-6de0-4c33-8c5c-61c9abdebed4
64cb5b35-7720-4345-9a64-e1c24a0df65f	2026-06-08 16:04:43.009454+00	2026-06-11 17:04:56.41847+00	\N	Absolutely! Good design is crucial for data viz. We'll work on both the technical and visual aspects.	\N	1d2d0710-2060-427d-95c3-71a04ad40cf8	d5626e1d-fd73-4d98-8086-552536eadf39
dc56a2e0-3413-4ae9-afad-825b9d7a0f69	2026-06-10 11:04:43.009454+00	2026-06-11 17:04:56.73895+00	\N	Hello Grace! I saw you need a Java tutor, but I also offer cybersecurity mentoring if you're interested.	\N	3ba92218-b98c-4eab-84b7-0d76f4cd8b2f	02d56625-7584-447e-8ad0-838c2beeaaf4
d3fcf043-b986-4b2f-8cf9-1f6dde487562	2026-06-10 12:04:43.009454+00	2026-06-11 17:04:56.8605+00	\N	Hi Henry! Cybersecurity sounds really interesting! Can I try both Java and security?	\N	3ba92218-b98c-4eab-84b7-0d76f4cd8b2f	2e624d5c-4afa-475d-9083-9877614d6d06
9f96d430-2ae9-46e2-8f73-31459dfa46bd	2026-06-10 13:04:43.009454+00	2026-06-11 17:04:57.004683+00	\N	Of course! Java is actually widely used in security. We can learn Java by building security tools!	\N	3ba92218-b98c-4eab-84b7-0d76f4cd8b2f	02d56625-7584-447e-8ad0-838c2beeaaf4
8f5475e4-8dc1-4728-be9d-09832ca07d84	2026-06-10 14:04:43.009454+00	2026-06-11 17:04:57.115381+00	\N	That's a great approach! When can we start?	\N	3ba92218-b98c-4eab-84b7-0d76f4cd8b2f	2e624d5c-4afa-475d-9083-9877614d6d06
4c77d0bc-7730-4194-98f7-8e729d43d935	2026-06-10 15:04:43.009454+00	2026-06-11 17:04:57.890118+00	\N	Let's meet this Wednesday at 2pm. I'll prepare a Java security beginner roadmap.	\N	3ba92218-b98c-4eab-84b7-0d76f4cd8b2f	02d56625-7584-447e-8ad0-838c2beeaaf4
764f8308-2663-494b-8cb8-c6f49f3c9a7c	2026-06-10 16:04:43.009454+00	2026-06-11 17:04:58.011976+00	\N	Perfect, see you Wednesday!	\N	3ba92218-b98c-4eab-84b7-0d76f4cd8b2f	2e624d5c-4afa-475d-9083-9877614d6d06
32dffcba-2c5f-4d08-b352-d70ae6b649c9	2026-06-11 15:45:33.769483+00	2026-06-11 15:45:33.769498+00	\N	Salut Alex. C'est Alice	2026-06-11 17:24:08.301909+00	73dec969-ad14-413e-9151-28dfdcad917c	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
9e57b184-9fdb-4160-8da5-f246f6a9c3cb	2026-06-11 16:05:53.412755+00	2026-06-11 16:05:53.412771+00	\N	J'ai des difficulté en Mathématique	2026-06-11 17:24:08.301909+00	73dec969-ad14-413e-9151-28dfdcad917c	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
388e2342-4493-424f-b11d-6ca73722abeb	2026-06-11 15:57:05.19724+00	2026-06-11 15:57:05.197257+00	\N	Ok que puis-je faire pour vous ?	2026-06-11 17:26:26.039963+00	73dec969-ad14-413e-9151-28dfdcad917c	cd9bd543-becf-4a12-b672-47bcd0d4c95e
b6c02c91-5c20-448b-99c1-657757b2bdc6	2026-06-11 17:24:18.142904+00	2026-06-11 17:24:18.142919+00	\N	Ok je vois	2026-06-11 17:26:26.039963+00	73dec969-ad14-413e-9151-28dfdcad917c	cd9bd543-becf-4a12-b672-47bcd0d4c95e
758608b6-2fb0-4a82-a9a2-7ea0e0f115b4	2026-05-28 13:25:13.858442+00	2026-06-10 14:25:31.334786+00	\N	Hey Alice! That would be great! I'm really struggling with Python classes and OOP.	2026-06-11 17:27:16.501969+00	c6adebb0-838a-4574-ae2b-332258d320db	3f1f157d-98f6-4907-8c7c-165e573a186a
3564aa81-462f-437e-ab7d-b1556dcd8b19	2026-05-28 18:25:13.858442+00	2026-06-10 14:25:31.62239+00	\N	Yes, Monday works for me! I'm free from 10am to 12pm.	2026-06-11 17:27:16.501969+00	c6adebb0-838a-4574-ae2b-332258d320db	3f1f157d-98f6-4907-8c7c-165e573a186a
97bd3c89-6324-4961-99ce-5b9a4c6706d3	2026-05-28 21:25:13.858442+00	2026-06-10 14:25:31.89911+00	\N	Got it, I'll review those. Thanks so much Alice!	2026-06-11 17:27:16.501969+00	c6adebb0-838a-4574-ae2b-332258d320db	3f1f157d-98f6-4907-8c7c-165e573a186a
b1bfc8e0-9711-4bce-b55d-82588792374c	2026-05-31 14:25:13.858442+00	2026-06-10 14:25:32.131128+00	\N	Thanks Alice! The session was really helpful. I'll practice classes this week.	2026-06-11 17:27:16.501969+00	c6adebb0-838a-4574-ae2b-332258d320db	3f1f157d-98f6-4907-8c7c-165e573a186a
a527b5c7-1965-4ac5-8e19-634b94fa8fc7	2026-05-29 16:04:43.009454+00	2026-06-11 17:04:52.167033+00	\N	Hey Alice! That would be great! I'm really struggling with Python classes and OOP.	2026-06-11 17:27:18.574027+00	b9aa586f-25e1-442e-8966-04f97cac29e0	3f1f157d-98f6-4907-8c7c-165e573a186a
e6ad4322-755b-40c8-b0af-2723cc75632c	2026-05-29 21:04:43.009454+00	2026-06-11 17:04:52.421662+00	\N	Yes, Monday works for me! I'm free from 10am to 12pm.	2026-06-11 17:27:18.574027+00	b9aa586f-25e1-442e-8966-04f97cac29e0	3f1f157d-98f6-4907-8c7c-165e573a186a
b0d54fe7-cd06-46b7-9a7a-b545f45de3be	2026-05-30 00:04:43.009454+00	2026-06-11 17:04:52.665173+00	\N	Got it, I'll review those. Thanks so much Alice!	2026-06-11 17:27:18.574027+00	b9aa586f-25e1-442e-8966-04f97cac29e0	3f1f157d-98f6-4907-8c7c-165e573a186a
fd3d1cc1-2f2f-49a3-9019-508964dc952b	2026-06-01 17:04:43.009454+00	2026-06-11 17:04:52.953393+00	\N	Thanks Alice! The session was really helpful. I'll practice classes this week.	2026-06-11 17:27:18.574027+00	b9aa586f-25e1-442e-8966-04f97cac29e0	3f1f157d-98f6-4907-8c7c-165e573a186a
30247ce5-7d2c-4acc-9589-9f12a6a26b24	2026-06-11 18:17:03.956819+00	2026-06-11 18:17:03.956844+00	\N	OUI Je suis dispo pour t'aider	\N	8d71e52f-e705-4a32-9b38-40223ef36869	db488050-f420-4024-830b-bc6b7507ac94
886dd033-b3d0-4e66-91fe-7afef80be488	2026-06-11 18:17:44.975167+00	2026-06-11 18:17:44.975184+00	\N	je suis iteresser	\N	2d897011-eaba-4425-83e6-75fcc271a691	db488050-f420-4024-830b-bc6b7507ac94
3ad113b3-ad8b-4202-9c6e-e309fb8c5541	2026-06-11 18:20:35.071955+00	2026-06-11 18:20:35.071997+00	\N	je suis interer	2026-06-11 18:21:33.173298+00	324e5a64-6a9c-41ad-bfe6-f59182af1ebe	db488050-f420-4024-830b-bc6b7507ac94
652a0b28-4996-40ae-b504-73a2e06caab1	2026-06-11 18:21:43.321654+00	2026-06-11 18:21:43.321674+00	\N	ok vous est enregistrer	2026-06-11 18:22:17.312376+00	324e5a64-6a9c-41ad-bfe6-f59182af1ebe	cd9bd543-becf-4a12-b672-47bcd0d4c95e
9ae479e8-c5b2-45d1-a41e-dda3adfb2dab	2026-06-11 18:25:02.846109+00	2026-06-11 18:25:02.846134+00	\N	gjhjjhjjhjjhkj	\N	c6adebb0-838a-4574-ae2b-332258d320db	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
c6f844ae-fe97-46e2-ac0d-3d0d244f8e53	2026-06-11 20:54:48.974454+00	2026-06-11 20:54:48.974481+00	\N	hdhhhdhd	\N	8f45415d-edce-47ab-be91-1b325b5d763f	0289dffa-d174-4241-95e2-a6e004cfa72c
775b556f-a2be-47f3-ab06-bbb746f25686	2026-06-11 20:55:31.892795+00	2026-06-11 20:55:31.892819+00	\N	je sui interece	2026-06-11 20:57:41.161804+00	4bc171e0-37ed-45de-a893-8fbc7e23fb9f	0289dffa-d174-4241-95e2-a6e004cfa72c
23e82346-06b2-44e2-8076-123c00fc4ab5	2026-06-11 20:57:55.890742+00	2026-06-11 20:57:55.890782+00	\N	ok tu es enregistre	\N	4bc171e0-37ed-45de-a893-8fbc7e23fb9f	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
c5b046a0-de0f-48b6-a055-2186af036d88	2026-06-11 20:58:12.966576+00	2026-06-11 20:58:12.966602+00	\N	ggg	\N	4bc171e0-37ed-45de-a893-8fbc7e23fb9f	0289dffa-d174-4241-95e2-a6e004cfa72c
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.notifications (id, created_at, updated_at, deleted_at, type, title, content, is_read, metadata, user_id) FROM stdin;
abf7001a-e80e-4360-a176-23480fc05d57	2026-06-11 17:04:43.009454+00	2026-06-11 17:04:58.123784+00	\N	NEW_MATCH	New Match: Bob Kouassi	You have been matched with Bob Kouassi for Python Mentoring for Beginners (85.5% compatibility).	t	\N	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
172e4bf9-86e6-4ab4-8a82-fbbaf8ee85dc	2026-06-11 14:04:43.009454+00	2026-06-10 14:25:38.950314+00	\N	MATCH_ACCEPTED	Match Accepted: Dave Traore	Dave Traore has accepted your Java Fundamentals offer. You can now start mentoring!	t	\N	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
761a4b21-6e95-4700-ad99-5fb467c492f9	2026-06-11 14:04:43.009454+00	2026-06-11 17:04:58.277679+00	\N	MATCH_ACCEPTED	Match Accepted: Dave Traore	Dave Traore has accepted your Java Fundamentals offer. You can now start mentoring!	t	\N	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
2bcdaec8-28c8-4979-9611-d28bb786658e	2026-06-11 11:04:43.009454+00	2026-06-10 14:25:39.094587+00	\N	NEW_MESSAGE	New message from Bob Kouassi	Bob sent you a message in your conversation.	t	\N	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
df8d8f4e-791b-419f-8ee4-9c588958ebea	2026-06-11 11:04:43.009454+00	2026-06-11 17:04:58.410663+00	\N	NEW_MESSAGE	New message from Bob Kouassi	Bob sent you a message in your conversation.	t	\N	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
1fcd6380-1649-41d6-a103-f742ac17dad3	2026-06-11 18:17:04.054318+00	2026-06-11 18:17:04.054364+00	\N	NEW_MESSAGE	Nouveau message de Rodolf AGBO	OUI Je suis dispo pour t'aider	f	{"sender_id": "db488050-f420-4024-830b-bc6b7507ac94", "conversation_id": "8d71e52f-e705-4a32-9b38-40223ef36869"}	717f97b9-6de0-4c33-8c5c-61c9abdebed4
a236c999-47b5-4269-9491-be60c82bfe7a	2026-06-11 16:04:56.183499+00	2026-06-11 16:04:56.183526+00	\N	NEW_MESSAGE	Nouveau message de AGO Alex	cc	f	{"sender_id": "cd9bd543-becf-4a12-b672-47bcd0d4c95e", "conversation_id": "a3bbcaeb-e60b-4fdf-b03f-d88dcf00549e"}	717f97b9-6de0-4c33-8c5c-61c9abdebed4
a603ca16-d128-4b7c-9ada-32b7a9bf330a	2026-06-11 16:05:53.482267+00	2026-06-11 16:05:53.482286+00	\N	NEW_MESSAGE	Nouveau message de Alice Konan	J'ai des difficulté en Mathématique	f	{"sender_id": "4e8c1fcf-a156-44f2-bf16-9fa3b37d3977", "conversation_id": "73dec969-ad14-413e-9151-28dfdcad917c"}	cd9bd543-becf-4a12-b672-47bcd0d4c95e
55cb7c25-17dc-4d77-9bcd-99f5ff81be55	2026-06-11 17:04:43.009454+00	2026-06-10 14:25:38.762759+00	\N	NEW_MATCH	New Match: Bob Kouassi	You have been matched with Bob Kouassi for Python Mentoring for Beginners (85.5% compatibility).	t	\N	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
3e62804f-53c0-4db4-8057-461eaae2248c	2026-06-11 08:04:43.009454+00	2026-06-10 14:25:39.205159+00	\N	NEW_MATCH	New Match: Alice Konan	You have been matched with Alice Konan for your Python mentoring request (85.5% compatibility).	f	\N	3f1f157d-98f6-4907-8c7c-165e573a186a
56bc0d4b-8508-4748-8752-4205423c52e2	2026-06-11 08:04:43.009454+00	2026-06-11 17:04:58.543143+00	\N	NEW_MATCH	New Match: Alice Konan	You have been matched with Alice Konan for your Python mentoring request (85.5% compatibility).	f	\N	3f1f157d-98f6-4907-8c7c-165e573a186a
6cc62268-32ef-4d61-a5f4-ea1ddf4f9e3c	2026-06-11 05:04:43.009454+00	2026-06-10 14:25:39.349116+00	\N	NEW_MATCH	New Match: Carol Diallo	You have been matched with Carol Diallo for Mathematics Tutoring (78.0% compatibility).	f	\N	3f1f157d-98f6-4907-8c7c-165e573a186a
2ddb96f3-7ff6-4545-8298-a7c557cac710	2026-06-11 05:04:43.009454+00	2026-06-11 17:04:58.66546+00	\N	NEW_MATCH	New Match: Carol Diallo	You have been matched with Carol Diallo for Mathematics Tutoring (78.0% compatibility).	f	\N	3f1f157d-98f6-4907-8c7c-165e573a186a
bc13fc50-f392-4cab-b30b-ccaf0b479bba	2026-06-11 02:04:43.009454+00	2026-06-10 14:25:39.47094+00	\N	NEW_MESSAGE	New message from Alice Konan	Alice sent you a message in your conversation.	f	\N	3f1f157d-98f6-4907-8c7c-165e573a186a
3ecb3af6-b8f4-44a9-8b02-5de54dfe1bb9	2026-06-11 02:04:43.009454+00	2026-06-11 17:04:58.787128+00	\N	NEW_MESSAGE	New message from Alice Konan	Alice sent you a message in your conversation.	f	\N	3f1f157d-98f6-4907-8c7c-165e573a186a
712d8889-4e7b-421f-8840-9100c97f93b5	2026-06-10 23:04:43.009454+00	2026-06-10 14:25:39.592093+00	\N	NEW_MATCH	New Mentee: Bob Kouassi	Bob Kouassi has been matched with you for Mathematics Tutoring (78.0% compatibility).	f	\N	7d28b09c-b8fd-45bf-806d-ad82d4884774
643701d7-7c8d-46c4-a303-320999438039	2026-06-10 23:04:43.009454+00	2026-06-11 17:04:58.919619+00	\N	NEW_MATCH	New Mentee: Bob Kouassi	Bob Kouassi has been matched with you for Mathematics Tutoring (78.0% compatibility).	f	\N	7d28b09c-b8fd-45bf-806d-ad82d4884774
073b8539-2546-447a-aaa1-17b37b1a2219	2026-06-10 20:04:43.009454+00	2026-06-10 14:25:39.71462+00	\N	NEW_MESSAGE	New message from Bob Kouassi	Bob sent you a message.	f	\N	7d28b09c-b8fd-45bf-806d-ad82d4884774
80e0442a-a952-4adb-92e0-8603a8b89a8f	2026-06-10 20:04:43.009454+00	2026-06-11 17:04:59.053523+00	\N	NEW_MESSAGE	New message from Bob Kouassi	Bob sent you a message.	f	\N	7d28b09c-b8fd-45bf-806d-ad82d4884774
431cee5a-9536-4902-9840-e98cb3b6a92a	2026-06-10 17:04:43.009454+00	2026-06-10 14:25:39.846836+00	\N	NEW_MATCH	New Match: Frank Soro	You have been matched with Frank Soro for Full-Stack Web Development (92.0% compatibility).	f	\N	a097155f-18d3-401f-b023-a0e05b8a6753
19f820d9-8b81-490d-ad06-8bd2e798a462	2026-06-10 17:04:43.009454+00	2026-06-11 17:04:59.163844+00	\N	NEW_MATCH	New Match: Frank Soro	You have been matched with Frank Soro for Full-Stack Web Development (92.0% compatibility).	f	\N	a097155f-18d3-401f-b023-a0e05b8a6753
ba43aafa-a611-433f-b271-346fef7e1c41	2026-06-10 14:04:43.009454+00	2026-06-10 14:25:39.957663+00	\N	MATCH_ACCEPTED	Match Accepted!	Frank Soro has accepted your Web Development Help request. Start your mentorship!	t	\N	a097155f-18d3-401f-b023-a0e05b8a6753
2991399f-3c89-4430-8fa7-fda69ac36e4a	2026-06-10 14:04:43.009454+00	2026-06-11 17:04:59.285445+00	\N	MATCH_ACCEPTED	Match Accepted!	Frank Soro has accepted your Web Development Help request. Start your mentorship!	t	\N	a097155f-18d3-401f-b023-a0e05b8a6753
677c42ab-0661-43a9-953c-a251a276be43	2026-06-10 11:04:43.009454+00	2026-06-10 14:25:40.079477+00	\N	NEW_MESSAGE	New message from Frank Soro	Frank sent you a message in your conversation.	t	\N	a097155f-18d3-401f-b023-a0e05b8a6753
70b0b0f1-d57c-44e7-a90e-80fe335aea36	2026-06-10 11:04:43.009454+00	2026-06-11 17:04:59.40661+00	\N	NEW_MESSAGE	New message from Frank Soro	Frank sent you a message in your conversation.	t	\N	a097155f-18d3-401f-b023-a0e05b8a6753
80ba0f4f-9d70-46c1-bbd4-09a45dfa2f04	2026-06-10 08:04:43.009454+00	2026-06-10 14:25:40.190476+00	\N	NEW_MATCH	New Mentee: Dave Traore	Dave Traore has been matched with you for Full-Stack Web Development (92.0% compatibility).	t	\N	e876f033-f143-4f4b-9adc-71642419144a
950c1728-2bb1-4252-95bb-f500c2b2b62c	2026-06-10 08:04:43.009454+00	2026-06-11 17:04:59.528742+00	\N	NEW_MATCH	New Mentee: Dave Traore	Dave Traore has been matched with you for Full-Stack Web Development (92.0% compatibility).	t	\N	e876f033-f143-4f4b-9adc-71642419144a
e780f2d4-a503-40fe-8c55-77ce3723bf5b	2026-06-10 05:04:43.009454+00	2026-06-10 14:25:40.323321+00	\N	NEW_MESSAGE	New message from Dave Traore	Dave sent you a message.	t	\N	e876f033-f143-4f4b-9adc-71642419144a
a01fad29-d9fd-4b9d-99bb-4257b6c4d268	2026-06-10 05:04:43.009454+00	2026-06-11 17:04:59.661255+00	\N	NEW_MESSAGE	New message from Dave Traore	Dave sent you a message.	t	\N	e876f033-f143-4f4b-9adc-71642419144a
7ae26afb-a560-410c-8691-fbae33d0cb4e	2026-06-10 02:04:43.009454+00	2026-06-10 14:25:40.467321+00	\N	MATCH_REJECTED	Match Rejected: Grace Koffi	Grace Koffi has rejected your Quantum Physics Mentorship offer.	t	\N	3e8bb4c1-0d5a-4bc5-bcd6-95598f4f7363
0cb8b069-26c2-4c21-8275-12082e12444f	2026-06-10 02:04:43.009454+00	2026-06-11 17:04:59.783719+00	\N	MATCH_REJECTED	Match Rejected: Grace Koffi	Grace Koffi has rejected your Quantum Physics Mentorship offer.	t	\N	3e8bb4c1-0d5a-4bc5-bcd6-95598f4f7363
7a45bd06-87fa-4655-934a-da65ba0e9a84	2026-06-09 23:04:43.009454+00	2026-06-10 14:25:40.599972+00	\N	NEW_MATCH	New Mentee: Grace Koffi	Grace Koffi has been matched with you for Cybersecurity 101 (65.0% compatibility).	t	\N	02d56625-7584-447e-8ad0-838c2beeaaf4
08a9a759-be55-4bb5-84a5-3221c031b5be	2026-06-09 20:04:43.009454+00	2026-06-10 14:25:40.710753+00	\N	NEW_MATCH	New Mentee: Iris Bamba	Iris Bamba has been matched with you for Data Science with Python (71.0% compatibility).	t	\N	d5626e1d-fd73-4d98-8086-552536eadf39
b1a00354-6bdf-4504-806b-e918dc7e9a7f	2026-06-09 17:04:43.009454+00	2026-06-10 14:25:40.832539+00	\N	NEW_MESSAGE	New message from Iris Bamba	Iris sent you a message.	t	\N	d5626e1d-fd73-4d98-8086-552536eadf39
9b5ab5af-e809-4eab-bc22-7cc112c24130	2026-06-09 14:04:43.009454+00	2026-06-10 14:25:40.954071+00	\N	NEW_MATCH	New Match: Henry Zadi	You have been matched with Henry Zadi for Cybersecurity 101 (65.0% compatibility).	t	\N	2e624d5c-4afa-475d-9083-9877614d6d06
9e142a59-692a-4f70-bb64-042d5ee7dfc2	2026-06-09 11:04:43.009454+00	2026-06-10 14:25:41.064445+00	\N	MATCH_REJECTED	Quantum Physics Match Rejected	Your match with Eve NGuessan for Quantum Physics Mentorship has been rejected.	t	\N	2e624d5c-4afa-475d-9083-9877614d6d06
3c27d9f3-c297-46fc-9f1d-2d9ce0d747a0	2026-06-09 08:04:43.009454+00	2026-06-10 14:25:41.175722+00	\N	NEW_MATCH	New Match: James Toure	You have been matched with James Toure for Data Science with Python (71.0% compatibility).	t	\N	717f97b9-6de0-4c33-8c5c-61c9abdebed4
02fdecf9-7755-4f30-9c75-79e631df9ef0	2026-06-09 05:04:43.009454+00	2026-06-10 14:25:41.286265+00	\N	NEW_MESSAGE	New message from James Toure	James sent you a message in your conversation.	t	\N	717f97b9-6de0-4c33-8c5c-61c9abdebed4
ad92bbd3-ac37-4f7f-823b-9a40eacdbebf	2026-06-11 17:24:18.632946+00	2026-06-11 17:24:18.632986+00	\N	NEW_MESSAGE	Nouveau message de AGO Alex	Ok je vois	t	{"sender_id": "cd9bd543-becf-4a12-b672-47bcd0d4c95e", "conversation_id": "73dec969-ad14-413e-9151-28dfdcad917c"}	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
ee2706db-539c-4b1b-a6b1-823a0da65041	2026-06-09 23:04:43.009454+00	2026-06-11 17:04:59.893757+00	\N	NEW_MATCH	New Mentee: Grace Koffi	Grace Koffi has been matched with you for Cybersecurity 101 (65.0% compatibility).	t	\N	02d56625-7584-447e-8ad0-838c2beeaaf4
0217f855-409f-4c5b-8d50-400aba9f2738	2026-06-11 18:17:45.077215+00	2026-06-11 18:17:45.077239+00	\N	NEW_MESSAGE	Nouveau message de Rodolf AGBO	je suis iteresser	f	{"sender_id": "db488050-f420-4024-830b-bc6b7507ac94", "conversation_id": "2d897011-eaba-4425-83e6-75fcc271a691"}	27517d56-3f32-4ff1-a77e-ec55d96f903a
99d29539-53b4-4dcf-aacb-902504e6b9ff	2026-06-09 20:04:43.009454+00	2026-06-11 17:05:00.01626+00	\N	NEW_MATCH	New Mentee: Iris Bamba	Iris Bamba has been matched with you for Data Science with Python (71.0% compatibility).	t	\N	d5626e1d-fd73-4d98-8086-552536eadf39
b459cb94-6e86-443e-92a4-35fa2e15e11c	2026-06-11 18:20:35.145395+00	2026-06-11 18:20:35.14543+00	\N	NEW_MESSAGE	Nouveau message de Rodolf AGBO	je suis interer	f	{"sender_id": "db488050-f420-4024-830b-bc6b7507ac94", "conversation_id": "324e5a64-6a9c-41ad-bfe6-f59182af1ebe"}	cd9bd543-becf-4a12-b672-47bcd0d4c95e
7d2a225c-98d8-42e2-9965-153bcd463929	2026-06-09 17:04:43.009454+00	2026-06-11 17:05:00.138299+00	\N	NEW_MESSAGE	New message from Iris Bamba	Iris sent you a message.	t	\N	d5626e1d-fd73-4d98-8086-552536eadf39
a7da25b2-b2ed-4d4c-8cc7-b2dc852b307f	2026-06-11 18:21:43.417491+00	2026-06-11 18:21:43.417517+00	\N	NEW_MESSAGE	Nouveau message de AGO Alex	ok vous est enregistrer	f	{"sender_id": "cd9bd543-becf-4a12-b672-47bcd0d4c95e", "conversation_id": "324e5a64-6a9c-41ad-bfe6-f59182af1ebe"}	db488050-f420-4024-830b-bc6b7507ac94
fe82ac65-719d-4296-8f59-d310b0606e9d	2026-06-09 14:04:43.009454+00	2026-06-11 17:05:00.248254+00	\N	NEW_MATCH	New Match: Henry Zadi	You have been matched with Henry Zadi for Cybersecurity 101 (65.0% compatibility).	t	\N	2e624d5c-4afa-475d-9083-9877614d6d06
02df4361-1ae6-4857-84b7-32e45b9d6b14	2026-06-11 18:25:02.940666+00	2026-06-11 18:25:02.940699+00	\N	NEW_MESSAGE	Nouveau message de Alice Konan	gjhjjhjjhjjhkj	f	{"sender_id": "4e8c1fcf-a156-44f2-bf16-9fa3b37d3977", "conversation_id": "c6adebb0-838a-4574-ae2b-332258d320db"}	3f1f157d-98f6-4907-8c7c-165e573a186a
85f7b7bf-cfc9-4263-8ff2-cf01bacee43f	2026-06-09 11:04:43.009454+00	2026-06-11 17:05:00.358913+00	\N	MATCH_REJECTED	Quantum Physics Match Rejected	Your match with Eve NGuessan for Quantum Physics Mentorship has been rejected.	t	\N	2e624d5c-4afa-475d-9083-9877614d6d06
9a66445a-6ad1-49d1-a253-f86b262a1360	2026-06-11 20:54:49.097843+00	2026-06-11 20:54:49.097867+00	\N	NEW_MESSAGE	Nouveau message de ggg hhhh	hdhhhdhd	f	{"sender_id": "0289dffa-d174-4241-95e2-a6e004cfa72c", "conversation_id": "8f45415d-edce-47ab-be91-1b325b5d763f"}	27517d56-3f32-4ff1-a77e-ec55d96f903a
4d023317-b89c-4fd5-b980-e3230073ba7a	2026-06-09 08:04:43.009454+00	2026-06-11 17:05:00.480516+00	\N	NEW_MATCH	New Match: James Toure	You have been matched with James Toure for Data Science with Python (71.0% compatibility).	t	\N	717f97b9-6de0-4c33-8c5c-61c9abdebed4
9c56a514-635c-41a9-b0dc-ba982faeb3ee	2026-06-11 20:55:31.970787+00	2026-06-11 20:55:31.970827+00	\N	NEW_MESSAGE	Nouveau message de ggg hhhh	je sui interece	f	{"sender_id": "0289dffa-d174-4241-95e2-a6e004cfa72c", "conversation_id": "4bc171e0-37ed-45de-a893-8fbc7e23fb9f"}	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
4d5faf57-65eb-4ecc-b06f-366bab72fd11	2026-06-09 05:04:43.009454+00	2026-06-11 17:05:00.613972+00	\N	NEW_MESSAGE	New message from James Toure	James sent you a message in your conversation.	t	\N	717f97b9-6de0-4c33-8c5c-61c9abdebed4
89d525da-3a93-46a7-aa39-b8dd2d9b335f	2026-06-11 20:57:55.95997+00	2026-06-11 20:57:55.959986+00	\N	NEW_MESSAGE	Nouveau message de Alice Konan	ok tu es enregistre	f	{"sender_id": "4e8c1fcf-a156-44f2-bf16-9fa3b37d3977", "conversation_id": "4bc171e0-37ed-45de-a893-8fbc7e23fb9f"}	0289dffa-d174-4241-95e2-a6e004cfa72c
55ff1b05-1edd-4dc5-ab19-5c94decda5a0	2026-06-11 20:58:13.054503+00	2026-06-11 20:58:13.05453+00	\N	NEW_MESSAGE	Nouveau message de ggg hhhh	ggg	f	{"sender_id": "0289dffa-d174-4241-95e2-a6e004cfa72c", "conversation_id": "4bc171e0-37ed-45de-a893-8fbc7e23fb9f"}	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.profiles (id, created_at, updated_at, deleted_at, profile_photo, department, academic_level, bio, user_id) FROM stdin;
e6fc12d2-364c-48b3-b630-6103216ca9a2	2026-06-11 17:07:40.830291+00	2026-06-11 17:07:40.830314+00	\N		Informatique	M1	Test bio	27517d56-3f32-4ff1-a77e-ec55d96f903a
6da8523a-b47c-4702-b967-6c64655652b8	2026-06-10 15:00:11.24873+00	2026-06-10 15:00:11.248758+00	\N		Génie Logiciel	Master 1	J'aime l'IA	cd9bd543-becf-4a12-b672-47bcd0d4c95e
fed01f0f-b793-46d1-8d8c-f316f8524c1b	2026-06-11 18:14:45.840153+00	2026-06-11 18:14:45.840187+00	\N		\N	\N	\N	db488050-f420-4024-830b-bc6b7507ac94
7755ace6-f06f-4970-98f1-9476fd504737	2026-06-11 20:53:27.050309+00	2026-06-11 20:53:27.050333+00	\N		\N	\N	\N	0289dffa-d174-4241-95e2-a6e004cfa72c
9ec37782-f01d-4322-b5a2-b00a5f83ad6e	2026-06-10 14:25:15.715541+00	2026-06-10 14:25:15.780743+00	\N		Informatique	L3	Looking to improve my programming skills. Interested in Python and web dev.	3f1f157d-98f6-4907-8c7c-165e573a186a
aa841022-0523-4f34-bed7-b6960d284da4	2026-06-10 14:25:16.578845+00	2026-06-10 14:25:16.821267+00	\N		Mathematiques	M1	Math tutor available for mentoring. Can help with statistics and physics too.	7d28b09c-b8fd-45bf-806d-ad82d4884774
757c574b-9719-4c7b-9e00-21a7ee1d4093	2026-06-10 14:25:17.730918+00	2026-06-10 14:25:17.795401+00	\N		Informatique	L2	Want to learn web development and Python. Motivated and curious.	a097155f-18d3-401f-b023-a0e05b8a6753
48969b1c-1316-4814-b05a-2fcb821d31a1	2026-06-10 14:25:18.516384+00	2026-06-10 14:25:18.570479+00	\N		Physique	M2	Physics researcher offering mentorship in quantum mechanics and ML.	3e8bb4c1-0d5a-4bc5-bcd6-95598f4f7363
bf8442cd-e57f-4394-bc9f-f711703cb479	2026-06-10 14:25:19.346441+00	2026-06-10 14:25:19.412105+00	\N		Informatique	M1	Full-stack developer with 3 years experience. Love React and TypeScript.	e876f033-f143-4f4b-9adc-71642419144a
181e73d9-825b-445a-9989-6c195b2c3054	2026-06-10 14:25:20.299028+00	2026-06-10 14:25:20.363917+00	\N		Informatique	L3	Beginner in programming. Want to learn Java and mobile development.	2e624d5c-4afa-475d-9083-9877614d6d06
ac24a8bd-3c25-4af6-b72b-1da9e004200e	2026-06-10 14:25:21.360966+00	2026-06-10 14:25:21.415412+00	\N		Reseaux	M2	Cybersecurity expert. Can mentor in networking, security, and DevOps.	02d56625-7584-447e-8ad0-838c2beeaaf4
c20a1276-4b3b-442c-a33f-03039f42eb8b	2026-06-10 14:25:22.292122+00	2026-06-10 14:25:22.345189+00	\N		Design	L3	UI/UX designer looking for mentorship in frontend development.	717f97b9-6de0-4c33-8c5c-61c9abdebed4
173ed165-b675-4ef2-b46b-693495010ef5	2026-06-10 14:25:23.266641+00	2026-06-10 14:25:23.341515+00	\N		Informatique	M1	Machine learning enthusiast. Can mentor in data science and AI.	d5626e1d-fd73-4d98-8086-552536eadf39
4e4e056e-ae17-4f9d-8869-ae8fb92a87d6	2026-06-10 17:09:13.87381+00	2026-06-10 17:09:13.873834+00	\N		Génie Logiciel	Master 1		c156fde9-c5db-49d6-bd58-2844fd4ef021
08ac6245-6b77-45f1-9893-a3c923dc507e	2026-06-10 14:25:14.843326+00	2026-06-10 14:25:14.906289+00	\N		Génie Logiciel	Master 1	Bio test via browser	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.reviews (id, created_at, updated_at, deleted_at, rating, content, session_type, match_id, reviewed_id, reviewer_id) FROM stdin;
\.


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.skills (id, name) FROM stdin;
add56c3c-ed20-4c27-8181-ac64c95a1082	Python
d7eaff80-e8e0-4018-bfa7-6c283adf0215	JavaScript
8cbbebd7-23ac-421c-866b-37397ab7167d	TypeScript
20ab197b-eafd-45e3-8645-e542963b790e	Java
7cfa7654-7f01-4274-9786-b685b1b4616a	C/C++
475ad59c-7375-47f1-89ae-62f7dcdfb31a	SQL
3809a851-2e12-481f-9e76-9518e8bced07	Algorithmics
82c260c9-584a-44d5-8b4b-dbb3eec8ccd0	Data Structures
8336be12-ac6d-4c05-b813-1577d0881f81	Mathematics
fc443974-d4c5-463b-b2d3-7ee994314f0a	Physics
30ab5b5e-e14b-48d3-87b4-3a7b40290a29	Machine Learning
76ceba85-8d8a-4cba-996c-84272fd61c3b	Deep Learning
48c05667-15b6-4fba-a316-db0e47706de5	Web Development
f0b34f65-1fdc-41f7-92ea-94d7739ad668	React
9f35d3cc-e693-430d-8724-6d1d081854d8	Mobile Development
89feba35-04e7-4b45-8066-0170a9b3d04e	Database Design
de722840-66c3-4f2a-9fa1-09cecfe1501b	Networking
d7dc5e56-ba3d-4b4f-b58f-13d24227d954	Cybersecurity
c0af0816-e957-4f64-8d5f-052141d1672e	UI/UX Design
3e426c90-9400-4387-b22b-afdfe499fbd2	DevOps
1e7e6270-5ad2-40a6-9dff-d776de212d92	Django
28446bed-6290-4ae1-870c-bbebf062dee4	Algorithmique
55299383-606b-4d62-b5d9-0eecc2775609	Kubernetes
3218a901-952b-46eb-bf8b-e7959dd9454f	AWS
\.


--
-- Data for Name: token_blacklist_blacklistedtoken; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.token_blacklist_blacklistedtoken (id, blacklisted_at, token_id) FROM stdin;
\.


--
-- Data for Name: token_blacklist_outstandingtoken; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.token_blacklist_outstandingtoken (id, token, created_at, expires_at, user_id, jti) FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5MDgwMSwiaWF0IjoxNzgxMDk4ODAxLCJqdGkiOiJiZmU5MmVkMTFlOWE0MDczYTAzOTNmYWE3N2FlYTI0NSIsInVzZXJfaWQiOiI1OGFmZTAzMS1hMWQzLTQxZWEtODE0Zi0xNmFlMzkzMzMzNDgifQ.w-ZGB2B6tqlvYoAChdDiwjYaPdFv0J2DfTEyrOHZJjQ	2026-06-10 13:40:01.830359+00	2026-07-10 13:40:01+00	\N	bfe92ed11e9a4073a0393faa77aea245
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5MzcxNywiaWF0IjoxNzgxMTAxNzE3LCJqdGkiOiIwOWVlMGYyYWVkOTk0MDk4YjQ0YjM4YTAwM2ZkOGI1YiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.SQGoQUQDMbxzQ_5M7tCA4fhpzaoOnRpjkPHBy86cUws	2026-06-10 14:28:37.434537+00	2026-07-10 14:28:37+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	09ee0f2aed994098b44b38a003fd8b5b
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5Mzc4NiwiaWF0IjoxNzgxMTAxNzg2LCJqdGkiOiI1NzFjY2I2YTc3NGE0MjVlYWRlZGQwZmQ4ZTI5NjcyYyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.TgB9Fb23x92ZxKLqBquOusDylu62SMSLHRp1mEW_62Q	2026-06-10 14:29:46.037081+00	2026-07-10 14:29:46+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	571ccb6a774a425eadedd0fd8e29672c
4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5MzgwNiwiaWF0IjoxNzgxMTAxODA2LCJqdGkiOiJkOWE1MjVhMDc2ZTY0MzhhYjBlMmEwMGI4ZjU4OGM3ZiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.y5iV_X5Win3-ACfg0uGSbHhsysrqwKSrdrEj9L4rqs4	2026-06-10 14:30:06.597146+00	2026-07-10 14:30:06+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	d9a525a076e6438ab0e2a00b8f588c7f
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5NDg3NiwiaWF0IjoxNzgxMTAyODc2LCJqdGkiOiJiMWEwYWM1M2ZjOTU0MzJiYThkZTRjM2Y4NzhlM2YwMSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.grGnGdGtGMm6vw_ywIW1aEiT3RiaV0JD-kId-OSSzG4	2026-06-10 14:47:56.456153+00	2026-07-10 14:47:56+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	b1a0ac53fc95432ba8de4c3f878e3f01
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5NTYwOCwiaWF0IjoxNzgxMTAzNjA4LCJqdGkiOiJhZjRjMTkzMmNmOTQ0NzIzOTBlOTY0MzY4MzExYzM1MyIsInVzZXJfaWQiOiJjZDliZDU0My1iZWNmLTRhMTItYjY3Mi00N2JjZDBkNGM5NWUifQ.0pBlS4j_AjycoGAWPSMYl2qQaMUK20PLeXnHxvmgnFA	2026-06-10 15:00:08.126778+00	2026-07-10 15:00:08+00	cd9bd543-becf-4a12-b672-47bcd0d4c95e	af4c1932cf94472390e964368311c353
7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5NjAyNiwiaWF0IjoxNzgxMTA0MDI2LCJqdGkiOiJlYjhhY2UwZTFkYWE0YzdlOTQzZmI3ZTc5OGRiYjdiNyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.rLHZy44goE0kE5Et8vyyjABl_eJYM3gwoTdtrOSQbHo	2026-06-10 15:07:06.627372+00	2026-07-10 15:07:06+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	eb8ace0e1daa4c7e943fb7e798dbb7b7
8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5NjA1MCwiaWF0IjoxNzgxMTA0MDUwLCJqdGkiOiI0NGQ4MmI0ZWJlYmU0OWFhODExMGNiZjI5YWMyYmYyMyIsInVzZXJfaWQiOiJjZDliZDU0My1iZWNmLTRhMTItYjY3Mi00N2JjZDBkNGM5NWUifQ.Hx5ywkt4PubOicaW-y54B3Smcsk8K9LVZ2QNpZBKWlA	2026-06-10 15:07:30.399563+00	2026-07-10 15:07:30+00	cd9bd543-becf-4a12-b672-47bcd0d4c95e	44d82b4ebebe49aa8110cbf29ac2bf23
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5NjgwMSwiaWF0IjoxNzgxMTA0ODAxLCJqdGkiOiJkNmNjZWRlMzk0ZWU0OGM2YTdhM2Q5ZTAyZWY3NjMzNiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.9Yaa-YaIAsL91l9s0KqDxLlqcqhIK7kVPqSoydfS9jo	2026-06-10 15:20:01.137501+00	2026-07-10 15:20:01+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	d6ccede394ee48c6a7a3d9e02ef76336
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5Njg3MywiaWF0IjoxNzgxMTA0ODczLCJqdGkiOiI1ODc4N2NkNzY5NDU0M2RkOWEzYTQwZWEwMWI1MDhiOSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.IVLdrVFajAkyOGYxD9nYyx_rdV-sdpFc7QuYGVCJWbA	2026-06-10 15:21:13.595848+00	2026-07-10 15:21:13+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	58787cd7694543dd9a3a40ea01b508b9
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5NzE1NSwiaWF0IjoxNzgxMTA1MTU1LCJqdGkiOiJkM2Y1NDM3YjhmMTU0ZGM0YTY2MDY2MTJjZGE3NjYyZCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.FrOlCNpjD2k60hOjsbkluQGhyamj_9CDzboI1EGQR7s	2026-06-10 15:25:55.832105+00	2026-07-10 15:25:55+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	d3f5437b8f154dc4a6606612cda7662d
12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5NzI1OCwiaWF0IjoxNzgxMTA1MjU4LCJqdGkiOiI0NmM4ZDc3YWIzODA0ODRkOTViZTAxZmRjYWYyODZkNiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.9sPlpQmtJIXaa99uUVwzMR0Eg0gufVn8SvZHY3LQSmg	2026-06-10 15:27:38.932199+00	2026-07-10 15:27:38+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	46c8d77ab380484d95be01fdcaf286d6
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5NzQ0NCwiaWF0IjoxNzgxMTA1NDQ0LCJqdGkiOiIyY2YyOTU0MjMxOGM0NGNhYTYyZTRjMjc2NmM2YmQ4YSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.lWGgRucPlRgLCBHSTEk58KAhkLYm5xPSXh80UsBAtPk	2026-06-10 15:30:44.513099+00	2026-07-10 15:30:44+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	2cf29542318c44caa62e4c2766c6bd8a
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5NzcyNywiaWF0IjoxNzgxMTA1NzI3LCJqdGkiOiJkMWY0NmViZjI0NWY0Yjk2YTQ1OGRiOWYzYzUxNmRlNCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.sPOiSJSgeHwFaz6P72FsxPSASaKd9mz1mebKDDIsGSY	2026-06-10 15:35:27.374982+00	2026-07-10 15:35:27+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	d1f46ebf245f4b96a458db9f3c516de4
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5Nzg5MSwiaWF0IjoxNzgxMTA1ODkxLCJqdGkiOiI2NWY1MWVmNTc2MGU0MTQ2ODEzMjc2M2UwNTk2MjcwNiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.uDHKCTdSUfqhI--KHENSvrxfazifKIB3fkpMlbwd5RY	2026-06-10 15:38:11.032774+00	2026-07-10 15:38:11+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	65f51ef5760e41468132763e05962706
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5NzkyNSwiaWF0IjoxNzgxMTA1OTI1LCJqdGkiOiJjOTZkMzJhZmU4YTA0MzFiYjhmZDkyNmM4YjE5OTBmMyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.cFoL3jW47BmBGD9vX-lUmU3Nc0IXivvzOu6SLjfhOrg	2026-06-10 15:38:45.508027+00	2026-07-10 15:38:45+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	c96d32afe8a0431bb8fd926c8b1990f3
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5Nzk0OSwiaWF0IjoxNzgxMTA1OTQ5LCJqdGkiOiJlY2Y4YTQwOWY1ZTU0MTYwYmIzMzMyYTc0OTk5ZTA0NCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.KVr8VQ2QcDtMdZkhh9Mh3TJ22PyRvd7f6MNzuHW2Edg	2026-06-10 15:39:09.880543+00	2026-07-10 15:39:09+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	ecf8a409f5e54160bb3332a74999e044
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5ODA5MCwiaWF0IjoxNzgxMTA2MDkwLCJqdGkiOiI5ZmJlOWNjOTRhNGQ0OTJlOTY2YTY0NjYwNmY2YTJmNCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.sI2Pxv6HQ293dzSHq7M6fWujI-_Qkrft93Ap_KHNOI4	2026-06-10 15:41:30.119385+00	2026-07-10 15:41:30+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	9fbe9cc94a4d492e966a646606f6a2f4
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5ODE3MSwiaWF0IjoxNzgxMTA2MTcxLCJqdGkiOiJkZWNkNGE1NGQzNDk0ZGRjYjgzYjlkOWRjNjhlM2RiZSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.LSvulmCWQ8KTshmoml4wbvAVuUc24Gp4i41aKdBNeCY	2026-06-10 15:42:51.348653+00	2026-07-10 15:42:51+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	decd4a54d3494ddcb83b9d9dc68e3dbe
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5ODMwOCwiaWF0IjoxNzgxMTA2MzA4LCJqdGkiOiJjYTQ2YTM0NTczZWM0MDQ4ODFiMTQ1ODFmZTk4ODk3MiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.paSDCjRITrOwaD1qnKV9RhiMDDtiLCxS6KSwXxnwilE	2026-06-10 15:45:08.215748+00	2026-07-10 15:45:08+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	ca46a34573ec404881b14581fe988972
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5ODgxMiwiaWF0IjoxNzgxMTA2ODEyLCJqdGkiOiI3ZmFkMTc5YWJhMjg0MzNiYmQ5ZWJkMzJlYjljNWEzYyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.Vmk5mt9fUDm7b_CIoIxLL4YuUIks1o3htkmnFy86Yjs	2026-06-10 15:53:32.759215+00	2026-07-10 15:53:32+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	7fad179aba28433bbd9ebd32eb9c5a3c
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5ODg0MSwiaWF0IjoxNzgxMTA2ODQxLCJqdGkiOiI2YzJmYmU5YmM5ODA0ZTk5YjkxNDE2ODA5OTFmMDE0NiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.aIN-OiwncXlJn87Nh8IqD2_ahtcdqjDm_woPfgJUz9M	2026-06-10 15:54:01.350193+00	2026-07-10 15:54:01+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	6c2fbe9bc9804e99b9141680991f0146
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5ODg4MywiaWF0IjoxNzgxMTA2ODgzLCJqdGkiOiI5MjkxMWZjNjMyMTU0M2NlYjEzZGQxNGNiZjgyZDg1NSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.qR6Zg9eoFq7RiB4_mHbEkGNXuh-0aU88HNiwjnYA_ig	2026-06-10 15:54:43.647533+00	2026-07-10 15:54:43+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	92911fc6321543ceb13dd14cbf82d855
24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTAxMSwiaWF0IjoxNzgxMTA3MDExLCJqdGkiOiI0YWMwOTBlMTk0NjA0NmI2YTQ1NzI0MDAxNDgwMjQzNCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.hL40TrMv1i2O0pQVWXD231j_62pHgKIBLF5XzDp7aEc	2026-06-10 15:56:51.866684+00	2026-07-10 15:56:51+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	4ac090e1946046b6a457240014802434
25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTAxMSwiaWF0IjoxNzgxMTA3MDExLCJqdGkiOiJiNmFjOTFjMDYzN2U0ZjJkOWYxMWMzMzBjMGVkYzRlMyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.Ov4bUpGXwPwR6PDsQ6P-PosPnuETDPJg3gbZtWcTerc	2026-06-10 15:56:51.890873+00	2026-07-10 15:56:51+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	b6ac91c0637e4f2d9f11c330c0edc4e3
26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTQ0OSwiaWF0IjoxNzgxMTA3NDQ5LCJqdGkiOiJjNzVlOGNjZTkwNjQ0ODk2YWU4Njc4NTkwMjkyNjdmNCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.rJBjrGhvkB4XBy_DnCDPGG7x3CQ0AXm5e7Y32NLFVK4	2026-06-10 16:04:09.970709+00	2026-07-10 16:04:09+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	c75e8cce90644896ae867859029267f4
27	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTUzOCwiaWF0IjoxNzgxMTA3NTM4LCJqdGkiOiJjNzNkMTE2OTg1ODY0ZGY5YmM3NGMxODliZThjNDcxZSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.bFGK87H3hFgsgnZjPUbYQgTQMQHfEqLPwqt3xLUsvys	2026-06-10 16:05:38.622497+00	2026-07-10 16:05:38+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	c73d116985864df9bc74c189be8c471e
28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTU3MSwiaWF0IjoxNzgxMTA3NTcxLCJqdGkiOiI5ZjNjYjlhMzFlMmY0OWQ3OWJlNTBmZWJmM2I0NDQ1NiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.7YPuZIeQtD67ivXVPgLGD4WXrKw8c1KvJxLbjuoeG_A	2026-06-10 16:06:11.078754+00	2026-07-10 16:06:11+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	9f3cb9a31e2f49d79be50febf3b44456
29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTY3MywiaWF0IjoxNzgxMTA3NjczLCJqdGkiOiJlOGQ4Y2ZlMGJjOTc0MzdhODE0MzY0Y2VjM2MzZTNkMiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.0XdgB566EDC1F2gJyQTMSCtTptvAi4Y4w00VZ4uWfAQ	2026-06-10 16:07:53.775757+00	2026-07-10 16:07:53+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	e8d8cfe0bc97437a814364cec3c3e3d2
30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTY3MywiaWF0IjoxNzgxMTA3NjczLCJqdGkiOiI1OTEwYTI2YWZmZTA0M2FlODdkM2ZlMDQzNWY3N2YzMSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.Ls36oQKB1A87LYlmvD0HoXl0KSL08wobDCnFl1aAAgI	2026-06-10 16:07:53.833498+00	2026-07-10 16:07:53+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	5910a26affe043ae87d3fe0435f77f31
31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTY3NywiaWF0IjoxNzgxMTA3Njc3LCJqdGkiOiIxZWNmNjJiNTllYWE0ZDU1YTM4MzM2ZGIwYmE5YzY4ZiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.g57wVpxf6HNhvL1NbrTAleUZb86THxqUY7GkYa_5CnI	2026-06-10 16:07:57.047243+00	2026-07-10 16:07:57+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	1ecf62b59eaa4d55a38336db0ba9c68f
32	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTcxMCwiaWF0IjoxNzgxMTA3NzEwLCJqdGkiOiIzYjI4NzI0M2FiZDk0NzA1OTMzMjIzNjNiNWUzYzZkNCIsInVzZXJfaWQiOiIzZjFmMTU3ZC05OGY2LTQ5MDctOGM3Yy0xNjVlNTczYTE4NmEifQ.FxWctiWUr84ZMKxeIGLTbf-hSLFGGDaLurh4mUGJIoc	2026-06-10 16:08:30.747099+00	2026-07-10 16:08:30+00	3f1f157d-98f6-4907-8c7c-165e573a186a	3b287243abd9470593322363b5e3c6d4
33	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTg2NywiaWF0IjoxNzgxMTA3ODY3LCJqdGkiOiI1MjFhODgzYmVjYzQ0MmIxODQ0ODM5MjYwZDdlYTc4NCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.LJqGBz8iuzXA0dagyBYagyr1OkOD6rtECrIQSCtS-sc	2026-06-10 16:11:07.043585+00	2026-07-10 16:11:07+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	521a883becc442b1844839260d7ea784
34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzY5OTg4NywiaWF0IjoxNzgxMTA3ODg3LCJqdGkiOiIxMWM2ZTY5ZmJmODA0YmMyOWUwM2VkODkwOTRlZGJhOSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.3tFm74ooUzdgYsX5aXfg7UWtIg_Zy3x0bElx4pAzsxI	2026-06-10 16:11:27.048256+00	2026-07-10 16:11:27+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	11c6e69fbf804bc29e03ed89094edba9
35	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDI2OSwiaWF0IjoxNzgxMTA4MjY5LCJqdGkiOiI0OGNjMjVlNWI3YjQ0MmQwYTgzMDJiYTVhMWQ0NGRjZCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.fuBRx2b-mu3a8hQYvKy4tvHqC--sGxwvrg0Q6q9brBs	2026-06-10 16:17:49.846001+00	2026-07-10 16:17:49+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	48cc25e5b7b442d0a8302ba5a1d44dcd
36	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDUxNywiaWF0IjoxNzgxMTA4NTE3LCJqdGkiOiJmNjFkMjdkMjQwZDI0NTI3YjJlODllYTExZmEzOWVkNiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.S-L_Jg9_rdPNCnZb7KJ826k9xFdT95YIt0pLqHbOygE	2026-06-10 16:21:57.994702+00	2026-07-10 16:21:57+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	f61d27d240d24527b2e89ea11fa39ed6
37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDU1MywiaWF0IjoxNzgxMTA4NTUzLCJqdGkiOiJjMjFmZjhkOTZkYTY0ZGE4YTMzNjI1NmFjNGQxOGYzNyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.oK4Es7lf1ZwdbVGhwNRy00a_P-RmH8Ay3NW0Ch1jkvQ	2026-06-10 16:22:33.654683+00	2026-07-10 16:22:33+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	c21ff8d96da64da8a336256ac4d18f37
38	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDYxMCwiaWF0IjoxNzgxMTA4NjEwLCJqdGkiOiJjM2ZjZWUzNWZhZTc0NzVmYThhZjUzYjE4MzI1OTQzNiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.ngFIHo0gNnC1LgjjORgjg59H01OHKYxROjS3olWFSkg	2026-06-10 16:23:30.255532+00	2026-07-10 16:23:30+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	c3fcee35fae7475fa8af53b183259436
39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDY1MSwiaWF0IjoxNzgxMTA4NjUxLCJqdGkiOiIzMWIwYmNhN2ZlNTU0MmQ3OGY0MzA1NmE1YTQ5YTBhMyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.uZvORtGbsGSyoG3N2iWtR9QgEFN7fcVPXMpuRTBa_KI	2026-06-10 16:24:11.643281+00	2026-07-10 16:24:11+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	31b0bca7fe5542d78f43056a5a49a0a3
40	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDY1MiwiaWF0IjoxNzgxMTA4NjUyLCJqdGkiOiIzNDkxZDI4MWUzN2I0NGQ2YjFjMzY4MTdlMmIwNDc5NSIsInVzZXJfaWQiOiIzZjFmMTU3ZC05OGY2LTQ5MDctOGM3Yy0xNjVlNTczYTE4NmEifQ.yksuQODNzhLg--ICion2_Ll1Uh9Th77sWvIQk13ZTmA	2026-06-10 16:24:12.438939+00	2026-07-10 16:24:12+00	3f1f157d-98f6-4907-8c7c-165e573a186a	3491d281e37b44d6b1c36817e2b04795
41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDY4OSwiaWF0IjoxNzgxMTA4Njg5LCJqdGkiOiI1MzljOTU3MzQyMzQ0ZjliOTNhNDAxNTAxNjliNjQ2OCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.Rs9MWEr8dLT8ZKJ7NesUtuE-T6pvjYY4fzz3XNUhA7g	2026-06-10 16:24:49.421299+00	2026-07-10 16:24:49+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	539c957342344f9b93a40150169b6468
42	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDY5MCwiaWF0IjoxNzgxMTA4NjkwLCJqdGkiOiI5YmQ5ZDM4NmIyODQ0ZTAzOTRjNjAyMmZlMGU5MzY2ZiIsInVzZXJfaWQiOiIzZjFmMTU3ZC05OGY2LTQ5MDctOGM3Yy0xNjVlNTczYTE4NmEifQ.0rPYVxdDXzjk3eAfXWR2vod8foUZQY0GNHMR3_FMXmI	2026-06-10 16:24:50.138832+00	2026-07-10 16:24:50+00	3f1f157d-98f6-4907-8c7c-165e573a186a	9bd9d386b2844e0394c6022fe0e9366f
43	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDY5OSwiaWF0IjoxNzgxMTA4Njk5LCJqdGkiOiI3NWY4NmY3OTIwOTU0Y2RmYjQ2MDkzMWU4NWNjZGZlMCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.jFqEsPtek1fw0Ja876GvD978_DmA2iDWlFsccdn85fc	2026-06-10 16:24:59.573676+00	2026-07-10 16:24:59+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	75f86f7920954cdfb460931e85ccdfe0
44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDcyMywiaWF0IjoxNzgxMTA4NzIzLCJqdGkiOiIwNDhmNzk3ZGRlZTI0NGE0YTIzMTM5Y2JmYjA3ODdiMyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.LXpjUwa_PB3gcrAd42YduelIgZ9HgLKvYhhIMkeXnFY	2026-06-10 16:25:23.376347+00	2026-07-10 16:25:23+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	048f797ddee244a4a23139cbfb0787b3
45	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDc1NSwiaWF0IjoxNzgxMTA4NzU1LCJqdGkiOiIxZjdmODI4Mjk1ZmI0OTY0OGNiYzYzZDNlNTczNzQ1ZSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.JIDQJz92t5NhAQuv8QEaywYzM00WPkx75XcSROY6224	2026-06-10 16:25:55.778244+00	2026-07-10 16:25:55+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	1f7f828295fb49648cbc63d3e573745e
46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDkxMCwiaWF0IjoxNzgxMTA4OTEwLCJqdGkiOiJlZDI0MzEwNTljMzc0YWJmYWY3MjZjMmFiMmZjNDhlZiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.wS3dz0UkHXL9XcyUQ3dRe3tbac4aPAszlh4m6Q5_96k	2026-06-10 16:28:30.109407+00	2026-07-10 16:28:30+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	ed2431059c374abfaf726c2ab2fc48ef
47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDkxMCwiaWF0IjoxNzgxMTA4OTEwLCJqdGkiOiI0MTk0ZGQ2Yjg4ZWE0N2ZjOWJhY2EzZGIzOWQ4ODI3NSIsInVzZXJfaWQiOiIzZjFmMTU3ZC05OGY2LTQ5MDctOGM3Yy0xNjVlNTczYTE4NmEifQ.D4UYI2ruGzD5h2WGqteq_E0OvMrBDxCzj4FeaOc9m_c	2026-06-10 16:28:30.975436+00	2026-07-10 16:28:30+00	3f1f157d-98f6-4907-8c7c-165e573a186a	4194dd6b88ea47fc9baca3db39d88275
48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMDk1MCwiaWF0IjoxNzgxMTA4OTUwLCJqdGkiOiJiMTFjMjE5NDMyMzU0ZThhODc0ZjNjMzNjZDU4YWRlYyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.fhjnJ4TSkd-c8dcj3Qp_4YZasgu3RPCyRz7ZQKnd3NA	2026-06-10 16:29:10.0409+00	2026-07-10 16:29:10+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	b11c219432354e8a874f3c33cd58adec
49	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMTA3OCwiaWF0IjoxNzgxMTA5MDc4LCJqdGkiOiJiMjE1YzdjZGQ0ZDQ0YmM2YjY4ZDQzODI5YjM1MjUzNSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.QNf0tR-bHpJqqTWEMyAb1lIxYTF_HNFS2vUii1nwlhs	2026-06-10 16:31:18.908484+00	2026-07-10 16:31:18+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	b215c7cdd4d44bc6b68d43829b352535
50	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMTA3OSwiaWF0IjoxNzgxMTA5MDc5LCJqdGkiOiJlOTE4OWRlMGZiNjY0MTU2YjY0NzYzMTYwMTc0N2QzNCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.sEGwr5ckSPA96ATrv23ZsOTgrdZwYPh9g5ymH4Q-e7s	2026-06-10 16:31:19.015516+00	2026-07-10 16:31:19+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	e9189de0fb664156b647631601747d34
51	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMTA3OSwiaWF0IjoxNzgxMTA5MDc5LCJqdGkiOiI4ODcyMjg2YTAzYTI0YWYxYjY2ODg3ODQ5MDk2NzFlZiIsInVzZXJfaWQiOiIzZjFmMTU3ZC05OGY2LTQ5MDctOGM3Yy0xNjVlNTczYTE4NmEifQ.2LqHMSd3ut4UtY3cWlCnrfRnIcxgg4yP61FnaApzwRU	2026-06-10 16:31:19.92392+00	2026-07-10 16:31:19+00	3f1f157d-98f6-4907-8c7c-165e573a186a	8872286a03a24af1b6688784909671ef
52	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMTE2MCwiaWF0IjoxNzgxMTA5MTYwLCJqdGkiOiIyNGE4M2QwN2RmNTI0NGEwODMyMmEyM2RlYjJlM2MyMCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.KTRw_JHRLtvuRI0MLN_5kmPR1Yp0ZT8Yx96xscPs73w	2026-06-10 16:32:40.268241+00	2026-07-10 16:32:40+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	24a83d07df5244a08322a23deb2e3c20
53	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMTM2MSwiaWF0IjoxNzgxMTA5MzYxLCJqdGkiOiIwYjY3Mjk2ZjdlOTI0YzdjOTVhYTIwOTJlNTk5MWNkMiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.ytnDxll-r6SczhFrvcw1U62ncD_ysLE9b-cxzTD3P9w	2026-06-10 16:36:01.049704+00	2026-07-10 16:36:01+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	0b67296f7e924c7c95aa2092e5991cd2
54	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMTU0NCwiaWF0IjoxNzgxMTA5NTQ0LCJqdGkiOiI0ZTU5NTVlMzEyOWI0MjM1ODQzZjYzMTI3MGI0NzlkOSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.d2wMvlEssIgd_McgcsSmcvPE_yJRver8FtYXN-N0F8I	2026-06-10 16:39:04.950601+00	2026-07-10 16:39:04+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	4e5955e3129b4235843f631270b479d9
55	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMTYzNCwiaWF0IjoxNzgxMTA5NjM0LCJqdGkiOiI4ODkwNzg3MjhhNWQ0ZDFlODM2ZDgzMzM2YzBkMzAyNCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.1ILEYaAb-fsqX1z6ZspAES7_bHrI2eDS9aozcYU91j4	2026-06-10 16:40:34.542566+00	2026-07-10 16:40:34+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	889078728a5d4d1e836d83336c0d3024
56	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMzMzMSwiaWF0IjoxNzgxMTExMzMxLCJqdGkiOiI2MDU0NjcyMDZhYjM0YTI3YmM5ODA5YTgzYzhlM2VkNiIsInVzZXJfaWQiOiJjMTU2ZmRlOS1jNWRiLTQ5ZDYtYmQ1OC0yODQ0ZmQ0ZWYwMjEifQ.XnQ_-e5QGgeo9zGFWls3PEdp89SmccGxsxQevnN8Cgk	2026-06-10 17:08:51.443154+00	2026-07-10 17:08:51+00	c156fde9-c5db-49d6-bd58-2844fd4ef021	605467206ab34a27bc9809a83c8e3ed6
57	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwMzM1MiwiaWF0IjoxNzgxMTExMzUyLCJqdGkiOiI2ZGY5MmY4Yjk1OTM0YWRjYmYzODM0ZjMwZGRkYjMxMSIsInVzZXJfaWQiOiJjMTU2ZmRlOS1jNWRiLTQ5ZDYtYmQ1OC0yODQ0ZmQ0ZWYwMjEifQ.VTjxvdHbZEexwdmDMfj3NFectgYRszzSHUFnCuQm3I0	2026-06-10 17:09:12.662457+00	2026-07-10 17:09:12+00	c156fde9-c5db-49d6-bd58-2844fd4ef021	6df92f8b95934adcbf3834f30dddb311
58	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwNDExMywiaWF0IjoxNzgxMTEyMTEzLCJqdGkiOiIyMjYyNWVmYzRhNDQ0ZmY4OWI5ZmQ1N2JiMTU1OWYxMiIsInVzZXJfaWQiOiJjZDliZDU0My1iZWNmLTRhMTItYjY3Mi00N2JjZDBkNGM5NWUifQ.N8JjMoJu0apUov7_M_c-ic7XHrEy39rKTrOabRsWwbs	2026-06-10 17:21:53.077193+00	2026-07-10 17:21:53+00	cd9bd543-becf-4a12-b672-47bcd0d4c95e	22625efc4a444ff89b9fd57bb1559f12
59	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwNDI2MSwiaWF0IjoxNzgxMTEyMjYxLCJqdGkiOiJkM2MxOWViNDAyM2Y0ZDFkOWM5YzY2MGM2YmY3Yzc4ZSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.CwM4kx71GRP5imikE213e-w_vaPfupeQaYGu-Q-83K0	2026-06-10 17:24:21.90937+00	2026-07-10 17:24:21+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	d3c19eb4023f4d1d9c9c660c6bf7c78e
60	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwNDQxMSwiaWF0IjoxNzgxMTEyNDExLCJqdGkiOiIwMTM1ODlkYzJjODA0OTI4ODUwM2RjOWNhYmM5YjE5YiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.ZW4ZSKWCIzmLk4vLJmMn4hs__WYVGA5SoWwnJ3J33X8	2026-06-10 17:26:51.701719+00	2026-07-10 17:26:51+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	013589dc2c8049288503dc9cabc9b19b
61	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwNjQ4OCwiaWF0IjoxNzgxMTE0NDg4LCJqdGkiOiI4ZmRiOGZhNWY2Y2Q0MjgxYTM4NDU3ZDE3M2QwMDk3ZiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.HidBXrT-zwN99bXNCEY0voNZFBmoygRwiTt9PjVgYp8	2026-06-10 18:01:28.75856+00	2026-07-10 18:01:28+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	8fdb8fa5f6cd4281a38457d173d0097f
62	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzcwNjU3NCwiaWF0IjoxNzgxMTE0NTc0LCJqdGkiOiI1NDc3YTdhYzBkODU0YjIxYjhlODZlNTkwMGI1ZTAzNyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.LIa_q_EQxcEyBgZIUHvznskeFXpzvedRPQgTUOkwtn4	2026-06-10 18:02:54.228877+00	2026-07-10 18:02:54+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	5477a7ac0d854b21b8e86e5900b5e037
63	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4MzQ1NywiaWF0IjoxNzgxMTkxNDU3LCJqdGkiOiJkZmNmMmU5MjZjZjM0MWYyOWM5NmVjMzg2MTk1MDFkNCIsInVzZXJfaWQiOiJjZDliZDU0My1iZWNmLTRhMTItYjY3Mi00N2JjZDBkNGM5NWUifQ.k_JJPFWNN4azlepTVKqLXdodjve11lVnNPJzALACW9A	2026-06-11 15:24:17.330784+00	2026-07-11 15:24:17+00	cd9bd543-becf-4a12-b672-47bcd0d4c95e	dfcf2e926cf341f29c96ec38619501d4
64	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4MzU2NywiaWF0IjoxNzgxMTkxNTY3LCJqdGkiOiI3NGNlODkxNTI1NTc0YmY3YjVjYTY1NTNiNmRjMDJkNSIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.dF9uN-R8WGVQJX8Dq69GmpTWavUiHiZBM8XLQMtBw1I	2026-06-11 15:26:07.909805+00	2026-07-11 15:26:07+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	74ce891525574bf7b5ca6553b6dc02d5
65	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4NDc3MCwiaWF0IjoxNzgxMTkyNzcwLCJqdGkiOiJjNzZiNWZkMTA2Mzg0ZWI4YjhlMjI4NTBlZDlkYTQ0OSIsInVzZXJfaWQiOiJjZDliZDU0My1iZWNmLTRhMTItYjY3Mi00N2JjZDBkNGM5NWUifQ.qK8T5q8FM7A-XY4RWfGLSssAoSMo02GvpTO0IaV-zI8	2026-06-11 15:46:10.789499+00	2026-07-11 15:46:10+00	cd9bd543-becf-4a12-b672-47bcd0d4c95e	c76b5fd106384eb8b8e22850ed9da449
66	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4NTMzMCwiaWF0IjoxNzgxMTkzMzMwLCJqdGkiOiJjMTRlNzUyNDZjZmQ0MzJiODEwMzQxYjgxYWNiYTkxNCIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.XHmKw0oS351jPX8N_r8asiquab44wZYB3CunZI_ALZI	2026-06-11 15:55:30.834538+00	2026-07-11 15:55:30+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	c14e75246cfd432b810341b81acba914
67	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4OTYxNSwiaWF0IjoxNzgxMTk3NjE1LCJqdGkiOiJjZTM0YzUwNDczMjg0NGFhYjM0OWM5MDhjMDI0YWVjMyIsInVzZXJfaWQiOiIyNzUxN2Q1Ni0zZjMyLTRmZjEtYTc3ZS1lYzU1ZDk2ZjkwM2EifQ.fGqu952jGgawJV51SgsOfuL2trs5cTIoZDYn87SpNXk	2026-06-11 17:06:55.926532+00	2026-07-11 17:06:55+00	27517d56-3f32-4ff1-a77e-ec55d96f903a	ce34c504732844aab349c908c024aec3
68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4OTYzMywiaWF0IjoxNzgxMTk3NjMzLCJqdGkiOiI4OGY5M2Q1OWQxNmE0OGVlYjdlZGM5Yjc5ZjU0NjJlNSIsInVzZXJfaWQiOiIyNzUxN2Q1Ni0zZjMyLTRmZjEtYTc3ZS1lYzU1ZDk2ZjkwM2EifQ.LfIDqEnnYHA_mDN09aC-yKMxcRw0FFP17pdIJ35dFb4	2026-06-11 17:07:13.401243+00	2026-07-11 17:07:13+00	27517d56-3f32-4ff1-a77e-ec55d96f903a	88f93d59d16a48eeb7edc9b79f5462e5
69	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4OTY2MCwiaWF0IjoxNzgxMTk3NjYwLCJqdGkiOiIzMjIzYmIxY2Q2NGY0MzBmYTRlZDc0MGE4OTUxNzIxMiIsInVzZXJfaWQiOiIyNzUxN2Q1Ni0zZjMyLTRmZjEtYTc3ZS1lYzU1ZDk2ZjkwM2EifQ.3QiODX6EYNPvndAnKiSTjqEjCFSNj0b71byL6_pF4pQ	2026-06-11 17:07:40.671234+00	2026-07-11 17:07:40+00	27517d56-3f32-4ff1-a77e-ec55d96f903a	3223bb1cd64f430fa4ed740a89517212
70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4OTY3OCwiaWF0IjoxNzgxMTk3Njc4LCJqdGkiOiJiMTkzMWEyNTM1OGU0MDY2YTViOTJiZWNmZjNhOGQ4MSIsInVzZXJfaWQiOiIyNzUxN2Q1Ni0zZjMyLTRmZjEtYTc3ZS1lYzU1ZDk2ZjkwM2EifQ.5VFfCLEfu5XXj-4BhsYbIBH58c2JzMsYo3d-dYAxIY0	2026-06-11 17:07:58.633759+00	2026-07-11 17:07:58+00	27517d56-3f32-4ff1-a77e-ec55d96f903a	b1931a25358e4066a5b92becff3a8d81
71	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4OTg0OSwiaWF0IjoxNzgxMTk3ODQ5LCJqdGkiOiIwNDcyMjU0Yzg4OTc0NWNkOWQ1MGNhYjI3N2I0ZjcwZSIsInVzZXJfaWQiOiIyNzUxN2Q1Ni0zZjMyLTRmZjEtYTc3ZS1lYzU1ZDk2ZjkwM2EifQ.bVxjqPsFKs1iR2wxe6IoZ7-ih_XhUn-bOix0jws8MVE	2026-06-11 17:10:49.798942+00	2026-07-11 17:10:49+00	27517d56-3f32-4ff1-a77e-ec55d96f903a	0472254c889745cd9d50cab277b4f70e
72	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4OTg5MSwiaWF0IjoxNzgxMTk3ODkxLCJqdGkiOiJlZDJjOGUxYmMzNjA0YjIxODlhZGM2MDBkN2M0YTAwYiIsInVzZXJfaWQiOiIyNzUxN2Q1Ni0zZjMyLTRmZjEtYTc3ZS1lYzU1ZDk2ZjkwM2EifQ.0TvcB3jKN_rgVMscWLeCh6dh_nUDqp4R53VPWrKSDgU	2026-06-11 17:11:31.181482+00	2026-07-11 17:11:31+00	27517d56-3f32-4ff1-a77e-ec55d96f903a	ed2c8e1bc3604b2189adc600d7c4a00b
73	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc4OTkxNCwiaWF0IjoxNzgxMTk3OTE0LCJqdGkiOiI0ZGRiZDI4ZTBkM2U0Zjc4ODJjYTRlMjg2ODFkNjgwNiIsInVzZXJfaWQiOiIyNzUxN2Q1Ni0zZjMyLTRmZjEtYTc3ZS1lYzU1ZDk2ZjkwM2EifQ.e60NRW-ICimy3ZqWdY0xNSK0tytyctfEkF1Zc4TxR8M	2026-06-11 17:11:54.658616+00	2026-07-11 17:11:54+00	27517d56-3f32-4ff1-a77e-ec55d96f903a	4ddbd28e0d3e4f7882ca4e28681d6806
74	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc5MDQ0MSwiaWF0IjoxNzgxMTk4NDQxLCJqdGkiOiJkYWM3MTQxMWI4MzY0OGRiYjM1MjdiNWExMTEyOWRmNSIsInVzZXJfaWQiOiIyNzUxN2Q1Ni0zZjMyLTRmZjEtYTc3ZS1lYzU1ZDk2ZjkwM2EifQ.hqlCnKI64sbJPZr9WEDoT2Qykfde9Qwmhu3IKd_zvA8	2026-06-11 17:20:41.235337+00	2026-07-11 17:20:41+00	27517d56-3f32-4ff1-a77e-ec55d96f903a	dac71411b83648dbb3527b5a11129df5
75	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc5MzY4MywiaWF0IjoxNzgxMjAxNjgzLCJqdGkiOiI0ZWY5MjY3NjMyOWI0MzQyOTgxOTU2MDBlYzk1Mzc1NiIsInVzZXJfaWQiOiJkYjQ4ODA1MC1mNDIwLTQwMjQtODMwYi1iYzZiNzUwN2FjOTQifQ.MEUB1F4WAN63h7HPMU3xUO-EIeLYRvPBOPWHtBoYe90	2026-06-11 18:14:43.226384+00	2026-07-11 18:14:43+00	db488050-f420-4024-830b-bc6b7507ac94	4ef92676329b434298195600ec953756
76	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc5NDI1OSwiaWF0IjoxNzgxMjAyMjU5LCJqdGkiOiI2Yjc2ZWM1NTE5MzM0YjIwODkyOWE3MTNiY2I4YzcxZiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.EuL3RsO6QBeUAjRdKX3v9gr_s92ZyAWsAyvOkGuEt_A	2026-06-11 18:24:19.232987+00	2026-07-11 18:24:19+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	6b76ec5519334b208929a713bcb8c71f
77	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzc5ODAyMCwiaWF0IjoxNzgxMjA2MDIwLCJqdGkiOiI2ZjdhZjljMmU1MTc0ZTU5OTI3NjAxNjQ5ODMxNzJiNyIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.aCLXu7Hq2S4SxXEp-4fv4n8urzsTGc7XOUAHuDqMNAk	2026-06-11 19:27:00.0436+00	2026-07-11 19:27:00+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	6f7af9c2e5174e5992760164983172b7
78	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzgwMzIwMiwiaWF0IjoxNzgxMjExMjAyLCJqdGkiOiJkZTQ3ZjIzYTk3Yzg0ODg3OWM2MmUwM2JkYTVhNzEyMiIsInVzZXJfaWQiOiIwMjg5ZGZmYS1kMTc0LTQyNDEtOTVlMi1hNmUwMDRjZmE3MmMifQ.EfvCNZUmpDyNEULy3uOlhm79Nd110BKko_-xnGPkijE	2026-06-11 20:53:22.360246+00	2026-07-11 20:53:22+00	0289dffa-d174-4241-95e2-a6e004cfa72c	de47f23a97c848879c62e03bda5a7122
79	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4MzgwMzQ0NSwiaWF0IjoxNzgxMjExNDQ1LCJqdGkiOiIxNGExM2U0ODM5MzA0MDhhYTEwYTE3NWRjNDA2NjI5MiIsInVzZXJfaWQiOiI0ZThjMWZjZi1hMTU2LTQ0ZjItYmYxNi05ZmEzYjM3ZDM5NzcifQ.NdVz8QwTG9eP2pxjnd6o7RGBhBL6wxCFqL1Kis_ZSLk	2026-06-11 20:57:25.392674+00	2026-07-11 20:57:25+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	14a13e483930408aa10a175dc4066292
112	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzg4Mzk4MSwiaWF0IjoxNzgxMjkxOTgxLCJqdGkiOiIyMTgxNGYyMTIyNmU0N2Y5YmQ3YWRjMTcyMjkyNmJiNyIsInVzZXJfaWQiOiJjZDliZDU0My1iZWNmLTRhMTItYjY3Mi00N2JjZDBkNGM5NWUifQ.fQfyCWAjaB3Rkmpz-ZIlV9lgBACssvxMxqP0vyHo82A	2026-06-12 19:19:41.752162+00	2026-07-12 19:19:41+00	cd9bd543-becf-4a12-b672-47bcd0d4c95e	21814f21226e47f9bd7adc1722926bb7
145	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4Mzk0NjY5OCwiaWF0IjoxNzgxMzU0Njk4LCJqdGkiOiI5OWY4YWZhOGFhZDA0MDNkYTQ5ZWI3MjMyMGVkNTdkYyIsInVzZXJfaWQiOiJjZDliZDU0My1iZWNmLTRhMTItYjY3Mi00N2JjZDBkNGM5NWUifQ.yA0upS6wN7s-T-sU4EKitoep0OKDoh1XtQ81-WRrYHQ	2026-06-13 12:44:58.704156+00	2026-07-13 12:44:58+00	cd9bd543-becf-4a12-b672-47bcd0d4c95e	99f8afa8aad0403da49eb72320ed57dc
\.


--
-- Data for Name: user_skills; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.user_skills (id, created_at, updated_at, deleted_at, type, profile_id, skill_id) FROM stdin;
5d9163ee-0de1-4426-acf9-39e5215697fc	2026-06-10 17:41:50.416874+00	2026-06-10 17:41:50.416997+00	\N	STRENGTH	08ac6245-6b77-45f1-9893-a3c923dc507e	add56c3c-ed20-4c27-8181-ac64c95a1082
21bbb51e-397e-4d64-9c2f-4aea5fa6071d	2026-06-10 17:41:50.514224+00	2026-06-10 17:41:50.514242+00	\N	STRENGTH	08ac6245-6b77-45f1-9893-a3c923dc507e	1e7e6270-5ad2-40a6-9dff-d776de212d92
ac9c4272-f7f9-4bc4-bf18-2e535dfd3d37	2026-06-10 17:41:50.571374+00	2026-06-10 17:41:50.571395+00	\N	WEAKNESS	08ac6245-6b77-45f1-9893-a3c923dc507e	55299383-606b-4d62-b5d9-0eecc2775609
251597f9-59f9-468b-a18f-bb2a771570eb	2026-06-11 17:04:50.060513+00	2026-06-11 17:04:50.060546+00	\N	STRENGTH	08ac6245-6b77-45f1-9893-a3c923dc507e	20ab197b-eafd-45e3-8645-e542963b790e
9782cebe-a62c-43b3-9843-91c017f3df7d	2026-06-11 17:04:50.220381+00	2026-06-11 17:04:50.2204+00	\N	STRENGTH	08ac6245-6b77-45f1-9893-a3c923dc507e	48c05667-15b6-4fba-a316-db0e47706de5
18343c67-cb7f-453e-805d-b92e8d87b81d	2026-06-11 17:04:50.289747+00	2026-06-11 17:04:50.289946+00	\N	STRENGTH	08ac6245-6b77-45f1-9893-a3c923dc507e	89feba35-04e7-4b45-8066-0170a9b3d04e
748f3e59-42e7-4859-947d-76687071d927	2026-06-11 17:04:50.35519+00	2026-06-11 17:04:50.355227+00	\N	WEAKNESS	08ac6245-6b77-45f1-9893-a3c923dc507e	3809a851-2e12-481f-9e76-9518e8bced07
8e835903-edf5-4c10-bdb6-0a4342becd64	2026-06-11 17:04:50.421783+00	2026-06-11 17:04:50.421804+00	\N	WEAKNESS	08ac6245-6b77-45f1-9893-a3c923dc507e	30ab5b5e-e14b-48d3-87b4-3a7b40290a29
bf596286-fffd-46b9-a21b-4557feaf862d	2026-06-11 17:07:41.09048+00	2026-06-11 17:07:41.090499+00	\N	STRENGTH	e6fc12d2-364c-48b3-b630-6103216ca9a2	add56c3c-ed20-4c27-8181-ac64c95a1082
6ea5775f-9c8e-4ded-9103-04411e93117b	2026-06-11 17:07:41.151712+00	2026-06-11 17:07:41.151738+00	\N	STRENGTH	e6fc12d2-364c-48b3-b630-6103216ca9a2	d7eaff80-e8e0-4018-bfa7-6c283adf0215
b1975f30-c67b-4cb3-bfcc-9f3b1af952b1	2026-06-11 17:07:41.20974+00	2026-06-11 17:07:41.20977+00	\N	WEAKNESS	e6fc12d2-364c-48b3-b630-6103216ca9a2	30ab5b5e-e14b-48d3-87b4-3a7b40290a29
27c42d9c-8038-4323-bddb-1e744d72117d	2026-06-10 14:25:23.821139+00	2026-06-10 14:25:23.821163+00	\N	STRENGTH	9ec37782-f01d-4322-b5a2-b00a5f83ad6e	d7eaff80-e8e0-4018-bfa7-6c283adf0215
c12ae3ff-10f8-4f22-a976-d3c53af6d063	2026-06-10 14:25:23.874681+00	2026-06-10 14:25:23.874702+00	\N	WEAKNESS	9ec37782-f01d-4322-b5a2-b00a5f83ad6e	add56c3c-ed20-4c27-8181-ac64c95a1082
31e9365f-8771-415f-8a16-ade11d42d3b9	2026-06-10 14:25:23.940946+00	2026-06-10 14:25:23.940965+00	\N	WEAKNESS	9ec37782-f01d-4322-b5a2-b00a5f83ad6e	48c05667-15b6-4fba-a316-db0e47706de5
22a79d6b-831e-43b1-85f2-a77889279af9	2026-06-10 14:25:24.008402+00	2026-06-10 14:25:24.008426+00	\N	WEAKNESS	9ec37782-f01d-4322-b5a2-b00a5f83ad6e	82c260c9-584a-44d5-8b4b-dbb3eec8ccd0
51a97827-9886-4e1f-bfd6-4b7aeff64fe3	2026-06-10 14:25:24.075535+00	2026-06-10 14:25:24.075557+00	\N	STRENGTH	aa841022-0523-4f34-bed7-b6960d284da4	8336be12-ac6d-4c05-b813-1577d0881f81
af8b2e8a-8225-4516-88c2-32526a541614	2026-06-10 14:25:24.142366+00	2026-06-10 14:25:24.142401+00	\N	STRENGTH	aa841022-0523-4f34-bed7-b6960d284da4	fc443974-d4c5-463b-b2d3-7ee994314f0a
31b3b664-edad-437d-b55c-7efc66de8675	2026-06-10 14:25:24.219715+00	2026-06-10 14:25:24.21975+00	\N	STRENGTH	aa841022-0523-4f34-bed7-b6960d284da4	82c260c9-584a-44d5-8b4b-dbb3eec8ccd0
4108b5f5-8b69-4934-8b67-22b49457a362	2026-06-10 14:25:24.277178+00	2026-06-10 14:25:24.277225+00	\N	STRENGTH	aa841022-0523-4f34-bed7-b6960d284da4	3809a851-2e12-481f-9e76-9518e8bced07
b5e045bd-fdea-49aa-8d2b-2815590a1cc9	2026-06-10 14:25:24.344179+00	2026-06-10 14:25:24.344213+00	\N	WEAKNESS	757c574b-9719-4c7b-9e00-21a7ee1d4093	add56c3c-ed20-4c27-8181-ac64c95a1082
303f9277-88e4-4c1b-a026-869b3e03b73a	2026-06-10 14:25:24.442045+00	2026-06-10 14:25:24.442082+00	\N	WEAKNESS	757c574b-9719-4c7b-9e00-21a7ee1d4093	48c05667-15b6-4fba-a316-db0e47706de5
ae67637e-d0af-4b5d-be33-24c78e04a682	2026-06-10 14:25:24.518556+00	2026-06-10 14:25:24.518592+00	\N	WEAKNESS	757c574b-9719-4c7b-9e00-21a7ee1d4093	89feba35-04e7-4b45-8066-0170a9b3d04e
328558c1-3205-4822-9adf-488975dba8c7	2026-06-10 14:25:24.572299+00	2026-06-10 14:25:24.572312+00	\N	WEAKNESS	757c574b-9719-4c7b-9e00-21a7ee1d4093	d7eaff80-e8e0-4018-bfa7-6c283adf0215
b7e34c1e-6aec-4298-8cdf-3b835ff9b750	2026-06-10 14:25:24.653691+00	2026-06-10 14:25:24.653742+00	\N	STRENGTH	48969b1c-1316-4814-b05a-2fcb821d31a1	fc443974-d4c5-463b-b2d3-7ee994314f0a
a53da908-6a42-4b01-8b1a-e31a90e949e0	2026-06-10 14:25:24.728842+00	2026-06-10 14:25:24.72888+00	\N	STRENGTH	48969b1c-1316-4814-b05a-2fcb821d31a1	8336be12-ac6d-4c05-b813-1577d0881f81
82141609-a512-4f6d-a664-973d96843e44	2026-06-10 14:25:24.785059+00	2026-06-10 14:25:24.785109+00	\N	STRENGTH	48969b1c-1316-4814-b05a-2fcb821d31a1	30ab5b5e-e14b-48d3-87b4-3a7b40290a29
88f42a53-1e70-4be7-9797-f350443b6c9c	2026-06-10 14:25:24.838788+00	2026-06-10 14:25:24.838818+00	\N	STRENGTH	48969b1c-1316-4814-b05a-2fcb821d31a1	76ceba85-8d8a-4cba-996c-84272fd61c3b
ec37a543-b39a-4883-8950-1042a85a161e	2026-06-10 14:25:24.906282+00	2026-06-10 14:25:24.906318+00	\N	WEAKNESS	48969b1c-1316-4814-b05a-2fcb821d31a1	add56c3c-ed20-4c27-8181-ac64c95a1082
9dc3c8e8-39f3-4df7-959c-bcaac4e5939d	2026-06-10 14:25:24.974883+00	2026-06-10 14:25:24.974917+00	\N	STRENGTH	bf8442cd-e57f-4394-bc9f-f711703cb479	d7eaff80-e8e0-4018-bfa7-6c283adf0215
bce7e843-5bce-4393-9d75-e0d41b3d84f8	2026-06-10 14:25:25.060914+00	2026-06-10 14:25:25.060951+00	\N	STRENGTH	bf8442cd-e57f-4394-bc9f-f711703cb479	8cbbebd7-23ac-421c-866b-37397ab7167d
f774e103-ab20-405b-9768-acf6c93d5270	2026-06-10 14:25:25.116323+00	2026-06-10 14:25:25.11636+00	\N	STRENGTH	bf8442cd-e57f-4394-bc9f-f711703cb479	f0b34f65-1fdc-41f7-92ea-94d7739ad668
31f6cb7f-44d2-430c-92de-6d495c3ade83	2026-06-10 14:25:25.182047+00	2026-06-10 14:25:25.182078+00	\N	STRENGTH	bf8442cd-e57f-4394-bc9f-f711703cb479	48c05667-15b6-4fba-a316-db0e47706de5
62f5ed6f-0ced-484e-a5cb-cd133c702f08	2026-06-10 14:25:25.249199+00	2026-06-10 14:25:25.249233+00	\N	STRENGTH	bf8442cd-e57f-4394-bc9f-f711703cb479	add56c3c-ed20-4c27-8181-ac64c95a1082
e07135a5-5499-4393-8fa4-d439ab72cc4f	2026-06-10 14:25:25.326309+00	2026-06-10 14:25:25.326351+00	\N	WEAKNESS	bf8442cd-e57f-4394-bc9f-f711703cb479	3e426c90-9400-4387-b22b-afdfe499fbd2
6ebd7ca5-d660-4ce1-a6c4-80ff8d7e913b	2026-06-10 14:25:25.395506+00	2026-06-10 14:25:25.395542+00	\N	WEAKNESS	181e73d9-825b-445a-9989-6c195b2c3054	20ab197b-eafd-45e3-8645-e542963b790e
06bc05a2-82f0-45d3-ace1-739aaf208960	2026-06-10 14:25:25.460086+00	2026-06-10 14:25:25.460102+00	\N	WEAKNESS	181e73d9-825b-445a-9989-6c195b2c3054	9f35d3cc-e693-430d-8724-6d1d081854d8
d1c9ae7f-b971-4db0-98fb-d2ae17d442dc	2026-06-10 14:25:25.524987+00	2026-06-10 14:25:25.525043+00	\N	WEAKNESS	181e73d9-825b-445a-9989-6c195b2c3054	add56c3c-ed20-4c27-8181-ac64c95a1082
cbb0f49b-7873-46dd-8e1f-c653248d1fd8	2026-06-10 14:25:25.593084+00	2026-06-10 14:25:25.593121+00	\N	WEAKNESS	181e73d9-825b-445a-9989-6c195b2c3054	48c05667-15b6-4fba-a316-db0e47706de5
a0b1ca4d-dd0c-4856-ba5a-daa68c20818a	2026-06-10 14:25:25.646999+00	2026-06-10 14:25:25.647039+00	\N	STRENGTH	ac24a8bd-3c25-4af6-b72b-1da9e004200e	de722840-66c3-4f2a-9fa1-09cecfe1501b
344c3406-80c6-4b11-963a-5b231cdda969	2026-06-10 14:25:25.712289+00	2026-06-10 14:25:25.71231+00	\N	STRENGTH	ac24a8bd-3c25-4af6-b72b-1da9e004200e	d7dc5e56-ba3d-4b4f-b58f-13d24227d954
6d692f22-ecf9-4310-ad6c-b3e8749756e6	2026-06-10 14:25:25.778868+00	2026-06-10 14:25:25.778895+00	\N	STRENGTH	ac24a8bd-3c25-4af6-b72b-1da9e004200e	3e426c90-9400-4387-b22b-afdfe499fbd2
9aec21eb-392a-4cd3-8ef0-907d886bfd28	2026-06-10 14:25:25.846161+00	2026-06-10 14:25:25.84619+00	\N	STRENGTH	ac24a8bd-3c25-4af6-b72b-1da9e004200e	7cfa7654-7f01-4274-9786-b685b1b4616a
77227f5c-44bb-4370-a31a-829a4f051f2d	2026-06-10 14:25:25.911178+00	2026-06-10 14:25:25.911193+00	\N	WEAKNESS	ac24a8bd-3c25-4af6-b72b-1da9e004200e	30ab5b5e-e14b-48d3-87b4-3a7b40290a29
52e74889-9f23-4533-a8a4-952c3dca56e2	2026-06-10 14:25:25.979532+00	2026-06-10 14:25:25.979565+00	\N	STRENGTH	c20a1276-4b3b-442c-a33f-03039f42eb8b	c0af0816-e957-4f64-8d5f-052141d1672e
52dcfd0f-12f1-444a-96fd-f745c306f0d5	2026-06-10 14:25:26.044186+00	2026-06-10 14:25:26.044207+00	\N	STRENGTH	c20a1276-4b3b-442c-a33f-03039f42eb8b	48c05667-15b6-4fba-a316-db0e47706de5
aea8bbbe-e0b3-496b-b05c-123ddf334daf	2026-06-10 14:25:26.110875+00	2026-06-10 14:25:26.110898+00	\N	STRENGTH	c20a1276-4b3b-442c-a33f-03039f42eb8b	d7eaff80-e8e0-4018-bfa7-6c283adf0215
e16794e4-de60-4543-805c-f8687411f7f1	2026-06-10 14:25:26.176405+00	2026-06-10 14:25:26.17642+00	\N	WEAKNESS	c20a1276-4b3b-442c-a33f-03039f42eb8b	f0b34f65-1fdc-41f7-92ea-94d7739ad668
f5ba3883-37ad-4985-8fef-0cb61bc7a5c4	2026-06-10 14:25:26.24397+00	2026-06-10 14:25:26.243991+00	\N	WEAKNESS	c20a1276-4b3b-442c-a33f-03039f42eb8b	add56c3c-ed20-4c27-8181-ac64c95a1082
2b801f6e-c73f-4439-b077-8987cdc9624f	2026-06-10 14:25:26.324642+00	2026-06-10 14:25:26.324673+00	\N	STRENGTH	173ed165-b675-4ef2-b46b-693495010ef5	add56c3c-ed20-4c27-8181-ac64c95a1082
2221e542-a77a-4669-996d-f7141b3332ef	2026-06-10 14:25:26.433796+00	2026-06-10 14:25:26.43384+00	\N	STRENGTH	173ed165-b675-4ef2-b46b-693495010ef5	30ab5b5e-e14b-48d3-87b4-3a7b40290a29
2d040ca8-c395-4eb4-b334-d93e995caad5	2026-06-10 14:25:26.498117+00	2026-06-10 14:25:26.498135+00	\N	STRENGTH	173ed165-b675-4ef2-b46b-693495010ef5	76ceba85-8d8a-4cba-996c-84272fd61c3b
72e07639-188c-4ff4-be9b-e52a55c2f58b	2026-06-10 14:25:26.754814+00	2026-06-10 14:25:26.754849+00	\N	STRENGTH	173ed165-b675-4ef2-b46b-693495010ef5	8336be12-ac6d-4c05-b813-1577d0881f81
cc9580c1-9f9d-4069-8cda-fb15d0430615	2026-06-10 14:25:26.962858+00	2026-06-10 14:25:26.962873+00	\N	STRENGTH	173ed165-b675-4ef2-b46b-693495010ef5	82c260c9-584a-44d5-8b4b-dbb3eec8ccd0
e8e18452-ca56-496b-9f64-e04df8d0271d	2026-06-10 14:25:27.074723+00	2026-06-10 14:25:27.074761+00	\N	WEAKNESS	173ed165-b675-4ef2-b46b-693495010ef5	48c05667-15b6-4fba-a316-db0e47706de5
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.users (password, last_login, is_superuser, first_name, last_name, is_staff, is_active, date_joined, id, email, phone, is_verified, created_at, updated_at) FROM stdin;
pbkdf2_sha256$870000$ayroh0sFpynYbfkoydyl5C$SGfIhrG3l9H664YzNH8Axk0Co6rfBc1k6+Auhtg0OQ8=	2026-06-10 12:40:14.366078+00	t			t	t	2026-06-10 12:28:46.795582+00	cef5d0be-9064-4305-9468-bd3900d374a1	admin@mentorlink.com	\N	f	2026-06-10 12:28:47.447212+00	2026-06-10 12:28:47.447225+00
pbkdf2_sha256$870000$nqcZaKwnM0vKXpKn743xbi$SRVqID7LHcrRqI7ObY7KisbbTe58Amfg1cQqWBYllYo=	\N	f	Rodolf	AGBO	f	t	2026-06-11 18:14:40.889625+00	db488050-f420-4024-830b-bc6b7507ac94	rodoll@gmail.com	\N	f	2026-06-11 18:14:40.890516+00	2026-06-11 18:14:40.890533+00
pbkdf2_sha256$870000$WqelNJUKTRh5LIi5PbfFSb$vlMnJRr1fy1riDAckbyz8Qt0DaCFIotQe3yiJXBEj3g=	\N	f	ggg	hhhh	f	t	2026-06-11 20:53:20.319678+00	0289dffa-d174-4241-95e2-a6e004cfa72c	ggg@gmail.com	45555555	f	2026-06-11 20:53:20.320146+00	2026-06-11 20:53:20.320156+00
pbkdf2_sha256$870000$NFX7vYDdKjDwOk5isrlWqG$7WmJt+AJap5O2gJNrSBt1g+q9tk1Ylhb8eJCNT/AdT8=	\N	f	Bob	Kouassi	f	t	2026-06-10 14:25:15.647349+00	3f1f157d-98f6-4907-8c7c-165e573a186a	bob@example.com	+22501010102	t	2026-06-10 14:25:15.647572+00	2026-06-10 14:25:15.64758+00
pbkdf2_sha256$870000$L2GVEsPQqaD0vdpA81mY8v$CJTU7G2FrI4zOOTECQSF0KgffRVsDTfu3ItVzVH06bc=	\N	f	Carol	Diallo	f	t	2026-06-10 14:25:16.490665+00	7d28b09c-b8fd-45bf-806d-ad82d4884774	carol@example.com	+22501010103	t	2026-06-10 14:25:16.490915+00	2026-06-10 14:25:16.490923+00
pbkdf2_sha256$870000$sHx5oEAohrcVMvze5TPt42$Xi1ueXoqdhYusKEun19+Vc+nvV2t4Jp77CeTYWox2Yw=	\N	f	Dave	Traore	f	t	2026-06-10 14:25:17.664043+00	a097155f-18d3-401f-b023-a0e05b8a6753	dave@example.com	+22501010104	t	2026-06-10 14:25:17.66424+00	2026-06-10 14:25:17.664247+00
pbkdf2_sha256$870000$IeMgt0mOPpUeru8xEP3BEq$RvkS8A5fpioI8M+1eTTfTCo5+ukSypJfP9R5vQMD8gk=	\N	f	Eve	NGuessan	f	t	2026-06-10 14:25:18.462834+00	3e8bb4c1-0d5a-4bc5-bcd6-95598f4f7363	eve@example.com	+22501010105	t	2026-06-10 14:25:18.463061+00	2026-06-10 14:25:18.463068+00
pbkdf2_sha256$870000$9yaeADJ0mi0V5hD7Ho71Ex$mdYbLvg3n33JhRXYfN+PwcweNFt+qSAfwgN7XKVwVRA=	\N	f	Frank	Soro	f	t	2026-06-10 14:25:19.266886+00	e876f033-f143-4f4b-9adc-71642419144a	frank@example.com	+22501010106	t	2026-06-10 14:25:19.267116+00	2026-06-10 14:25:19.267123+00
pbkdf2_sha256$870000$g5KSFVpVZLHfltPeAWtceM$WsVbXwqNn9+u2hmVUOUrvWc55x3NmV5xM2uAMHomzBU=	\N	f	Grace	Koffi	f	t	2026-06-10 14:25:20.238848+00	2e624d5c-4afa-475d-9083-9877614d6d06	grace@example.com	+22501010107	t	2026-06-10 14:25:20.239187+00	2026-06-10 14:25:20.239198+00
pbkdf2_sha256$870000$RBfnT5rZ4zcsubb0NG0Qle$GBmdpkgzn506d+tJkISo8d+N5NQZUO6Q38ZJ6p3HcWU=	\N	f	Henry	Zadi	f	t	2026-06-10 14:25:21.301309+00	02d56625-7584-447e-8ad0-838c2beeaaf4	henry@example.com	+22501010108	t	2026-06-10 14:25:21.301488+00	2026-06-10 14:25:21.301495+00
pbkdf2_sha256$870000$DlnNk9dVtdMubmT3LumHb0$9+2j7VlBEbrwtmcQuXhO0CZGyHoon7Kvce6OEjiBuO0=	\N	f	Iris	Bamba	f	t	2026-06-10 14:25:22.171193+00	717f97b9-6de0-4c33-8c5c-61c9abdebed4	iris@example.com	+22501010109	t	2026-06-10 14:25:22.171427+00	2026-06-10 14:25:22.171436+00
pbkdf2_sha256$870000$YnLzKKArvmo2ONiPAcx5Iu$Hh4VJxGwDo0uKyhJ12ST+5ReoHJ6ei0m4JeKfsfYahI=	\N	f	James	Toure	f	t	2026-06-10 14:25:23.198815+00	d5626e1d-fd73-4d98-8086-552536eadf39	james@example.com	+22501010110	t	2026-06-10 14:25:23.199053+00	2026-06-10 14:25:23.199062+00
pbkdf2_sha256$870000$TqWDWmszFyIIZQYaZp9BYc$dw3k5XE9p1vCg0oW21ma0DPX/xJxqyk3/L2Mxm3pQjM=	\N	f	Test	User	f	t	2026-06-10 17:08:48.802126+00	c156fde9-c5db-49d6-bd58-2844fd4ef021	browser-test@example.com	\N	f	2026-06-10 17:08:48.8073+00	2026-06-10 17:08:48.807322+00
pbkdf2_sha256$870000$71uQZkl5WoH1pbTnVkmUqY$qQhRA9lat49L2bMen7daRyiIA5/2wlWZWpERE6hnq0g=	\N	f	Alice	Konan	f	t	2026-06-10 14:25:14.735505+00	4e8c1fcf-a156-44f2-bf16-9fa3b37d3977	alice@example.com	+22501010101	t	2026-06-10 14:25:14.736017+00	2026-06-11 15:25:45.619209+00
pbkdf2_sha256$870000$otJZHRS56FQjD4b3bnunLn$dQAFrs4BKHkPcQVeUrjtc9CD2JJ4/xNlNE9jywLUtT0=	\N	f	Test	User	f	t	2026-06-11 17:06:55.564396+00	27517d56-3f32-4ff1-a77e-ec55d96f903a	test@test.com	\N	f	2026-06-11 17:06:55.564752+00	2026-06-11 17:06:55.564762+00
pbkdf2_sha256$870000$MLPCdzRIy53CohAPAmILob$F/5DrF53++2yjr62wXs0zIyueTmXbtO27suKIxu+Wlo=	\N	f	AGO	Alex	f	t	2026-06-10 15:00:05.896682+00	cd9bd543-becf-4a12-b672-47bcd0d4c95e	alexyessougnonago@gmail.com	0153088468	f	2026-06-10 15:00:05.897568+00	2026-06-10 15:00:05.897578+00
\.


--
-- Data for Name: users_groups; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.users_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: users_user_permissions; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.users_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: verification_documents; Type: TABLE DATA; Schema: public; Owner: mentorlink
--

COPY public.verification_documents (id, file, status, rejection_reason, reviewed_by_id, created_at, updated_at, user_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mentorlink
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mentorlink
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mentorlink
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 80, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mentorlink
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mentorlink
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 20, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mentorlink
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 38, true);


--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mentorlink
--

SELECT pg_catalog.setval('public.token_blacklist_blacklistedtoken_id_seq', 1, false);


--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mentorlink
--

SELECT pg_catalog.setval('public.token_blacklist_outstandingtoken_id_seq', 145, true);


--
-- Name: users_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mentorlink
--

SELECT pg_catalog.setval('public.users_groups_id_seq', 1, false);


--
-- Name: users_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mentorlink
--

SELECT pg_catalog.setval('public.users_user_permissions_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: availability_slots availability_slots_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.availability_slots
    ADD CONSTRAINT availability_slots_pkey PRIMARY KEY (id);


--
-- Name: conversation_members conversation_members_conversation_id_user_id_f14fcbc6_uniq; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.conversation_members
    ADD CONSTRAINT conversation_members_conversation_id_user_id_f14fcbc6_uniq UNIQUE (conversation_id, user_id);


--
-- Name: conversation_members conversation_members_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.conversation_members
    ADD CONSTRAINT conversation_members_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: mentorship_posts mentorship_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.mentorship_posts
    ADD CONSTRAINT mentorship_posts_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_key UNIQUE (user_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: skills skills_name_key; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_name_key UNIQUE (name);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_key; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_key UNIQUE (token_id);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq UNIQUE (jti);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_pkey PRIMARY KEY (id);


--
-- Name: user_skills user_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_pkey PRIMARY KEY (id);


--
-- Name: user_skills user_skills_profile_id_skill_id_632d0408_uniq; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_profile_id_skill_id_632d0408_uniq UNIQUE (profile_id, skill_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_groups users_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT users_groups_pkey PRIMARY KEY (id);


--
-- Name: users_groups users_groups_user_id_group_id_fc7788e8_uniq; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT users_groups_user_id_group_id_fc7788e8_uniq UNIQUE (user_id, group_id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_user_permissions users_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users_user_permissions
    ADD CONSTRAINT users_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_permissions users_user_permissions_user_id_permission_id_3b86cbdf_uniq; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users_user_permissions
    ADD CONSTRAINT users_user_permissions_user_id_permission_id_3b86cbdf_uniq UNIQUE (user_id, permission_id);


--
-- Name: verification_documents verification_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.verification_documents
    ADD CONSTRAINT verification_documents_pkey PRIMARY KEY (id);


--
-- Name: verification_documents verification_documents_user_id_key; Type: CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.verification_documents
    ADD CONSTRAINT verification_documents_user_id_key UNIQUE (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: availability_slots_profile_id_0c5edf97; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX availability_slots_profile_id_0c5edf97 ON public.availability_slots USING btree (profile_id);


--
-- Name: conversation_members_conversation_id_570068ad; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX conversation_members_conversation_id_570068ad ON public.conversation_members USING btree (conversation_id);


--
-- Name: conversation_members_user_id_3bfe90c8; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX conversation_members_user_id_3bfe90c8 ON public.conversation_members USING btree (user_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: matches_compati_0bce3a_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX matches_compati_0bce3a_idx ON public.matches USING btree (compatibility_score);


--
-- Name: matches_mentee__3d25ef_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX matches_mentee__3d25ef_idx ON public.matches USING btree (mentee_id, status);


--
-- Name: matches_mentee_id_d1f950e2; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX matches_mentee_id_d1f950e2 ON public.matches USING btree (mentee_id);


--
-- Name: matches_mentor__fb198d_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX matches_mentor__fb198d_idx ON public.matches USING btree (mentor_id, status);


--
-- Name: matches_mentor_id_59b76bab; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX matches_mentor_id_59b76bab ON public.matches USING btree (mentor_id);


--
-- Name: matches_offer_id_91e0d674; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX matches_offer_id_91e0d674 ON public.matches USING btree (offer_id);


--
-- Name: matches_request_id_b2653ba8; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX matches_request_id_b2653ba8 ON public.matches USING btree (request_id);


--
-- Name: matches_status_639056_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX matches_status_639056_idx ON public.matches USING btree (status);


--
-- Name: mentorship__created_280abb_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX mentorship__created_280abb_idx ON public.mentorship_posts USING btree (created_at);


--
-- Name: mentorship__creator_6feaca_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX mentorship__creator_6feaca_idx ON public.mentorship_posts USING btree (creator_id, status);


--
-- Name: mentorship__subject_4b0ea6_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX mentorship__subject_4b0ea6_idx ON public.mentorship_posts USING btree (subject);


--
-- Name: mentorship__type_2b976d_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX mentorship__type_2b976d_idx ON public.mentorship_posts USING btree (type, status);


--
-- Name: mentorship_posts_creator_id_6ae72afe; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX mentorship_posts_creator_id_6ae72afe ON public.mentorship_posts USING btree (creator_id);


--
-- Name: messages_convers_3ebb41_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX messages_convers_3ebb41_idx ON public.messages USING btree (conversation_id, created_at);


--
-- Name: messages_conversation_id_5ef638db; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX messages_conversation_id_5ef638db ON public.messages USING btree (conversation_id);


--
-- Name: messages_sender__6ae55a_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX messages_sender__6ae55a_idx ON public.messages USING btree (sender_id);


--
-- Name: messages_sender_id_dc5a0bbd; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX messages_sender_id_dc5a0bbd ON public.messages USING btree (sender_id);


--
-- Name: notificatio_created_e4c995_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX notificatio_created_e4c995_idx ON public.notifications USING btree (created_at);


--
-- Name: notificatio_user_id_a4dd5c_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX notificatio_user_id_a4dd5c_idx ON public.notifications USING btree (user_id, is_read);


--
-- Name: notifications_user_id_468e288d; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX notifications_user_id_468e288d ON public.notifications USING btree (user_id);


--
-- Name: profiles_academi_e4a1e1_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX profiles_academi_e4a1e1_idx ON public.profiles USING btree (academic_level);


--
-- Name: profiles_departm_ffdbbc_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX profiles_departm_ffdbbc_idx ON public.profiles USING btree (department);


--
-- Name: reviews_match_id_df422061; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX reviews_match_id_df422061 ON public.reviews USING btree (match_id);


--
-- Name: reviews_rating_17e8a4_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX reviews_rating_17e8a4_idx ON public.reviews USING btree (rating);


--
-- Name: reviews_reviewe_965d53_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX reviews_reviewe_965d53_idx ON public.reviews USING btree (reviewer_id);


--
-- Name: reviews_reviewe_fe0fd6_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX reviews_reviewe_fe0fd6_idx ON public.reviews USING btree (reviewed_id);


--
-- Name: reviews_reviewed_id_26ab5b38; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX reviews_reviewed_id_26ab5b38 ON public.reviews USING btree (reviewed_id);


--
-- Name: reviews_reviewer_id_dbb954a8; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX reviews_reviewer_id_dbb954a8 ON public.reviews USING btree (reviewer_id);


--
-- Name: skills_name_3120df3a_like; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX skills_name_3120df3a_like ON public.skills USING btree (name varchar_pattern_ops);


--
-- Name: token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like ON public.token_blacklist_outstandingtoken USING btree (jti varchar_pattern_ops);


--
-- Name: token_blacklist_outstandingtoken_user_id_83bc629a; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX token_blacklist_outstandingtoken_user_id_83bc629a ON public.token_blacklist_outstandingtoken USING btree (user_id);


--
-- Name: user_skills_profile_id_4ff2a56e; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX user_skills_profile_id_4ff2a56e ON public.user_skills USING btree (profile_id);


--
-- Name: user_skills_skill_id_1a55c9b3; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX user_skills_skill_id_1a55c9b3 ON public.user_skills USING btree (skill_id);


--
-- Name: users_created_6541e9_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX users_created_6541e9_idx ON public.users USING btree (created_at);


--
-- Name: users_email_0ea73cca_like; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX users_email_0ea73cca_like ON public.users USING btree (email varchar_pattern_ops);


--
-- Name: users_email_4b85f2_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX users_email_4b85f2_idx ON public.users USING btree (email);


--
-- Name: users_groups_group_id_2f3517aa; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX users_groups_group_id_2f3517aa ON public.users_groups USING btree (group_id);


--
-- Name: users_groups_user_id_f500bee5; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX users_groups_user_id_f500bee5 ON public.users_groups USING btree (user_id);


--
-- Name: users_is_acti_847b48_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX users_is_acti_847b48_idx ON public.users USING btree (is_active);


--
-- Name: users_phone_2b77170a_like; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX users_phone_2b77170a_like ON public.users USING btree (phone varchar_pattern_ops);


--
-- Name: users_phone_af6883_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX users_phone_af6883_idx ON public.users USING btree (phone);


--
-- Name: users_user_permissions_permission_id_6d08dcd2; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX users_user_permissions_permission_id_6d08dcd2 ON public.users_user_permissions USING btree (permission_id);


--
-- Name: users_user_permissions_user_id_92473840; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX users_user_permissions_user_id_92473840 ON public.users_user_permissions USING btree (user_id);


--
-- Name: verificatio_status_a43286_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX verificatio_status_a43286_idx ON public.verification_documents USING btree (status);


--
-- Name: verificatio_user_id_d15fbf_idx; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX verificatio_user_id_d15fbf_idx ON public.verification_documents USING btree (user_id, status);


--
-- Name: verification_documents_reviewed_by_id_67481493; Type: INDEX; Schema: public; Owner: mentorlink
--

CREATE INDEX verification_documents_reviewed_by_id_67481493 ON public.verification_documents USING btree (reviewed_by_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: availability_slots availability_slots_profile_id_0c5edf97_fk_profiles_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.availability_slots
    ADD CONSTRAINT availability_slots_profile_id_0c5edf97_fk_profiles_id FOREIGN KEY (profile_id) REFERENCES public.profiles(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversation_members conversation_members_conversation_id_570068ad_fk_conversat; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.conversation_members
    ADD CONSTRAINT conversation_members_conversation_id_570068ad_fk_conversat FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversation_members conversation_members_user_id_3bfe90c8_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.conversation_members
    ADD CONSTRAINT conversation_members_user_id_3bfe90c8_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: matches matches_mentee_id_d1f950e2_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_mentee_id_d1f950e2_fk_users_id FOREIGN KEY (mentee_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: matches matches_mentor_id_59b76bab_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_mentor_id_59b76bab_fk_users_id FOREIGN KEY (mentor_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: matches matches_offer_id_91e0d674_fk_mentorship_posts_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_offer_id_91e0d674_fk_mentorship_posts_id FOREIGN KEY (offer_id) REFERENCES public.mentorship_posts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: matches matches_request_id_b2653ba8_fk_mentorship_posts_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_request_id_b2653ba8_fk_mentorship_posts_id FOREIGN KEY (request_id) REFERENCES public.mentorship_posts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mentorship_posts mentorship_posts_creator_id_6ae72afe_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.mentorship_posts
    ADD CONSTRAINT mentorship_posts_creator_id_6ae72afe_fk_users_id FOREIGN KEY (creator_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: messages messages_conversation_id_5ef638db_fk_conversations_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_conversation_id_5ef638db_fk_conversations_id FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: messages messages_sender_id_dc5a0bbd_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_dc5a0bbd_fk_users_id FOREIGN KEY (sender_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications notifications_user_id_468e288d_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_468e288d_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles profiles_user_id_36580373_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_36580373_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews reviews_match_id_df422061_fk_matches_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_match_id_df422061_fk_matches_id FOREIGN KEY (match_id) REFERENCES public.matches(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews reviews_reviewed_id_26ab5b38_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_reviewed_id_26ab5b38_fk_users_id FOREIGN KEY (reviewed_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews reviews_reviewer_id_dbb954a8_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_reviewer_id_dbb954a8_fk_users_id FOREIGN KEY (reviewer_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk FOREIGN KEY (token_id) REFERENCES public.token_blacklist_outstandingtoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_user_id_83bc629a_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_user_id_83bc629a_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_skills user_skills_profile_id_4ff2a56e_fk_profiles_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_profile_id_4ff2a56e_fk_profiles_id FOREIGN KEY (profile_id) REFERENCES public.profiles(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_skills user_skills_skill_id_1a55c9b3_fk_skills_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.user_skills
    ADD CONSTRAINT user_skills_skill_id_1a55c9b3_fk_skills_id FOREIGN KEY (skill_id) REFERENCES public.skills(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_groups users_groups_group_id_2f3517aa_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT users_groups_group_id_2f3517aa_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_groups users_groups_user_id_f500bee5_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT users_groups_user_id_f500bee5_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_permissions users_user_permissio_permission_id_6d08dcd2_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users_user_permissions
    ADD CONSTRAINT users_user_permissio_permission_id_6d08dcd2_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_permissions users_user_permissions_user_id_92473840_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.users_user_permissions
    ADD CONSTRAINT users_user_permissions_user_id_92473840_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: verification_documents verification_documents_reviewed_by_id_67481493_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.verification_documents
    ADD CONSTRAINT verification_documents_reviewed_by_id_67481493_fk_users_id FOREIGN KEY (reviewed_by_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: verification_documents verification_documents_user_id_adcd77e6_fk_users_id; Type: FK CONSTRAINT; Schema: public; Owner: mentorlink
--

ALTER TABLE ONLY public.verification_documents
    ADD CONSTRAINT verification_documents_user_id_adcd77e6_fk_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict CIQ0ONqjVIJlaL4jWi38p6QAYGmBbotTOuztqilmrSeSO0nY2uFZRhQcIteMqal

