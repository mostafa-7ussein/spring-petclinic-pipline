<<<<<<< HEAD
FROM eclipse-temurin:latest 

WORKDIR /app

COPY . .

EXPOSE 8080

RUN ./mvnw package
CMD ["/bin/sh", "-c", "java -jar /app/target/*.jar"]
=======

FROM eclipse-temurin:latest AS builder
WORKDIR /app
COPY . .
EXPOSE 8080
RUN ./mvnw package

FROM eclipse-temurin:latest AS dev
WORKDIR /app
COPY --from=builder /app/target .
ENV STAGE="dev"
EXPOSE 8080
CMD ["/bin/sh", "-c", "java -jar *.jar"]

FROM eclipse-temurin:latest AS prod
WORKDIR /app
COPY --from=builder /app/target .
ENV STAGE="prod"
EXPOSE 8080
CMD ["/bin/sh", "-c", "java -jar *.jar"]
>>>>>>> 0ea2754274b265939ea7def96f6854ec542a0033
