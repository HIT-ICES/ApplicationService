# 使用 JDK 8 的 Maven 镜像作为基础镜像
FROM maven:3.8.5-openjdk-8-slim AS builder

# 创建目录
RUN mkdir -p /opt/jmeter
RUN mkdir -p /opt/application

# 设置工作目录
WORKDIR /opt/application

# 复制 Maven 配置文件和源代码
COPY pom.xml .
COPY src ./src

# 暴露端口
EXPOSE 8848

# 构建发布工件
RUN mvn package -DskipTests

# 下载并解压 JMeter 5.6.2
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz -P /opt/jmeter && \
    tar -xzf /opt/jmeter/apache-jmeter-5.6.3.tgz -C /opt/jmeter --strip-components=1 && \
    rm /opt/jmeter/apache-jmeter-5.6.3.tgz

# 运行 Web 服务
CMD ["java", "-jar", "/opt/application/target/PressureMeasure-1.0-SNAPSHOT.jar"]
