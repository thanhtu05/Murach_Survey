# Stage 1: Build the app using Maven (Tối ưu hóa và fix build)
# Sử dụng Image Maven và JDK 17 ổn định hơn
FROM maven:3.9.6-openjdk-17-slim AS builder

# Set the working directory
WORKDIR /app

# 1. Copy pom.xml và tải dependencies (tăng tốc build bằng caching)
COPY pom.xml .
RUN mvn dependency:go-offline

# 2. Copy mã nguồn và Build
COPY src ./src

# Đảm bảo mã nguồn được copy đầy đủ trước khi build
# Thêm kiểm tra thư mục 'target'
RUN ls -l
RUN mvn clean package -DskipTests
RUN ls -l target/ # Dòng này giúp kiểm tra nếu tệp .war được tạo thành công

# --------------------------------------------------------------------------------

# Stage 2: Runtime environment with Tomcat 10.1 (Khuyến nghị cho JDK 17)
FROM tomcat:10.1-jdk17-temurin

# Remove Tomcat's default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file from Stage 1 into Tomcat's webapps folder
# Đảm bảo đường dẫn chính xác: /app/target/EmailListApp.war
COPY --from=builder /app/target/EmailListApp.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Command to start Tomcat
CMD ["catalina.sh", "run"]