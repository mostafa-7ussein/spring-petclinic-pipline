pipeline {
    agent any
    environment {
        GIT_REPO = 'https://github.com/mostafa-7ussein/spring-petclinic-pipline.git' 
        GIT_CREDENTIALS_ID = 'github'
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub' 
        IMAGE_NAME = 'mostafahu/springpetclinic'
        DOCKER_TAG = "${env.BUILD_NUMBER}"  
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    credentialsId: env.GIT_CREDENTIALS_ID, 
                    url: env.GIT_REPO
            }
        }

         stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${DOCKER_TAG} ."
                }
            }
        }
    }
}