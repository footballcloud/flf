#docker build --force-rm=true --no-cache=true -t uoc/flf .\
#docker run -it -v "C:\AWL\MIDDLE\m2c\gcloud\flf\app:/app" --entrypoint "/bin/bash" uoc/flf
#docker run uoc/flf
#docker run -it --entrypoint "/bin/bash" uoc/flf


FROM ubuntu:latest
#FROM ubuntu:20.04

RUN apt update
RUN apt install -y netcat
RUN apt install zip unzip
RUN apt -y install gawk
RUN apt -y install curl

RUN mkdir -p /app

VOLUME /app

