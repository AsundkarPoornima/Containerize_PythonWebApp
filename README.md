
# DevOps project using Git, Docker Compose, Jenkins, and Docker



In this project, we will be see how to *use Git, Docker Compose, Jenkins, DockerHub, Docker to DEPLOY on a docker container.,*

*Follow the Steps*

#### PreRequisites
1. Git
2. Jenkins
3. Docker Compose 
4. Docker 
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
  
`DOCKER_IMAGE_NAME={DockerHub Account}

### Stage-05 : Create a Jenkins file 
- Create a Jenkinsfile into github
```pipeline {
    agent {
       label 'agent-linux'
    }
    environment{
         DOCKERHUB_CREDENTIALS = credentials('DockerHub')
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
Here we use 4 variables 
 - `BUILD_ID` -  The current build id
 - `DOCKER_IMAGE_NAME` - Name of the DockerHub account.
 - `DOCKERHUB_CREDENTIALS` -DockerAccount Credentials in Jenkins
 - `my_ip` -Displays Private IP
   
### Stage-06 : Jenkins configuration
1. Install java and git
2. Install jenkins
3. Login to Jenkins console
4. Create a pipeline project named 'project-1.0-pipeline'
5. To configure the Pipeline project by using the Pipeline script from the SCM option-
   * Open Jenkins Pipeline project from the list.
   * Click Configure, and then select the Pipeline tab.
   * Select the Pipeline script from SCM option in the Definition field.
   * Select the Git option from the drop-down list in the SCM field.
  
      <img width="371" alt="image" src="https://github.com/AsundkarPoornima/Containerize_PythonWebApp/assets/123767916/2a2f2d92-c371-48ea-8021-2bb552bd9fc8">

   * Enter the URL of the Git repository in the Repository URL field where you stored your pipeline script.
   * Select the credentials of the Git repository from the drop-down list.
   * Optional: Enter the branch name of the Git repository in the Branch Specifier field.
   * Enter the path of the script that you stored in the Git repository in the Script path field.

      <img width="325" alt="image" src="https://github.com/AsundkarPoornima/Containerize_PythonWebApp/assets/123767916/86de3948-21cc-40c3-bf72-4f4f95419c67">

   * Click Save.
6. Create required credentials
   Go to Credentials → Global → Add credentials and fill out the form with your username and password.
   
    <img width="557" alt="image" src="https://github.com/AsundkarPoornima/Containerize_PythonWebApp/assets/123767916/ecccbab7-205f-453f-92fd-8948e9ace2a0">
7. Create Agent
   *
9. Create webhook
   * In jenkins,
      * Navigate to the Project Pipeline > Configure.
       Go to, GitHub hook trigger for GITScm polling and check the checkbox.
       
        <img width="368" alt="image" src="https://github.com/AsundkarPoornima/Containerize_PythonWebApp/assets/123767916/3af35608-e68b-4810-8733-b4f4c276e362">
    * In GitHub,
      * Go to Project Repo and under Repo name click on Settings
       
         <img width="706" alt="image" src="https://github.com/AsundkarPoornima/Containerize_PythonWebApp/assets/123767916/412f4613-622d-4f6d-9696-b9206218f37f">
       * In left sidebar, click on webhook
        
         <img width="382" alt="image" src="https://github.com/AsundkarPoornima/Containerize_PythonWebApp/assets/123767916/ab4803b2-025c-4e80-96a3-cd3787e1888a">
      * click on Add Webhook
       
         <img width="622" alt="image" src="https://github.com/AsundkarPoornima/Containerize_PythonWebApp/assets/123767916/b30a9ab6-5f20-4ba1-8da3-26cea69e8c94">

       * Give the payload url ie http://{Agent-public-IP}/github-webhook
        .
          <img width="382" alt="image" src="https://github.com/AsundkarPoornima/Containerize_PythonWebApp/assets/123767916/d75191bc-48a8-4f41-b909-1d5fceb08d76">

      * Select Content type as application/json
      * Select Just the push event and check Active
      * Click on Add webhook.
       
         <img width="299" alt="image" src="https://github.com/AsundkarPoornima/Containerize_PythonWebApp/assets/123767916/4c0d4fde-c014-45f5-8940-58fd17faf864">
         
### Stage-07 : Post Configuration
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
