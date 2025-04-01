FROM openjdk:17-jdk
WORKDIR /app
COPY . /app
RUN javac HttpServerApp.java
EXPOSE 8080
CMD ["java", "HttpServerApp"]
