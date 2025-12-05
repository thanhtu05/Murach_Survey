# Stage 1: Build the app using Maven (this creates the WAR file)
FROM maven:3.8.1-openjdk-17-slim AS builder

# Set the working directory inside the container for the build
WORKDIR /app

# Copy all your project files (pom.xml, src, etc.) into the container
COPY . .

# Run Maven to clean and build the WAR file (skip tests to speed up)
RUN mvn clean package -DskipTests

# Stage 2: Runtime environment with Tomcat (smaller image, no build tools)
FROM tomcat:9.0-jdk17-corretto

# Remove Tomcat's default webapps to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file from Stage 1 into Tomcat's webapps folder
# Adjust the WAR name if your pom.xml uses a different artifactId/version
COPY --from=builder /app/target/EmailListApp.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (Tomcat's default port for HTTP)
EXPOSE 8080
#
# Command to start Tomcat when the container runs
CMD ["catalina.sh", "run"]