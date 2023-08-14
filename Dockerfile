FROM python:3.8

COPY . /application

WORKDIR /application

RUN python -m pip install flask
CMD python webapp.py
