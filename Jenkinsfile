pipeline {
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
            }
        }
        stage('Clone Code') {
            steps {
                /*git branch: 'main', url: 'https://github.com/AsundkarPoornima/Containerize_PythonWebApp.git'*/
                checkout scm     
            }
        }
        stage('Compose build') {
            steps {
                sh "docker-compose build"
              //  sh "docker-compose push"
                
            }
        }
        stage('Compose up') {
            steps {
                 sh "docker-compose up -d -it"
            }
        }
       /* stage('Build Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE_NAME/mywebapp1:${BUILD_NUMBER} ."
            }
        }*/
    /*    stage('Login DockerHub') {
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
        stage('Run Container') {
            steps {
                sh "docker run -d -p 5001:5000 --name mywebapp1_container $DOCKER_IMAGE_NAME/mywebapp1:${BUILD_NUMBER}"
            }
        }*/
        stage('Access Webapp') {
            steps {
                script {
                    def my_ip = sh(script: 'curl -s http://checkip.amazonaws.com', returnStdout: true).trim()
                    sh "echo 'Access Webapp on http://${my_ip}:5001'"
                }
            }
        }
    }
 /*   post {
        always {
            sh 'docker logout'
        }
    }    */
}
