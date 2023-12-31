# Dockerfile

FROM microsoft/mssql-server-linux

RUN apt-get update && apt-get install -y python3 python3-pip unixodbc-dev vim

RUN pip3 install ndjson xmltodict pyodbc requests uuid

RUN mkdir sqlfiles

COPY create-sql-tables/createDB.sql ./sqlfiles/createDB.sql
COPY create-sql-tables/worker.Worker.Table.sql ./sqlfiles/worker.Worker.Table.sql
COPY create-sql-tables/worker.WorkerFireDepartment.Table.sql ./sqlfiles/worker.WorkerFireDepartment.Table.sql
COPY create-sql-tables/worker.WorkerObservation.Table.sql ./sqlfiles/worker.WorkerObservation.Table.sql
COPY create-sql-tables/worker.WorkerRace.Table.sql ./sqlfiles/worker.WorkerRace.Table.sql

COPY create-sql-tables/setup-database.sh ./sqlfiles/setup-database.sh
COPY create-sql-tables/entrypoint.sh ./sqlfiles/entrypoint.sh
COPY FHIR_combined.py ./
COPY ./test/ ./test/

COPY FHIR_combined.py ./
COPY FHIR_insertDB.py ./
COPY /test/FHIR_verifyDB.py ./
COPY ./test/ ./test/

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=Password!123
ENV PATH=${PATH}:/opt/mssql/bin:/opt/mssql-tools/bin

ENV PYTHONIOENCODING=utf-8

RUN chmod a+x ./sqlfiles/setup-database.sh
RUN chmod a+x ./sqlfiles/entrypoint.sh

EXPOSE 1433

CMD bash ./sqlfiles/entrypoint.sh 2>&1 | tee sqlOutput.txt
