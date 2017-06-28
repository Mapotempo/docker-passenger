NGinx Passenger Docker image
============================

This is the base image used to deploy Mapotempo components.

Buiding image
-------------

To build the image, just run the following command:

    docker build --tag mapotempo/nginx-passenger:latest .

Publishing image
----------------

In order to have it available to the other components, you need to publish it
on hub.docker.com:

    docker login
    docker push mapotempo/nginx-passenger:latest
