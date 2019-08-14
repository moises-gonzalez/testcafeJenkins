#Determine image to use
FROM jenkins/jenkins:2.187-slim
LABEL maintainer="mogonzal@advancedtech.com"

# Cache bursting and Data folders creation
USER root

RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins

RUN curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get update && apt-get install -y \
    nodejs \
    firefox-esr \
    xvfb \
    chromium \
    vim \
    && rm -rf /var/lib/apt/lists/*

USER jenkins

EXPOSE 8080

ENV JAVA_OPTS="-Xmx8192m"
ENV JENKINS_OPTS=" --handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"