# Start from the official Jenkins LTS image
FROM jenkins/jenkins:lts

# Switch to root to install Docker
USER root

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y docker.io

# NOTE: Do NOT switch back to the jenkins user
# This allows Jenkins to use the host Docker socket (/var/run/docker.sock)
# USER jenkins
