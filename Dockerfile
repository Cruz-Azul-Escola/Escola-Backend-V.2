# ==========================================
# Estágio 1: Build da aplicação com Maven e JDK 11
# ==========================================
FROM maven:3.9.6-eclipse-temurin-11 AS build

WORKDIR /app

# Copia o arquivo de configuração do Maven e baixa dependências (melhora o cache)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copia o código-fonte e gera o pacote .war (executando os testes de validação)
COPY src ./src
RUN mvn clean package -B

# ==========================================
# Estágio 2: Runtime com Apache Tomcat 10.1 (Jakarta EE 9 / Servlet 5.0)
# ==========================================
FROM tomcat:10.1-jdk11-temurin

# Remove as aplicações padrão do Tomcat e publica o .war na raiz (ROOT.war)
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
