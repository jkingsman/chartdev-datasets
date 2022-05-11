-- Create read-only role
CREATE ROLE dundersign WITH LOGIN PASSWORD 'marten'
NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL 'infinity';

-- Grant usage on dundersign
\connect dundersign
GRANT USAGE ON SCHEMA public TO chartdev;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO chartdev;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO chartdev;

GRANT USAGE ON SCHEMA public TO dundersign;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO dundersign;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO dundersign;
