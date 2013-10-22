FROM reimerei/play2_base

# run as user play
USER play

# get latest version of kolibrinet from github
RUN git clone https://github.com/KolibriNet/KolibriNetServer.git /home/play/kolibri

# compile
WORKDIR /home/play/kolibri
RUN ./sbt clean  
RUN ./sbt compile 
RUN ./sbt stage

# make port 9000 available to the outside world as port 80
EXPOSE 80:9000

# workaround to be able to resolve localhost from within Java
#RUN sed -i "s/^127.0.0.1/127.0.0.1 $(hostname) /" /etc/hosts

USER root
ENTRYPOINT sed -i "s/^127.0.0.1/127.0.0.1 $(hostname) /" /etc/hosts && less /etc/hosts && su play -c "/home/play/kolibri/sbt run"