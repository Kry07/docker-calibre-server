FROM kry07/xorg:qt
MAINTAINER Kry <info.mayl@aol.com>
# FORKED from github.com/Ekito/docker-calibre-server

RUN apt-get update && apt-get install -y --no-install-recommends \
	calibre xvfb imagemagick rsyslog cron

RUN apt-get clean \
	&& rm -rf /var/cache/apt/* \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 8080

ENV LIBRARY /opt/calibre/library
ENV IMPORT /opt/calibre/import

# Create directory for library and directory to import files
RUN mkdir -p $LIBRARY $IMPORT
RUN chown user:user -R $LIBRARY $IMPORT
VOLUME $IMPORT

# Add crontab job to import books in the library
RUN echo "*/1 * * * * user /usr/bin/calibredb add $IMPORT --library-path $LIBRARY >> /var/log/cron.log 2>&1" > /etc/cron.d/calibre-update \
	&& chmod 0644 /etc/cron.d/calibre-update
RUN touch /var/log/cron.log \
	&& chown user:user /var/log/cron.log

# Run cron job and start calibre server as user
CMD cron && su user -c '/usr/bin/calibre-server --with-library=$LIBRARY'
