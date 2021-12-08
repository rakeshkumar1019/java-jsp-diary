FROM openjdk:8-jdk-alpine as build
COPY . /usr/app
WORKDIR /usr/app
RUN chmod +x mvnw \
    && ./mvnw --version \
    && ./mvnw clean package

FROM openjdk:8-jre-alpine
COPY --from=build /usr/app/target/*.war app.war
EXPOSE 8081

ENTRYPOINT ["java","-jar","app.war"]