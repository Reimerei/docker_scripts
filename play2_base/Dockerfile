########################################
## CREATES A BASE IMAGE FOR PLAY APPS ##
########################################
FROM ubuntu:latest

# update and install git and java
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git openjdk-6-jdk 

# make sure that java can see the hostname
RUN sed -i "s/^127.0.0.1/127.0.0.1 $(hostname) /" /etc/hosts

# add user
RUN useradd -m -s /bin/bash play
USER play
WORKDIR /home/play

# add sbt launcher
RUN get http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.0/sbt-launch.jar
ADD resources/sbt sbt
