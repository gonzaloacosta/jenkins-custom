FROM jenkins/jenkins:lts 

USER root

LABEL name="Maven, Python and AWS CLI Image on JenkinsCI" \    
        maintainer="Gonzalo Acosta <gonzalo.acosta@semperti.com>" \
        vendor="Semperti" \
        release="2" \
        summary="A Maven, Python and AWS CLI based image on JenkinsCI" 

ARG MAVEN_VERSION=3.5.4

# maven 
RUN apt-get update \
    && apt-get install -y curl jq \ 
    && curl -so /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz http://apache.cs.utah.edu/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && tar xzf /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt/ \
    && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
    && ln -s /opt/maven/bin/mvn /usr/local/bin \ 
    && rm -f /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz \ 
    && chown -R jenkins:jenkins /opt/maven 

# awscli awseb
RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        groff \
        less \
    && pip3 install --upgrade pip \
    && pip3 install --upgrade awscli \
    && pip3 install --upgrade awsebcli \
    && apt-get clean

# npm
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
    && apt-get install -y nodejs \
    && curl -L https://www.npmjs.com/install.sh | sh

ENV MAVEN_HOME /opt/maven
ENV MAVEN_VERSION=${MAVEN_VERSION}
ENV M2_HOME /usr/share/maven
ENV maven.home $M2_HOME
ENV M2 $M2_HOME/bin
ENV PATH $M2:$PATH

USER jenkins
