FROM centos:7
ARG version
RUN mkdir -p /app
ADD build/libs/demo-${version}.jar /app/demo.jar
EXPOSE 8080
