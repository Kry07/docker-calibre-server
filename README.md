#### docker-calibre

A Docker-file to create a calibre server with automatic books import

##### Dockerfile

This Containers depends on: 
- [`kry07/xorg:qt`  (Dockerfile), ](https://github.com/Kry07/docker-xorg/blob/qt/Dockerfile)
because calibre needs an xserver and qt5 librarys

A user *"user"* is created, because **you should never run X as root !**

##### Environment variables
*LIBRARY /opt/calibre/library* - Sets the directory for the calibre library.
*IMPORT /opt/calibre/import* - Sets the directory for the book import.

#### How to build the image 

`sudo docker build -t kry07/calibre-server`

#### Run the container

`sudo docker run -d -t -i -p 8080:8080 -v ~/ebooks:/opt/calibre/import kry07/calibre-server`
