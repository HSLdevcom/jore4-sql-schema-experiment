DROP SCHEMA IF EXISTS public CASCADE; -- drop public schema as it might not be available e.g. in azure's db
CREATE SCHEMA postgis;
CREATE SCHEMA pgcrypto;
CREATE EXTENSION postgis WITH SCHEMA postgis;
CREATE EXTENSION pgcrypto WITH SCHEMA pgcrypto;
CREATE SCHEMA infrastructure_network;

SELECT set_config('search_path', 'postgis, pgcrypto,'||current_setting('search_path'), false);

CREATE TABLE infrastructure_network.infrastructure_links (
  infrastructure_link_id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  infrastructure_link_geog geography(LinestringZ,4326) NOT NULL
);
