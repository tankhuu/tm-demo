FROM centos:7
ARG VERSION
RUN mkdir -p /home/demo
ADD *.jar /home/demo/app.jar
EXPOSE 8088
