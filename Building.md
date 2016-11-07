
The website and specification can be build using an Docker image.

# Building a docker image with the tools 

Create a docker image with
```sh
docker build -t spad .
```

# Using docker to build the website

Build specification  with 
```sh
docker run -v `pwd`:/work spad
```

another usefull command to get a shell in the docker image is
```sh
docker run -it -v `pwd`:/work spad /usr/bin/tcsh
```
