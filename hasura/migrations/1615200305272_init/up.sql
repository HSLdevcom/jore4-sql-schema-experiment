CREATE SCHEMA infrastructure_network;

CREATE TABLE infrastructure_network.infrastructure_link (
  infrastructure_link_id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  infrastructure_link_geog geography(LinestringZ,4326) NOT NULL
);
