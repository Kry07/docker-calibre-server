# docker-calibre

A Docker-file to create a calibre server with automatic books import

## Build the image 

`sudo docker build -t kry07/calibre-server`

## Run the container

`sudo docker run -d -t -i -p 8080:8080 -v ~/ebooks:/opt/calibre/import kry07/calibre-server`
