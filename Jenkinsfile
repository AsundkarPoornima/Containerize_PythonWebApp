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
                sh 'docker stop mywebapp1_container'
      		    sh 'docker rm mywebapp1_container'
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
                sh 'docker build -t poornimaasundkar/mywebapp1:${BUILD_NUMBER} .'
            }
        }
        stage('Login DockerHub') {
            steps {
           sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login --username $DOCKERHUB_CREDENTIALS_USR --password-stdin'
               //  sh 'docker login --username ${DOCKERHUB_CREDENTIALS.username} --password {DOCKERHUB_CREDENTIALS.password}'
            }
        }
        stage('Push Image') {
            steps {
                sh 'docker push poornimaasundkar/mywebapp1:${BUILD_NUMBER}'
            }
        }
        stage('Run Container') {
            steps {
                sh 'docker run -d -p 5001:5000 --name mywebapp1_container poornimaasundkar/mywebapp1:${BUILD_NUMBER}'
            }
        }
        stage('Access Webapp') {
            steps {
                sh my_ip=$(curl http://checkip.amazonaws.com)
                sh echo "Access Webapp on https://${my_ip}:5001"
            }
        }
}   }
