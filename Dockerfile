FROM python:3.8

COPY . /application

WORKDIR /application

RUN python -m pip install flask
ENTRYPOINT ["python"]
CMD  ["webapp.py"]
