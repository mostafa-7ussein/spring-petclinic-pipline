pipeline {
    agent any
    environment {
        GIT_REPO = 'https://github.com/mostafa-7ussein/spring-petclinic-pipline' 
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub' 
        IMAGE_NAME = 'mostafahu/springpetclinic'
        DOCKER_TAG = "${env.BUILD_NUMBER}"  
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: env.GIT_REPO
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build --no-cache -t ${IMAGE_NAME}:${DOCKER_TAG} ."
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: env.DOCKERHUB_CREDENTIALS_ID, 
                    usernameVariable: 'DOCKER_USERNAME', 
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    script {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                        sh "docker push ${IMAGE_NAME}:${DOCKER_TAG}"
                    }
                }
            }
        }
    

    }
    post {
          success {
            script {
                slackSend(channel: '#flask-weather', color: '#00FF00', message: "Succeeded  ${env.JOB_NAME} - Build Number: ${env.BUILD_NUMBER} succeeded!")
            }
        }
        failure {
            script {
                slackSend(channel: '#flask-weather', message: "Pipeline ${env.JOB_NAME} - Build Number: ${env.BUILD_NUMBER} failed!")
            }
        }    
        always {
            echo "Pipeline completed."
            sh 'docker system prune -f'
        }  
    }
}