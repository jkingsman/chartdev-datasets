-- Connect to dummy db so we can drop postgres
\connect chinook

-- Drop default database created on startup
DROP DATABASE IF EXISTS postgres;

-- Lock out superuser
ALTER USER postgres WITH NOLOGIN;
