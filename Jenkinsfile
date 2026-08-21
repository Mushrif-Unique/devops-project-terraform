pipeline {
    agent any

    environment {
        IMAGE_NAME = "nawasmushrif/devops-project-terraform"
        IMAGE_TAG = "${BUILD_NUMBER}"
        EC2_HOST  = "52.62.187.33"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $IMAGE_NAME:$IMAGE_TAG .
                    docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials-terraform',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login \
                            -u "$DOCKER_USER" \
                            --password-stdin

                        docker push $IMAGE_NAME:$IMAGE_TAG
                        docker push $IMAGE_NAME:latest

                        docker logout
                    '''
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['terraform-ec2-ssh']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_HOST "
                            docker pull $IMAGE_NAME:$IMAGE_TAG

                            docker stop devops-project-terraform || true
                            docker rm devops-project-terraform || true

                            docker run -d \
                                --name devops-project-terraform \
                                --restart unless-stopped \
                                -p 80:80 \
                                $IMAGE_NAME:$IMAGE_TAG

                            docker ps
                        "
                    '''
                }
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    sleep 5

                    curl -f http://$EC2_HOST/ || exit 1

                    echo "Application is healthy!"
                '''
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check the Jenkins console output.'
        }
    }
}