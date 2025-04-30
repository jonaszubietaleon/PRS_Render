# Usamos una imagen base con OpenJDK 17 y Alpine para optimizar el tamaño de la imagen
FROM eclipse-temurin:17-jdk-alpine

# Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos el archivo mvnw y el directorio .mvn al contenedor
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Ejecutamos Maven para descargar las dependencias sin ejecutar pruebas
RUN chmod +x mvnw && ./mvnw dependency:go-offline

# Copiamos el directorio src (código fuente) al contenedor
COPY src src

# Compilamos el proyecto y empaquetamos el JAR (sin ejecutar pruebas)
RUN ./mvnw clean package -DskipTests

# Exponemos el puerto 8080 para la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación cuando el contenedor inicie
CMD ["java", "-jar", "target/vg-ms-casas-0.0.1-SNAPSHOT.jar"]
