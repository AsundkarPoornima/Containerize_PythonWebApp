pipeline {
    agent {
        label 'agent-linux'
    }
   /* environment{
         DOCKERHUB_CREDENTIALS = credentials('DockerHub')
    }*/
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
                script {
                    withCredentials([usernamePassword(credentialsId: 'DockerHub', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "docker login --username $DOCKERHUB_USERNAME --password-stdin <<< $DOCKERHUB_PASSWORD"
                    }
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
                script {
                    def my_ip = sh(script: 'curl -s http://checkip.amazonaws.com', returnStdout: true).trim()
                    sh "echo 'Access Webapp on http://${my_ip}:5001'"
                }
            }
        }
        post {
            always {
              sh 'docker logout'
             }
        }    
    }
}
