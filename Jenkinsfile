pipeline {
    agent any

    environment {
        REGISTRY = "Sirishaupadhyayula"   // <-- your Docker Hub username
        IMAGE = "flask-todo-app"
        DOCKER_CREDENTIALS = 'dockerhub'  // Jenkins credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: DOCKER_CREDENTIALS,
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
<<<<<<< HEAD
                    sh """
                    set -e

                    echo "Logging into Docker Hub..."
                    echo "\$DOCKER_PASS" | docker login -u "\$DOCKER_USER" --password-stdin

                    echo "Building Docker image..."
                    docker build -t ${REGISTRY}/${IMAGE}:${BUILD_NUMBER} .

                    echo "Pushing Docker image..."
                    docker push ${REGISTRY}/${IMAGE}:${BUILD_NUMBER}

                    echo "Logging out from Docker Hub..."
                    docker logout
                    """
=======
                    sh '''
                    set -e

                    echo "Logging into Docker Hub..."
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                    echo "Building Docker image..."
                    docker build -t "$REGISTRY/$IMAGE:$BUILD_NUMBER" .

                    echo "Pushing Docker image..."
                    docker push "$REGISTRY/$IMAGE:$BUILD_NUMBER"

                    echo "Logging out from Docker Hub..."
                    docker logout
                    '''
>>>>>>> df4e15a (Simple CI docker build and push)
                }
            }
        }
    }
}
