FROM ubuntu:latest
MAINTAINER Ori Pekelman <ori@pekelman.com>
# We need mongodb
# Add 10gen official apt source to the sources list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list


# Hack for initctl not being available in Ubuntu
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
# Install MongoDB
RUN apt-get update
RUN apt-cache search mongodb
RUN apt-get install mongodb-10gen
# Create the MongoDB data directory
RUN mkdir -p /data/db
EXPOSE 27017
#The next one seems to be needed to mongo to run
ENV  LC_ALL C
CMD ["LC_ALL=C /usr/bin/mongod", "--smallfiles"]
#We need hadoop it, has dependencies
#RUN apt-get install -y rsync ssh
RUN apt-get install -y python-software-properties software-properties-common
RUN add-apt-repository ppa:hadoop-ubuntu/stable
RUN apt-get update
RUN apt-get -y install hadoop

#We want to be able to ssh in
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:changeme' |chpasswd
#
EXPOSE 22
CMD /usr/sbin/sshd -D
