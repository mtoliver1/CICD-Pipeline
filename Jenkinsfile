pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'http://localhost:9000'
        DOCKER_IMAGE = 'mtolv/java-http-server:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/mtoliver1/CICD-Pipeline.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    docker.image('openjdk:17-jdk').inside {
                        sh 'mvn clean package'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    docker.image('openjdk:11-jdk').inside {
                        sh 'mvn test'
                    }
                }
            }
        }

        stage('Static Code Analysis') {
            steps {
                script {
                    docker.image('openjdk:8-jdk').inside {
                        sh "mvn sonar:sonar -Dsonar.host.url=${SONARQUBE_SERVER}"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                        sh "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
