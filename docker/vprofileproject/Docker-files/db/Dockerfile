FROM mysql:8.0.33
LABEL "project"="vProfile"
LABEL "author"="utkarsh"
LABEL "version"="1.0"
ENV MYSQL_ROOT_PASSWORD="start123"
ENV MYSQL_DATABASE="accounts"
ADD db_backup.sql /docker-entrypoint-initdb.d/db_backup.sql

