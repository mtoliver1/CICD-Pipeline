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

        stage('Test (Java 11)') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-11').inside {
                        sh 'mvn test'
                    }
                }
            }
        }

        stage('Static Code Analysis (Java 21)') {
            steps {
                script {
                    docker.image('maven:3.9.6-eclipse-temurin-21').inside {
                        sh "mvn sonar:sonar -Dsonar.host.url=${SONARQUBE_SERVER}"
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
