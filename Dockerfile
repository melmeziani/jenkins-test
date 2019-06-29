FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install python python-pip -y

RUN pip install --upgrade pip
RUN mkdir /opt/app

COPY src/main.py /opt/app/

COPY req.txt /opt/app/

WORKDIR /opt/app/

RUN pip install -r req.txt

ENTRYPOINT "/usr/bin/python /opt/app/main.py"
