pipeline {
    agent any

    environment {
        REGISTRY = "sirisha2402"
        IMAGE = "flask-todo-app"
        DOCKER_CREDENTIALS = "dockerhub"
        KUBECONFIG = "/var/jenkins_home/.kube/config"
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
                    sh '''
                    set -e
                    echo "Logging into Docker Hub..."
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                    echo "Building Docker image..."
                    docker build -t "$REGISTRY/$IMAGE:$BUILD_NUMBER" .

                    echo "Pushing Docker image..."
                    docker push "$REGISTRY/$IMAGE:$BUILD_NUMBER"

                    echo "Logging out..."
                    docker logout
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes (Helm)') {
            steps {
                sh '''
                set -e
                echo "Deploying to k3d using Helm..."
                helm upgrade --install flask-todo ./helm/flask-todo \
                  --set image.repository=$REGISTRY/$IMAGE \
                  --set image.tag=$BUILD_NUMBER

                echo "Deployment status:"
                helm list
                kubectl get pods
                kubectl get svc
                '''
            }
        }
    }
}
