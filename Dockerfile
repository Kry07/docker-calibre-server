FROM kry07/xorg:qt
MAINTAINER Kry <info.mayl@aol.com>
# FORKED from github.com/Ekito/docker-calibre-server

RUN apt-get update && apt-get install -y --no-install-recommends \
	calibre xvfb imagemagick rsyslog cron

RUN apt-get clean \
	&& rm -rf /var/cache/apt/* \
	&& rm -rf /var/lib/apt/lists/*

ENV LIBRARY /home/user/library
ENV IMPORT /home/user/import

USER user

# Create directory for library and directory to import files
RUN mkdir -p $LIBRARY $IMPORT
VOLUME $LIBRARY $IMPORT

# Add import.sh to import books in the library
RUN echo "/usr/bin/calibredb add \$IMPORT --library-path \$LIBRARY >> /home/user/import.log 2>&1" > /home/user/import.sh \
	&& chmod +x /home/user/import.sh \
	&& touch /home/user/import.log

EXPOSE 8080

# Run import.sh and start calibre server as user
CMD /home/user/import.sh && /usr/bin/calibre-server --with-library=$LIBRARY
