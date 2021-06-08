FROM postgres:13
COPY ./data /docker-entrypoint-initdb.d
EXPOSE 5432
