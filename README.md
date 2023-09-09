116
# DevOps project using Git, Docker Compose, Jenkins, and Docker



In this project, we will be see how to *use Git, Docker Compose, Jenkins, DockerHub, Docker to DEPLOY on a docker container.,*

*Follow the Steps*

#### PreRequisites
1. Git
1. Jenkins
1. Docker Compose 
1. install docker. 
1. Docker Hub account 


### Stage-01 : Create a web page
Put all the web page code file into github

### Stage-02 : Create a Docker file 
- Create a Docker file into github
 ```FROM python:3.8
COPY . /application
WORKDIR /application
EXPOSE 5000
RUN pip install flask
ENTRYPOINT ["python"]
CMD  ["webapp.py"]```

------------------------------------------
# Containerize_PythonWebApp

# Build Build DockerImage
docker build -t mywebapp1 .

#  & Run Container
docker run -p 5000:5000 --name mywebapp1_container mywebapp1

# Access the Webapp
http://{localhost/your**EC2publicIP}:5000

# Tag the image
docker tag mywebapp1 yourusername/mywebapp1:latest

# Login to Docker Hub
docker login --username your-username --password your-password

# Push the image
docker push yourusername/mywebapp1:latest
