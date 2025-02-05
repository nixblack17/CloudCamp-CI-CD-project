FROM amazoncorretto:17-al2-jdk AS builder
COPY . . 
RUN chmod +x gradlew && ./gradlew bootJar

FROM eclipse-temurin:17.0.14_7-jre-jammy AS runner
COPY --from=builder build/libs/cicd-0.0.1-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]