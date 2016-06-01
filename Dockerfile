FROM ubuntu:14.04
MAINTAINER Xavier Schildwachter <x.schildwachter@sagebase.org>

RUN apt-get update && apt-get upgrade

# From https://github.com/jplock/docker-oracle-java7/blob/master/Dockerfile
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

#RUN apt-get install -y openssh-server
#RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
#RUN mkdir -p /var/run/sshd

RUN apt-get install -y maven

RUN adduser --quiet jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN mkdir /home/jenkins/.m2
RUN chown -R jenkins:jenkins /home/jenkins/.m2/

#EXPOSE 22

#CMD ["/usr/sbin/sshd", "-D"] 
