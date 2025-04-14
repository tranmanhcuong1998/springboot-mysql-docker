# Stage 1: Build jar từ mã nguồn
FROM gradle:8.4-jdk17 AS builder
WORKDIR /home/app

COPY . .
RUN gradle build -x test

# Stage 2: Copy jar qua image chạy và thiết lập timezone
FROM openjdk:17-jdk-slim
WORKDIR /app

# Cài đặt tzdata và thiết lập timezone cho image này
RUN apt-get update && apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

COPY --from=builder /home/app/build/libs/*.jar app.jar
ENV JAVA_OPTS="-Xms256m -Xmx12288m -Xss8M"
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
