-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.8.2
-- PostgreSQL version: 9.5
-- Project Site: pgmodeler.com.br
-- Model Author: ---

-- object: sa | type: ROLE --
-- DROP ROLE IF EXISTS sa;
CREATE ROLE sa WITH 
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD 'data1';
-- ddl-end --


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: price_monitor_db | type: DATABASE --
-- -- DROP DATABASE IF EXISTS price_monitor_db;
-- CREATE DATABASE price_monitor_db
-- ;
-- -- ddl-end --
-- 

-- object: md | type: SCHEMA --
-- DROP SCHEMA IF EXISTS md CASCADE;
CREATE SCHEMA md;
-- ddl-end --
ALTER SCHEMA md OWNER TO sa;
-- ddl-end --

-- object: intake | type: SCHEMA --
-- DROP SCHEMA IF EXISTS intake CASCADE;
CREATE SCHEMA intake;
-- ddl-end --
ALTER SCHEMA intake OWNER TO sa;
-- ddl-end --

SET search_path TO pg_catalog,public,md,intake;
-- ddl-end --

-- object: intake.url_target_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS intake.url_target_seq CASCADE;
CREATE SEQUENCE intake.url_target_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE intake.url_target_seq OWNER TO sa;
-- ddl-end --

-- object: intake.url_target | type: TABLE --
-- DROP TABLE IF EXISTS intake.url_target CASCADE;
CREATE TABLE intake.url_target(
	id bigint NOT NULL DEFAULT nextval('intake.url_target_seq'::regclass),
	url text NOT NULL,
	target_text character varying NOT NULL,
	requesting_user_id integer NOT NULL,
	insert_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_url_target_id PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE intake.url_target OWNER TO sa;
-- ddl-end --

-- object: md.monitor_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS md.monitor_seq CASCADE;
CREATE SEQUENCE md.monitor_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE md.monitor_seq OWNER TO sa;
-- ddl-end --

-- object: md.monitors | type: TABLE --
-- DROP TABLE IF EXISTS md.monitors CASCADE;
CREATE TABLE md.monitors(
	id bigint NOT NULL DEFAULT nextval('md.monitor_seq'::regclass),
	url_id bigint NOT NULL,
	enabled boolean NOT NULL,
	insert_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_monitors PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE md.monitors OWNER TO sa;
-- ddl-end --

-- object: md.url_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS md.url_seq CASCADE;
CREATE SEQUENCE md.url_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE md.url_seq OWNER TO sa;
-- ddl-end --

-- object: md.urls | type: TABLE --
-- DROP TABLE IF EXISTS md.urls CASCADE;
CREATE TABLE md.urls(
	id bigint NOT NULL DEFAULT nextval('md.url_seq'::regclass),
	url text NOT NULL,
	insert_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_urls PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE md.urls OWNER TO sa;
-- ddl-end --

-- object: md.dom_paths_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS md.dom_paths_seq CASCADE;
CREATE SEQUENCE md.dom_paths_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE md.dom_paths_seq OWNER TO sa;
-- ddl-end --

-- object: md.dom_paths | type: TABLE --
-- DROP TABLE IF EXISTS md.dom_paths CASCADE;
CREATE TABLE md.dom_paths(
	id bigint NOT NULL DEFAULT nextval('md.dom_paths_seq'::regclass),
	path character varying NOT NULL,
	insert_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_dom_paths PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE md.dom_paths OWNER TO sa;
-- ddl-end --

-- object: md.price_history_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS md.price_history_seq CASCADE;
CREATE SEQUENCE md.price_history_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE md.price_history_seq OWNER TO sa;
-- ddl-end --

-- object: md.price_history | type: TABLE --
-- DROP TABLE IF EXISTS md.price_history CASCADE;
CREATE TABLE md.price_history(
	id bigint NOT NULL DEFAULT nextval('md.price_history_seq'::regclass),
	price numeric(6,4) NOT NULL,
	monitor_source_id bigint NOT NULL,
	insert_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_price_history PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE md.price_history OWNER TO sa;
-- ddl-end --

-- object: md.product_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS md.product_seq CASCADE;
CREATE SEQUENCE md.product_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE md.product_seq OWNER TO sa;
-- ddl-end --

-- object: md.products | type: TABLE --
-- DROP TABLE IF EXISTS md.products CASCADE;
CREATE TABLE md.products(
	id bigint NOT NULL DEFAULT nextval('md.product_seq'::regclass),
	product_identifier character varying NOT NULL,
	name character varying NOT NULL,
	description character varying NOT NULL,
	insert_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_products PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE md.products OWNER TO sa;
-- ddl-end --

-- object: md.products_monitors_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS md.products_monitors_seq CASCADE;
CREATE SEQUENCE md.products_monitors_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE md.products_monitors_seq OWNER TO sa;
-- ddl-end --

-- object: md.products_monitors | type: TABLE --
-- DROP TABLE IF EXISTS md.products_monitors CASCADE;
CREATE TABLE md.products_monitors(
	id bigint NOT NULL DEFAULT nextval('md.products_monitors_seq'::regclass),
	monitor_id bigint NOT NULL,
	product_id bigint NOT NULL,
	insert_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_products_monitors PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE md.products_monitors OWNER TO sa;
-- ddl-end --

-- object: md.monitors_dom_paths_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS md.monitors_dom_paths_seq CASCADE;
CREATE SEQUENCE md.monitors_dom_paths_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE md.monitors_dom_paths_seq OWNER TO sa;
-- ddl-end --

-- object: md.monitors_dom_paths | type: TABLE --
-- DROP TABLE IF EXISTS md.monitors_dom_paths CASCADE;
CREATE TABLE md.monitors_dom_paths(
	id bigint NOT NULL DEFAULT nextval('md.monitors_dom_paths_seq'::regclass),
	monitor_id bigint NOT NULL,
	dom_path_id bigint NOT NULL,
	monitor_dom_target_type_id bigint NOT NULL,
	insert_time timestamp DEFAULT CURRENT_TIMESTAMP,
	update_time timestamp DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_monitors_dom_paths PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE md.monitors_dom_paths OWNER TO sa;
-- ddl-end --

-- object: md.target_types_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS md.target_types_seq CASCADE;
CREATE SEQUENCE md.target_types_seq
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE md.target_types_seq OWNER TO postgres;
-- ddl-end --

-- object: md.target_types | type: TABLE --
-- DROP TABLE IF EXISTS md.target_types CASCADE;
CREATE TABLE md.target_types(
	id bigint NOT NULL DEFAULT nextval('md.target_types_seq'::regclass),
	name character varying NOT NULL,
	insert_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	update_time timestamp DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_target_types PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE md.target_types OWNER TO sa;
-- ddl-end --

-- object: fk_url_id | type: CONSTRAINT --
-- ALTER TABLE md.monitors DROP CONSTRAINT IF EXISTS fk_url_id CASCADE;
ALTER TABLE md.monitors ADD CONSTRAINT fk_url_id FOREIGN KEY (url_id)
REFERENCES md.urls (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_price_history_monitors | type: CONSTRAINT --
-- ALTER TABLE md.price_history DROP CONSTRAINT IF EXISTS fk_price_history_monitors CASCADE;
ALTER TABLE md.price_history ADD CONSTRAINT fk_price_history_monitors FOREIGN KEY (monitor_source_id)
REFERENCES md.monitors (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_product_monitors_prod | type: CONSTRAINT --
-- ALTER TABLE md.products_monitors DROP CONSTRAINT IF EXISTS fk_product_monitors_prod CASCADE;
ALTER TABLE md.products_monitors ADD CONSTRAINT fk_product_monitors_prod FOREIGN KEY (product_id)
REFERENCES md.products (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_products_monitors_mon | type: CONSTRAINT --
-- ALTER TABLE md.products_monitors DROP CONSTRAINT IF EXISTS fk_products_monitors_mon CASCADE;
ALTER TABLE md.products_monitors ADD CONSTRAINT fk_products_monitors_mon FOREIGN KEY (monitor_id)
REFERENCES md.monitors (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_monitor_dom_paths_monitor | type: CONSTRAINT --
-- ALTER TABLE md.monitors_dom_paths DROP CONSTRAINT IF EXISTS fk_monitor_dom_paths_monitor CASCADE;
ALTER TABLE md.monitors_dom_paths ADD CONSTRAINT fk_monitor_dom_paths_monitor FOREIGN KEY (monitor_id)
REFERENCES md.monitors (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_monitor_dom_paths_dp | type: CONSTRAINT --
-- ALTER TABLE md.monitors_dom_paths DROP CONSTRAINT IF EXISTS fk_monitor_dom_paths_dp CASCADE;
ALTER TABLE md.monitors_dom_paths ADD CONSTRAINT fk_monitor_dom_paths_dp FOREIGN KEY (dom_path_id)
REFERENCES md.dom_paths (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_monitor_dom_target_type | type: CONSTRAINT --
-- ALTER TABLE md.monitors_dom_paths DROP CONSTRAINT IF EXISTS fk_monitor_dom_target_type CASCADE;
ALTER TABLE md.monitors_dom_paths ADD CONSTRAINT fk_monitor_dom_target_type FOREIGN KEY (monitor_dom_target_type_id)
REFERENCES md.target_types (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


