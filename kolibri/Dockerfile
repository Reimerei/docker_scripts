FROM play2_base

# get latest version of kolibrinet from github
RUN git clone https://github.com/KolibriNet/KolibriNetServer.git /opt/kolibri

# build app 
ENV APP_DIR /opt/kolibri
RUN /opt/build.sh 

# add scripts for updating
#ADD resources/update.sh /opt/update.sh

ENTRYPOINT /opt/start.sh
