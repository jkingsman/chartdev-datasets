-- Create read-only role
CREATE ROLE ufosightings WITH LOGIN PASSWORD 'marten'
NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL 'infinity';

-- Grant usage on ufosightings
\connect ufosightings
GRANT USAGE ON SCHEMA public TO chartdev;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO chartdev;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO chartdev;

GRANT USAGE ON SCHEMA public TO ufosightings;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO ufosightings;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO ufosightings;
