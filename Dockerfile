FROM python:3.8

COPY . /application

WORKDIR /application
EXPOSE 5000
RUN pip install flask
ENTRYPOINT ["python"]
CMD  ["webapp.py"]

