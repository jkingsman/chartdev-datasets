# Chartdev Datasets

## Find at `jkingsman/chartdev-datasets` on Docker Hub

### Quickstart

```bash
docker run -p 5432:5432 -e POSTGRES_PASSWORD=x jkingsman/chartdev-datasets:latest
psql postgres://chartdev:marten@127.0.0.1:5432/chinook
# or
psql postgres://chartdev:marten@127.0.0.1:5432/dundersign
# or
psql postgres://chartdev:marten@127.0.0.1:5432/ufosightings
```

Running `run_database.sh` will build and boot a three databases with demo data:

* The standard `chinook` dataset
* Demo dataset `dundersign`
* Legacy demo dataset `ufosightings`

These are accessible with the read-only user `chartdev` (password `marten`) which has access to all databases, and individual users with the name of the database (`chinook`, `dundersign`, `ufosightings`) with the same password (`marten`) which have access only to the database that shares their name.

These are customizable in `data/40-readonlyuser.sql`; this script also disables login for the superuser `postgres` which you can reenable if you would like a non-read-only user.

```
Host: 127.0.0.1 (for use in other docker services, use `host.docker.internal` to escape the container)
Port: 5432
User: chartdev
Password: marten

Database: chinook
Schema: public

Database: dundersign
Schema: public

Database: ufosightings
Schema: public
```

## Helper Scripts

All scripts must be run from the root of the repo.

`./scripts/create_dumps.sh` will dump the databases as-is from a running instance of the docker. The packaged dumps are dumped using Postgres 9 for maximum compatibility. Make sure to set the `CONTAINER_ID` environment variable before you start

`./scripts/run_database.sh` will build and boot the image.

`./scripts/push_docker.sh` will build and push a new image to Docker Hub.

## Instance Setup

General instructions to set this up in a non-docker context on Ubuntu 20:

```bash
# postgres installation
sudo apt update
sudo apt -y upgrade
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list
sudo apt update
sudo apt install postgresql-13 postgresql-client-13 -y

# open postgres to the world and block the superuser
sudo vim /etc/postgresql/13/main/postgresql.conf
    # uncomment listen_addresses and set to '*'
sudo vim /etc/postgresql/13/main/pg_hba.conf
    # delete the 127.0.0.1/32 line and add the following (without comments):
    # host    all             postgres        0.0.0.0/0               reject
    # host    all             all             0.0.0.0/0               md5
sudo service postgresql restart

# clone and import data
git clone https://github.com/jkingsman/chartdev-datasets.git
cd chartdev-datasets/
vim data/40-readonlyuser.sql
    # delete the last line so you're not locked out of your superuser forever

gunzip -c ./data/10-chinook.sql.gz | sudo su - postgres -c "psql"
gunzip -c ./data/20-dundersign.sql.gz | sudo su - postgres -c "psql"
gunzip -c ./data/30-ufosightings.sql.gz | sudo su - postgres -c "psql"
cat ./data/40-readonlyuser.sql | sudo su - postgres -c "psql"
```
