# azure-python-docker
Dockerfile to set up a container with Ubuntu 16.10 including Python 3.6 and working ODBC drivers for MSSQL / Azure SQL.

Usage

Clone the project to your local machine

git clone https://github.com/klaarp/azure-python-docker.git

Build the image using Docker

docker build -t pyapp .

Add you Python project files and add your requirements.txt to the /app directory and let run.py be your entry point.

Run the image and mount the /app directory to the container

docker run -it -v "/YOUR_DIRECTORY/app:/home/py/pyapp" pyapp


