#MongoDB Image
FROM ubuntu:latest

# workaround
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

# Install latest mongo from 10gen 
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list
RUN apt-get update -y
RUN apt-get upgrade
RUN apt-get install mongodb-10gen=2.4.6
 
ENTRYPOINT ["mongod", "-f", "/data/mongodb.conf"]
