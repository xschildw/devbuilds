FROM ubuntu:14.04
MAINTAINER Xavier Schildwachter <x.schildwachter@sagebase.org>

# From https://github.com/jplock/docker-oracle-java7/blob/master/Dockerfile
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

RUN apt-get install -y maven

RUN adduser --quiet jenkins --home /var/lib/jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN mkdir -p /var/lib/jenkins/.m2 && chown -R jenkins:jenkins /var/lib/jenkins/.m2/

USER jenkins
ENV M2=/usr/share/maven/bin M2_HOME=/usr/share/maven MAVEN_OPTS="-Xms256m -Xmx1024m -XX:MaxPermSize=256m"

CMD "/bin/bash"
