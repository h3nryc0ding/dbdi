FROM ubuntu:22.04 AS builder

# install dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y make cmake gcc
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install postgresql

WORKDIR /home/ssb-dbgen

# generate data
COPY ssb-dbgen /home/ssb-dbgen
RUN make -C .
RUN ./dbgen -s 1 -T a -f -v
RUN mv *.tbl /tmp/

WORKDIR /home/student/init

# create database and user
COPY sql/init/database.sql /home/student/init/
USER postgres
RUN service postgresql start &&\
    psql -f database.sql &&\
    service postgresql stop

# create tables and load data
COPY sql/init/tables.sql /home/student/init/
COPY sql/init/load.sql /home/student/init/
USER root
RUN service postgresql start &&\
    psql -d ssb -f tables.sql &&\
    psql -d ssb -f load.sql &&\
    service postgresql stop

FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install postgresql

COPY --from=builder /var/lib/postgresql /var/lib/postgresql

# copy queries
COPY sql/queries /home/student/queries
WORKDIR /home/student/queries

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]