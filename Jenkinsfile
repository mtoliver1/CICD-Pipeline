pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mtolv/java-http-server:latest'
        SONARQUBE_SERVER = 'http://sonarqube:9000'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/mtoliver1/CICD-Pipeline.git'
            }
        }

        stage('Build (Java 17)') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-17').inside {
                        sh 'mvn clean package'
                    }
                }
            }
        }

        stage('Static Code Analysis (Java 21)') {
    steps {
        script {
            withDockerContainer(image: 'maven:3.9.6-eclipse-temurin-21', args: '--network cicd-network') {
                withSonarQubeEnv('local-sonarqube') {
                    sh 'mvn sonar:sonar'
                    }
                }
            }
        }

        stage('Static Code Analysis (Java 21)') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-21').inside {
                        withSonarQubeEnv('local-sonarqube') {
                            sh 'mvn sonar:sonar'
                        }
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub', 
                    usernameVariable: 'DOCKER_USER', 
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
