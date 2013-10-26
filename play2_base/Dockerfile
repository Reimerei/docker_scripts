########################################
## CREATES A BASE IMAGE FOR PLAY APPS ##
########################################
FROM ubuntu:latest

# update and install git and java
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git openjdk-6-jdk 

# add sbt launcher
ADD http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.0/sbt-launch.jar /opt/sbt-launch.jar
ADD resources/sbt /opt/sbt

# add scripts
ADD resources/build.sh /opt/build.sh
ADD resources/start.sh /opt/start.sh

EXPOSE 80:9000
