pipeline {
    agent any

    environment {
        REGISTRY = "sirisha2402"
        IMAGE = "flask-todo-app"
        DOCKER_CREDENTIALS = 'dockerhub'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker version'
                    sh 'echo Building Docker image...'
                    dockerImage = docker.build("${REGISTRY}/${IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
