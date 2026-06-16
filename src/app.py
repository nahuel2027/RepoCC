from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def home():
    return "<h3>Entorno de Desarrollo del Sistema de Eventos Activo con Docker!</h3>"

if __name__ == '__main__':
    # Es vital el host='0.0.0.0' para que Docker pueda mapear el puerto correctamente
    app.run(host='0.0.0.0', port=5000, debug=True)