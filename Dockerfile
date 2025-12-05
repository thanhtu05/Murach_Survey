# Giai đoạn 1: Xây dựng (Build Stage)
# Sử dụng base image Maven với JDK 21 (tương thích tốt nhất hiện nay)
FROM maven:3.9.6-jdk-21 AS build

# Đặt thư mục làm việc
WORKDIR /app

# Sao chép và tải dependencies (để tận dụng caching)
COPY pom.xml .
RUN mvn dependency:go-offline

# Sao chép mã nguồn và đóng gói
COPY src ./src
RUN mvn package -DskipTests

# --------------------------------------------------------------------------------

# Giai đoạn 2: Triển khai (Runtime Stage)
# Sử dụng base image Tomcat 10.1 với JDK 21
FROM tomcat:10.1-jdk21-temurin

# Thiết lập biến môi trường
ENV CATALINA_HOME /usr/local/tomcat

# Xóa các ứng dụng mặc định của Tomcat
RUN rm -rf $CATALINA_HOME/webapps/ROOT \
    $CATALINA_HOME/webapps/docs \
    $CATALINA_HOME/webapps/examples \
    $CATALINA_HOME/webapps/host-manager \
    $CATALINA_HOME/webapps/manager

# Sao chép tệp .war đã được xây dựng từ Build Stage sang thư mục webapps của Tomcat.
# Đặt tên là ROOT.war để chạy ứng dụng ở context path gốc (/)
COPY --from=build /app/target/EmailListApp.war $CATALINA_HOME/webapps/ROOT.war

# Port mặc định mà Tomcat lắng nghe là 8080 (Render sẽ cần biết cổng này)
EXPOSE 8080

# Lệnh KHỞI ĐỘNG CHÍNH (Render sẽ tự động chạy lệnh này nếu ô Start Command bị bỏ trống)
CMD ["catalina.sh", "run"]