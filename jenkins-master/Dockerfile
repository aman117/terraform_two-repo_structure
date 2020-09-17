FROM jenkins/jenkins:latest

# Install plugins
RUN /usr/local/bin/install-plugins.sh cloudbees-folder \
  antisamy-markup-formatter\
  build-timeout \
  credentials-binding\
  timestamper\
  ws-cleanup \
  ant\
  gradle \
  workflow-aggregator \
  github-organization-folder\
  pipeline-stage-view \
  git \
  ssh-slaves \
  matrix-auth pam-auth ldap \
  email-ext mailer \
  kubernetes \
  github-oauth \
  ansicolor

COPY configs/ /var/jenkins_home/
# Skip the setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

USER root
