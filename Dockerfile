FROM ubuntu:18.04
RUN apt-get update && apt-get -y upgrade && apt-get -y install openjdk-8-jdk wget
RUN mkdir /usr/local/tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.86/bin/apache-tomcat-9.0.86.tar.gz -O /tmp/apache-tomcat-9.0.86.tar.gz \
    && tar xvfz /tmp/apache-tomcat-9.0.86.tar.gz -C /usr/local/tomcat --strip-components=1 \
    && rm /tmp/apache-tomcat-9.0.86.tar.gz
COPY *.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]


