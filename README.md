
# DevOps project using Git, Docker Compose, Jenkins, and Docker



In this project, we will be see how to *use Git, Docker Compose, Jenkins, DockerHub, Docker to DEPLOY on a docker container.,*

*Follow the Steps*

#### PreRequisites
1. Git
2. Jenkins
3. Docker Compose 
4. install docker. 
5. Docker Hub account 


### Stage-01 : Create a web page
Put all the web page code file into github

### Stage-02 : Create a Dockerfile 
- Create a Dockerfile into github
 ```FROM python:3.8
COPY . /application
WORKDIR /application
EXPOSE 5000
RUN pip install flask
ENTRYPOINT ["python"]
CMD  ["webapp.py"]
```
### Stage-03 : Create a Docker Compose file 
- Create a docker-compose.yml into github
 ```version: "3"
services:
  webapp:
      image: '${DOCKER_IMAGE_NAME}/mywebapp1:${BUILD_NUMBER}'
      ports:
        - 5001:5000
      env_file: .env
```
### Stage-04 : Create a .env file 
- Create a .env file into github
- 
`DOCKER_IMAGE_NAME=poornimaasundkar`

### Stage-05 : Create a Jenkins file 
- Create a Jenkinsfile into github
```pipeline {
    agent {
       label 'agent-linux'
    }
    environment{
         DOCKERHUB_CREDENTIALS = credentials('DockerHub')
         DOCKER_IMAGE_NAME = "poornimaasundkar"
    }
    stages {
        stage('Cleanup') {
            steps {
                sh 'rm -rf /var/lib/jenkins/workspace/project-1.0-pipeline@2'
              /*  sh 'docker stop mywebapp1_container || true'
      		    sh 'docker rm mywebapp1_container || true'*/
            sh "docker-compose down"
            }
        }
        stage('Clone Code') {
            steps {
                checkout scm     
            }
        }
        stage('Build Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE_NAME/mywebapp1:${BUILD_NUMBER} ."
            }
        }
        stage('Login DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'DockerHub', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                      //  sh "docker login --username $DOCKERHUB_USERNAME --password-stdin <<< $DOCKERHUB_PASSWORD"
                         sh "echo $DOCKERHUB_PASSWORD | docker login --username $DOCKERHUB_USERNAME --password-stdin"
                    }
                }
            }
        }   
        stage('Push Image') {
            steps {
                sh "docker push $DOCKER_IMAGE_NAME/mywebapp1:${BUILD_NUMBER}"
            }
        }
        stage('Compose up') {
            steps {
                 sh 'cat docker-compose.yml'
                 sh "docker-compose --env-file .env up"
            }
        }

        stage('Access Webapp') {
            steps {
                script {
                    def my_ip = sh(script: 'curl -s http://checkip.amazonaws.com', returnStdout: true).trim()
                    sh "echo 'Access Webapp on http://${my_ip}:5001'"
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }    
}

```
  
### Stage-06 : Jenkins configuration
1. Install java and git
2. Install jenkins
3. Login to Jenkins console
4. Create a pipeline project named 'project-1.0-pipeline'
5. Create required credentials
6. Create Agent
7. Create webhook
   - In jenkins,
     Navigate to the Project Pipeline > Configure.
     Go to, GitHub hook trigger for GITScm polling and check the checkbox.
   - In GitHub,
     Go to Project Repo and under Repo name click on Settings
     In left sidebar, click on webhook
     Give the payload url ie http://{Agent-public-IP}/github-webhook
     Select Content type as application/json
     Select Just the push event and check Active
     Click on Add webhook.

Here we use 2 variables 
 - `BUILD_ID` -  The current build id
 - `DOCKER_IMAGE_NAME` - Name of the DockerHub account.
 - `DOCKERHUB_CREDENTIALS` -DockerAccount Credentials in Jenkins

1. Login to Docker Agent and check images and containers. (no images and containers)
2. Execute Jenkins job
3. Check images in Docker hub. Now you could able to see new images pushed to your DockerHub account
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
