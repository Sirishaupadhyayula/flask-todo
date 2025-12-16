pipeline {
  agent any

  environment {
    REGISTRY = "sirisha2402"
    IMAGE    = "flask-todo-app"
    RELEASE  = "flask-todo"
    CHART    = "./helm/flask-todo"
    NAMESPACE = "default"
    DOCKER_CREDENTIALS = "dockerhub"
    KUBECONFIG = "/var/jenkins_home/.kube/config"
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Build Docker Image') {
      steps {
        sh '''
          set -e
          docker build -t $REGISTRY/$IMAGE:$BUILD_NUMBER .
          docker tag $REGISTRY/$IMAGE:$BUILD_NUMBER $REGISTRY/$IMAGE:latest
        '''
      }
    }

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            set -e
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push $REGISTRY/$IMAGE:$BUILD_NUMBER
            docker push $REGISTRY/$IMAGE:latest
          '''
        }
      }
    }

    stage('Deploy with Helm') {
      steps {
        sh '''
          set -e
          kubectl config use-context k3d-dev-cluster

          helm upgrade --install $RELEASE $CHART \
            --namespace $NAMESPACE \
            --set image.repository=$REGISTRY/$IMAGE \
            --set image.tag=$BUILD_NUMBER

          kubectl rollout status deploy/$RELEASE -n $NAMESPACE
          kubectl get pods -n $NAMESPACE
          kubectl get svc $RELEASE -n $NAMESPACE
        '''
      }
    }
  }
}
