FROM alpine:latest as build

RUN apk --no-cache add python3 && python3 -m ensurepip && \
  pip3 install --upgrade pip setuptools wheel 

COPY setup.py .
COPY README.md .
COPY sqs_resource sqs_resource/

RUN python3 ./setup.py bdist_wheel


FROM concourse/git-resource as git

RUN apk --no-cache add python3 && python3 -m ensurepip && \
  pip3 install --upgrade pip setuptools wheel GitPython

RUN cp -r /opt/resource /opt/original_git && rm /opt/resource/check

