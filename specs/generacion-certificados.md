# Spec: Generación Automática de Certificados

## 1. Objetivo y Contexto
Automatizar la emisión de comprobantes de asistencia y participación en formato PDF, garantizando que solo los alumnos acreditados puedan obtenerlos una vez finalizado el evento.

## 2. Historias de Usuario y Criterios de Aceptación
* **HU:** Como participante acreditado, quiero descargar mi certificado de asistencia para presentarlo en mi institución.
    * **CA1:** El botón de descarga solo debe estar habilitado si el campo `asistio` es Verdadero.
    * **CA2:** El PDF generado debe contener nombre completo, DNI, nombre del evento y carga horaria.

## 3. Requisitos Funcionales y Reglas de Negocio
* **RF1:** Generador de archivos PDF dinámicos.
* **RF2:** Plantilla base de certificado con logo de la UNaM.
* **RN1:** Solo se generan certificados para eventos cuya "Fecha de finalización" ya haya pasado.
* **RN2:** Los datos del certificado (nombre y apellido) deben ser inalterables por el usuario.

## 4. Restricciones técnicas específicas de este módulo
* Se debe utilizar la librería `FPDF` o `ReportLab` en Python. El proceso de generación no debe bloquear el hilo principal del servidor (uso de tareas asíncronas si el volumen de certificados es alto).

## 5. Modelo de datos de este módulo
* **Consulta**: Requiere unir `usuarios` (para el nombre), `eventos` (para el título/horas) e `inscripciones` (para validar `asistio = True`).

## 6. Plan de Tareas
* [ ] Diseñar el layout (disposición) del certificado en código Python.
* [ ] Crear la lógica que valida la asistencia antes de permitir la generación.
* [ ] Implementar la descarga directa del archivo desde el perfil del usuario.

## 7. Estrategia de Verificación
* **Prueba:** Acceder con un usuario que NO tiene marcada la asistencia e intentar forzar la URL de descarga del certificado. El sistema debe denegar el acceso.
### Avance de Certificados
- Definición de formato PDF y campos automáticos (Nombre, DNI, Evento).
- Lógica de generación automática validada.