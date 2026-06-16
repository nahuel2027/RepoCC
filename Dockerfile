# 1. Usar una imagen oficial de Python como base
FROM python:3.12-slim

# 2. Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# 3. Copiar el archivo de requerimientos primero para aprovechar la caché de Docker
COPY requirements.txt .

# 4. Instalar las librerías necesarias
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar todo el contenido del proyecto a la carpeta de trabajo
COPY . .

# 6. Exponer el puerto en el que corre Flask
EXPOSE 5000

# 7. Comando para ejecutar la aplicación en modo desarrollo
CMD ["python", "src/app.py"]