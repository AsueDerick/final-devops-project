FROM ubuntu:18.04
RUN apt-get update && apt-get -y upgrade && apt-get -y install openjdk-8-jdk wget
RUN mkdir /usr/local/tomcat
COPY tomcat/apache-tomcat-9.0.95 /usr/local/tomcat/
COPY *.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]



