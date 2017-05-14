FROM arangodb:3.1.19
MAINTAINER Frank Celler <frank@arangodb.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get autoremove -y \
    && apt-get install -y --no-install-recommends \
        apt-utils \
	time \
        xz-utils

COPY ./data/random/geo_world.csv.xz	/geo_world.csv.xz
COPY ./data/random/geo_us.csv.xz 	/geo_us.csv.xz
COPY ./data/airports/airports.csv.xz	/geo_airports.csv.xz

COPY ./README.md /README
COPY ./commands.sh /

RUN rm -f /core

ENTRYPOINT ["/commands.sh"]
