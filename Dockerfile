FROM centos:7
ARG VERSION
RUN mkdir -p /app
ADD demo-${VERSION}.jar /app/demo.jar
EXPOSE 8080
