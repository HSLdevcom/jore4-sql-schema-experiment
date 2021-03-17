ALTER TABLE infrastructure_network.infrastructure_links
  DROP COLUMN infrastructure_network_type_id RESTRICT;

ALTER TABLE infrastructure_network.infrastructure_network_types
  DROP COLUMN infrastructure_network_type_id RESTRICT;
ALTER TABLE infrastructure_network.infrastructure_network_types
  RENAME COLUMN infrastructure_network_type_name
  TO infrastructure_network_type;
ALTER TABLE infrastructure_network.infrastructure_network_types
  ADD PRIMARY KEY (infrastructure_network_type);

COMMENT ON TABLE
  infrastructure_network.infrastructure_network_types IS
  'The types of the infrastructure network. The types are based on which vehicle modes can reasonably be considered compatible with each network. This concept is too simplified in Transmodel.';
COMMENT ON COLUMN
  infrastructure_network.infrastructure_network_types.infrastructure_network_type IS
  'The type of the infrastructure network.';

ALTER TABLE infrastructure_network.infrastructure_links
  ADD COLUMN infrastructure_network_type text
  NOT NULL
  REFERENCES infrastructure_network.infrastructure_network_types
  (infrastructure_network_type);
CREATE INDEX ON
  infrastructure_network.infrastructure_links
  (infrastructure_network_type);
COMMENT ON COLUMN
  infrastructure_network.infrastructure_links.infrastructure_network_type IS
  'The infrastructure network type describing this link.';

INSERT INTO infrastructure_network.infrastructure_network_types
  (infrastructure_network_type)
  VALUES
  ('road'),
  ('railway'),
  ('tram_track'),
  ('metro_track'),
  ('waterway');
