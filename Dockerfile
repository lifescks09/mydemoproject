# Stage 1: Build the Java application
FROM maven:3.8.1-jdk-11 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

# Stage 2: Copy the WAR file to Nginx
FROM nginx:latest
COPY --from=build /home/app/target/hello-world.war /usr/share/nginx/html/hello-world.war

# Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
