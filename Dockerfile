# Using Ubuntu 16.10 as parent image
FROM ubuntu:16.10

MAINTAINER Per Klaar, per.klaar@gmail.com

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE C.UTF-8

# Set the working directory to /pyapp
WORKDIR /home/py

ADD ./addons /home/py

VOLUME /home/py/pyapp

RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-utils \
	locales \
	nano \
	curl \
	apt-transport-https

# Add locales for Swedish and English (required for MS ODBC install)
RUN locale-gen en_US && locale-gen en_US.UTF-8 && locale-gen sv_SE && locale-gen sv_SE.UTF-8 && update-locale

# Install Python 3.6 and install drivers ODBC drivers for Azure SQL connectivity
RUN apt-get install -y python3.6 python3-pip && sh installodbc.sh && rm -f installodbc.sh

# Install any needed packages specified in requirements.txt
RUN pip3 install --upgrade pip && pip3 install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME PythonAzure

# Launch start up script
CMD sh runcontainer.sh
