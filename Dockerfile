FROM centos:7
RUN mkdir -p /app
ADD *.jar /app/demo.jar
EXPOSE 8080
