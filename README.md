Geo Data Loader
===============

This repository contains all data needed to produce a Docker image that
contains a data-sets with geo coordinates

Data sets
---------

- world

Random data around the world. The documents contains `number`, `lat` and
`lon`. A total number of 100 million documents are available.

- us

Random data within or near the US. The documents contains `number`, `lat` and
`lon`. A total number of 100 million documents are available.

- airports

43991 airports.

Extracting the data
-------------------

To retrieve the data anywhere (where Docker is installed), use this command:

    docker run -it -v `pwd`:/data arangodb-helper/example-data-geo extract TYPE

where `TYPE` is one of the data sets names above. This will create a file

    geo_TYPE.csv

in the current directory. In order to restrict the number of documents use

    docker run -it -v `pwd`:/data arangodb-helper/example-data-geo extract TYPE NUMBER

Importing the data
------------------

In order to import the data directly in a running ArangoDB instance use

    docker run -it arangodb-helper/example-data-geo import TYPE [arangoimp options]

This will import all documents. To restrict the number of records use

    docker run -it arangodb-helper/example-data-geo import TYPE NUMBER [arangoimp options]

### Examples

    docker run -it arangodb-helper/example-data-geo import world 10000 \
		--server.endpoint tcp://172.17.0.1:8529 \
		--server.username root \
		--server.password "" \
		--collection geo \
		--create-collection true

Creation of Docker image
------------------------

Use the following commands:

    docker build -t arangodb-helper/example-data-geo .
    docker push arangodb-helper/example-data-geo

Details
-------

### airports

The Airports directory contains a list of airports with geo information. There
are roughly 43992 airports. The records contains the attributes

	id
	ident
	type
	name
	latitude_deg
	longitude_deg
	elevation_ft
	continent
	iso_country
	iso_region
	municipality
	scheduled_service
	gps_code
	iata_code
	local_code
	home_link
	wikipedia_link
	keywords

