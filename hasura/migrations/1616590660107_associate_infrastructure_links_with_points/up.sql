ALTER TABLE infrastructure_network.infrastructure_links
  ADD COLUMN infrastructure_begin_point_id uuid NOT NULL
  REFERENCES infrastructure_network.infrastructure_points (infrastructure_point_id);

ALTER TABLE infrastructure_network.infrastructure_links
  ADD COLUMN infrastructure_end_point_id uuid NOT NULL
  REFERENCES infrastructure_network.infrastructure_points (infrastructure_point_id);

COMMENT ON COLUMN
  infrastructure_network.infrastructure_links.infrastructure_begin_point_id IS
  'The ID of the begin point of infrastructure link.';

COMMENT ON COLUMN
  infrastructure_network.infrastructure_links.infrastructure_end_point_id IS
  'The ID of the end point of infrastructure link.';

CREATE INDEX ON infrastructure_network.infrastructure_links (infrastructure_begin_point_id);
CREATE INDEX ON infrastructure_network.infrastructure_links (infrastructure_end_point_id);
