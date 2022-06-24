#!/bin/bash

#TODO: This doesn't handle test databases correctly
RESULT=`psql -l | grep "red_hanger" | wc -l | awk '{print $1}'`;
if test $RESULT -eq 0; then
    echo "Creating Database";
    psql -c "create role red_hanger with createdb encrypted password 'red_hanger' login;"
    psql -c "alter user red_hanger superuser;"
    psql -c "create database red_hanger with owner red_hanger;"
else
    echo "Database exists"
fi

#run initial setup of database tables
poetry run python manage.py migrate
