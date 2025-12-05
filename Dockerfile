# Stage 1: Build the app using Maven (Tối ưu hóa và sử dụng tag tồn tại)
# Sử dụng Maven và JDK 11 (Tương thích tốt nhất với Tomcat 9.0/Java EE)
FROM maven:3.9-openjdk-11 AS builder

# Set the working directory
WORKDIR /app

# 1. Tận dụng Docker Cache: Copy pom.xml trước và tải dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# 2. Copy mã nguồn và Build
COPY src ./src
# Lệnh này sẽ tạo ra tệp /app/target/EmailListApp.war
RUN mvn clean package -DskipTests

# --------------------------------------------------------------------------------

# Stage 2: Runtime environment with Tomcat 9.0
# Sử dụng Tomcat 9.0 với JDK 11
FROM tomcat:9.0-jdk11-temurin

# Remove Tomcat's default webapps để tránh xung đột
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file từ Stage 1
# Tệp .war được tìm thấy ở /app/target/EmailListApp.war
COPY --from=builder /app/target/EmailListApp.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Command to start Tomcat
CMD ["catalina.sh", "run"]