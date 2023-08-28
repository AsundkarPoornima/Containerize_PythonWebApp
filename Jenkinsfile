pipeline {
    agent any

    stages {
         /* stage('Cleanup') {
            steps {
                echo 'Hello World'
            }
        }*/
        stage('Clone Code') {
            steps {
                git branch: 'main', url: 'https://github.com/AsundkarPoornima/Containerize_PythonWebApp.git'
            }
        }
        stage('Build Image') {
            steps {
                sh 'docker build -t poornimaasundkar/mywebapp1:latest .'
            }
        }
        stage('Login DockerHub') {
            steps {
                sh 'docker login --username poornimaasundkar --password poonu@2397'
            }
        }
        stage('Push Image') {
            steps {
                sh 'docker push poornimaasundkar/mywebapp1:latest'
            }
        }
        stage('Run Container') {
            steps {
                sh 'docker run -p 5000:5000 --name mywebapp1_container poornimaasundkar/mywebapp1:latest'
            }
        }
        stage('Access Webapp') {
            steps {
                echo 'Access Webapp on https://localhost:5000'
            }
        }
    }
}
