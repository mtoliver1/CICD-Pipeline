FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y docker.io && \
    groupadd -for -g 0 docker && \
    usermod -aG docker jenkins

USER jenkins
