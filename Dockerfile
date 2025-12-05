# Giai đoạn 1: Xây dựng (Build Stage)
# Sử dụng base image Maven với JDK 25 để xây dựng dự án
FROM maven:3.9.6-jdk-21 AS build

# LƯU Ý: Hiện tại chưa có image chính thức maven:jdk-25.
# Ta sử dụng JDK 21 để build vì nó tương thích ngược với mã được biên dịch bởi JDK 25
# hoặc bạn có thể tự build image maven:jdk-25 nếu cần.

# Đặt thư mục làm việc bên trong container
WORKDIR /app

# Sao chép tệp cấu hình Maven (pom.xml) để tận dụng caching
COPY pom.xml .

# Chạy dependency resolution (để tải thư viện)
RUN mvn dependency:go-offline

# Sao chép toàn bộ mã nguồn
COPY src ./src

# Đóng gói ứng dụng thành tệp .war
# Đảm bảo bạn đã chuyển các dependencies trong pom.xml sang Jakarta EE (jakarta.*)
RUN mvn package -DskipTests

# --------------------------------------------------------------------------------

# Giai đoạn 2: Triển khai (Runtime Stage)
# Sử dụng base image Tomcat 10.1 với JDK 21+ (tương thích tốt với JDK 25)
FROM tomcat:10.1-jdk21-temurin

# Đặt biến môi trường để đảm bảo Tomcat chạy ổn định hơn
ENV CATALINA_HOME /usr/local/tomcat

# Xóa các ứng dụng mặc định của Tomcat để tránh xung đột
RUN rm -rf $CATALINA_HOME/webapps/ROOT \
    $CATALINA_HOME/webapps/docs \
    $CATALINA_HOME/webapps/examples \
    $CATALINA_HOME/webapps/host-manager \
    $CATALINA_HOME/webapps/manager

# Sao chép tệp .war đã được xây dựng từ Build Stage sang thư mục webapps của Tomcat.
# Tên thư mục webapps/ROOT/ sẽ đảm bảo ứng dụng chạy ở context path gốc (/)
COPY --from=build /app/target/EmailListApp.war $CATALINA_HOME/webapps/ROOT.war

# Port mặc định mà Tomcat lắng nghe là 8080
EXPOSE 8080

# Lệnh khởi động Tomcat khi container chạy
CMD ["catalina.sh", "run"]