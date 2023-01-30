# Maven build container 

FROM maven:3.8.5-openjdk-11-slim AS maven_build

WORKDIR /app

COPY pom.xml .

COPY src /app/src

RUN mvn clean package

#pull base image

FROM openjdk:11-jdk-slim-bullseye

FROM tomcat:7.0.82-jre8

COPY --from=maven_build /app/target/hello-world-0.1.0.jar /usr/local/tomcat/webapps

#expose port 8080
EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]

