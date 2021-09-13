FROM maven:3.8.2-openjdk-8 as builder
RUN mkdir /build
WORKDIR /build
COPY src /build
COPY pom.xml /build
RUN mvn -DskipTests=true clean install -Denvironment=oss

