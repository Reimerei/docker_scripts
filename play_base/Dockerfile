########################################
## CREATES A BASE IMAGE FOR PLAY APPS ##
########################################

FROM ubuntu:quantal

# update and install git and java
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git openjdk-6-jdk 

# add user
RUN useradd -m -s /bin/bash play
USER play