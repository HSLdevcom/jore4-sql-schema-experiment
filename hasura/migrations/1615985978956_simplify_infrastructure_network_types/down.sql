ALTER TABLE infrastructure_network.infrastructure_links
  DROP COLUMN infrastructure_network_type RESTRICT;

DROP TABLE infrastructure_network.infrastructure_network_types RESTRICT;

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

ALTER TABLE infrastructure_network.infrastructure_links
  ADD COLUMN infrastructure_network_type_id uuid
  NOT NULL
  REFERENCES infrastructure_network.infrastructure_network_types
  (infrastructure_network_type_id);
COMMENT ON COLUMN
  infrastructure_network.infrastructure_links.infrastructure_network_type_id IS
  'The ID of the infrastructure network type describing this link.';
