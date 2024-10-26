FROM openjdk:11-jdk AS build
RUN mkdir app
WORKDIR /app
COPY target/ABCtechnologies-1.0.0.war ./ABCtechnologies-1.0.0.war

FROM tomcat:9-jdk11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/ABCtechnologies-1.0.0.war /usr/local/tomcat/webapps/ABCtechnologies.war
EXPOSE 8090
CMD ["catalina.sh", "run"]




