FROM ubuntu:18.04

ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

RUN apt-get update && \
  apt-get install -y gnupg2 && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get dist-upgrade -y && \
  apt-get --purge remove openjdk* && \
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y git && \
  apt-get install -y maven && \
  apt-get install -y gradle && \
  apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
  apt-get clean all

ENV IDEA_JDK /usr/lib/jvm/java-8-oracle

ENTRYPOINT ["/opt/idea-IC-183.4886.37/bin/idea.sh"]

USER root

ADD https://download-cf.jetbrains.com/idea/ideaIC-2018.3.2.tar.gz /opt/idea.tar.gz

RUN tar --extract --verbose --directory /opt --file /opt/idea.tar.gz && rm -rf /opt/idea-IC-183.4886.37/jre64 && rm -f /opt/idea.tar.gz

RUN useradd -ms /bin/bash intellij

USER intellij
WORKDIR /home/intellij