#Parte 1
FROM gradle:8.14-jdk21 AS build
WORKDIR /app
COPY . .
RUN gradle build -x test --no-daemon

#Parte 2
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
