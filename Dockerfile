# Set up a docker machine that has all the tools to build the speck

FROM ubuntu
#FROM ubuntu:14.04
#FROM ubuntu:16.04

MAINTAINER Cullen Jennings <fluffy@iii.ca>

# set up basic build machine
RUN apt-get -y update --fix-missing
RUN apt-get -y upgrade 

RUN apt-get install -y build-essential 

RUN apt-get install -y python-pip python-dev
RUN pip install --upgrade pip

RUN apt-get install -y default-jre  default-jdk


# setup go 
RUN apt-get install -y golang git
RUN mkdir /go 
ENV PATH /go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV GOPATH /go

RUN apt-get install -y  nodejs npm
RUN ln -s `which nodejs` /usr/bin/node

RUN apt-get -y install tcsh

RUN apt-get install -y libxml2-dev libxslt-dev 
RUN pip install xml2rfc

# install tidy to relow XML 
RUN apt-get install -y tidy

# there must be a better way to intall mmark
RUN go get github.com/miekg/mmark
RUN ( cd /go/src/github.com/miekg/mmark/mmark ; make ; go install )

#RUN npm install -g raml2html
RUN npm install -g jayschema
RUN npm install -g json
#RUN npm install -g ramllint

#RUN go get -v github.com/spf13/hugo
RUN apt-get install -y hugo

#RUN go get github.com/kardianos/govendor
#RUN govendor get github.com/gohugoio/hugo
#RUN go install github.com/gohugoio/hugo

RUN apt-get install -y ruby ruby-dev ruby-bundler 
#RUN apt-get install -y rubygems
#RUN apt-get install -y ruby-json 
#RUN apt-get install -y ruby-full
#RUN gem install bundle

#RUN gem install kramdown-rfc2629
#RUN gem update

RUN npm install -g aglio

VOLUME /work
WORKDIR /work

CMD [ "/usr/bin/make", "all" ]

