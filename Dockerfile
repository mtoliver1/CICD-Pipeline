# Start from the official Jenkins LTS image
FROM jenkins/jenkins:lts

# Switch to root to install tools
USER root

# Install Docker CLI and Git
RUN apt-get update && \
    apt-get install -y docker.io git && \
    apt-get clean

# Optional: add Maven or other tools here if needed later

# Keep running as root so Jenkins can access Docker socket
# USER jenkins  ← do NOT include this line
