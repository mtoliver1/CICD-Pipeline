# Start from the official Jenkins LTS image
FROM jenkins/jenkins:lts

# Switch to root to install packages
USER root

# Install Docker CLI and Git
RUN apt-get update && \
    apt-get install -y docker.io git && \
    apt-get clean

# (Optional) You can install additional tools here if needed (like Maven or Java versions)

# Do NOT switch back to 'jenkins' user
# Keeping Jenkins running as root so it can access the Docker socket
# USER jenkins
