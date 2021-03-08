COMMENT ON TABLE
  infrastructure_network.infrastructure_links IS
  'The infrastructure links, e.g. road or rail segments.';
COMMENT ON COLUMN
  infrastructure_network.infrastructure_links.infrastructure_link_id IS
  'The ID of the infrastructure link.';
COMMENT ON COLUMN
  infrastructure_network.infrastructure_links.infrastructure_link_geog IS
  'The PostGIS geography of the infrastructure link in WGS 84.';

CREATE TABLE infrastructure_network.infrastructure_network_types (
  infrastructure_network_type_id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  infrastructure_network_type_name text NOT NULL UNIQUE
);

COMMENT ON TABLE
  infrastructure_network.infrastructure_network_types IS
  'The types of the infrastructure network, e.g. road, rail, tram, metro. Not in Transmodel.';
COMMENT ON COLUMN
  infrastructure_network.infrastructure_network_types.infrastructure_network_type_id IS
  'The ID of the infrastructure network type.';
COMMENT ON COLUMN
  infrastructure_network.infrastructure_network_types.infrastructure_network_type_name IS
  'The name of the infrastructure network type, e.g. "road", "rail", "tram", "metro".';
