COMMENT ON TABLE
  infrastructure_network.infrastructure_links IS
  'The infrastructure links, e.g. road or rail segments.';
COMMENT ON COLUMN
  infrastructure_network.infrastructure_links.infrastructure_link_id IS
  'The ID of the infrastructure link.';
COMMENT ON COLUMN
  infrastructure_network.infrastructure_links.infrastructure_link_geog IS
  'The PostGIS geography of the infrastructure link in WGS 84.';
