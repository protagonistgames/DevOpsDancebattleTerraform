# docker build -f Dockerfile -t protag/terraform-tools .

FROM debian:stable-slim

# install curl
RUN apt-get update 
RUN apt-get install -y curl

RUN apt-get install -y lsb-release
# ... for apt-add-repository
RUN apt-get install -y software-properties-common

# GPG key for hashicorp
RUN apt-get install -y gnupg2
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -

# hashicorp repo
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# update and install terraform
RUN apt-get update && apt-get install -y terraform

RUN terraform -install-autocomplete

# install AWS CLI
RUN apt-get install -y unzip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Could maybe use IAM roles, if this image is run in AWS.
# Run aws configure, somehow to get access key, etc in place.

RUN apt-get install -y less
