FROM postgres:13
COPY ./data /docker-entrypoint-initdb.d
ENV POSTGRES_PASSWORD=dummy_password
EXPOSE 5432
