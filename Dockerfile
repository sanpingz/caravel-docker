FROM python:2.7

# Install caravel
RUN pip install caravel

# Install mysql connector
RUN pip install https://cdn.mysql.com/Downloads/Connector-Python/mysql-connector-python-2.1.3.tar.gz

# copy admin password details to /caravel for fabmanager
RUN mkdir /caravel
COPY admin.config /caravel/

# Create an admin user
RUN /usr/local/bin/fabmanager create-admin --app caravel < /caravel/admin.config

# Initialize the database
RUN caravel db upgrade

# Create default roles and permissions
RUN caravel init

# Load some data to play with
RUN caravel load_examples

# Start the development web server
CMD caravel runserver -d
