pipeline {
  agent any

  environment {
    REGISTRY = "sirisha2402"
    IMAGE = "flask-todo-app"
    DOCKER_CREDENTIALS = "dockerhub"
  }

  stages {

    stage('Build & Push Docker Image') {
      steps {
        echo "Build stage here"
      }
    }

    stage('Deploy to Kubernetes (Helm)') {
      steps {
        sh '''
        set -e
        export KUBECONFIG=/var/jenkins_home/.kube/config

        helm upgrade --install flask-todo ./helm/flask-todo \
          --set image.repository=$REGISTRY/$IMAGE \
          --set image.tag=$BUILD_NUMBER

        kubectl rollout status deploy/flask-todo
        kubectl get pods
        kubectl get svc
        '''
      }
    }

  }
}
