pipeline {
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
               /* sh 'docker stop mywebapp1_container'
      		    sh 'docker rm mywebapp1_container'*/
            }
        }
        stage('Clone Code') {
            steps {
                /*git branch: 'main', url: 'https://github.com/AsundkarPoornima/Containerize_PythonWebApp.git'*/
                checkout scm     
            }
        }
        stage('Build Image') {
            steps {
                sh 'docker build -t poornimaasundkar/mywebapp1:latest .'
            }
        }
        stage('Login DockerHub') {
            steps {
               // sh 'docker login --username poornimaasundkar --password poonusumit@2397'
           // sh 'echo $DOCKERHUB_CREDENTIALS_PSM | docker login --username $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                 sh 'docker login --username ${DOCKERHUB_CREDENTIALS.username} --password {DOCKERHUB_CREDENTIALS.password}'
            }
        }
        stage('Push Image') {
            steps {
                sh 'docker push poornimaasundkar/mywebapp1:latest'
            }
        }
        stage('Run Container') {
            steps {
                sh 'docker run -d -p 5001:5000 --name mywebapp1_container poornimaasundkar/mywebapp1:latest'
            }
        }
        stage('Access Webapp') {
            steps {
                echo 'Access Webapp on https://localhost:5001'
            }
        }
    }
}
