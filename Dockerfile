FROM docker.io/library/tomcat:9.0
COPY target/ABCtechnologies-1.0.0.war /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]




