CREATE TABLE infrastructure_network.infrastructure_point_types (
  infrastructure_point_type_value TEXT PRIMARY KEY,
  infrastructure_point_type_comment TEXT NOT NULL
);

COMMENT ON TABLE infrastructure_network.infrastructure_point_types IS 'The enum types of the infrastructure point. The enum type is not part of Transmodel.';
COMMENT ON COLUMN
  infrastructure_network.infrastructure_point_types.infrastructure_point_type_value IS
  'The short ID of the infrastructure point type. The enum type is not part of Transmodel. Using length of one byte will likely be adequate in JORE context but it is not enforced.';
COMMENT ON COLUMN
  infrastructure_network.infrastructure_point_types.infrastructure_point_type_comment IS
  'The long name of the infrastructure point type.';

INSERT INTO infrastructure_network.infrastructure_point_types
  (infrastructure_point_type_value, infrastructure_point_type_comment)
  VALUES
  ('S', 'Stop'),
  ('X', 'Crossroads/Junction'),
  ('B', 'Border between municipalities');

CREATE TABLE infrastructure_network.infrastructure_points (
  infrastructure_point_id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  infrastructure_point_type TEXT NOT NULL
    REFERENCES infrastructure_network.infrastructure_point_types (infrastructure_point_type_value)
);

SELECT AddGeometryColumn('infrastructure_network', 'infrastructure_points', 'infrastructure_point_geom', 4326, 'POINT', 3);

ALTER TABLE infrastructure_network.infrastructure_points ALTER COLUMN infrastructure_point_geom SET NOT NULL;

CREATE INDEX ON infrastructure_network.infrastructure_points (infrastructure_point_type);

COMMENT ON COLUMN
  infrastructure_network.infrastructure_points.infrastructure_point_type IS
  'The infrastructure point type describing this point.';

COMMENT ON COLUMN
  infrastructure_network.infrastructure_points.infrastructure_point_geom IS
  'WGS84 point geometry (single coordinate) describing location of infrastructure point.';
