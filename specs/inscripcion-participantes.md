# Spec: Inscripción de Participantes

## 1. Objetivo y Contexto
Permitir que los interesados en los eventos académicos puedan registrarse en la plataforma y asegurar su cupo de manera autónoma a través de la web.

## 2. Historias de Usuario y Criterios de Aceptación
* **HU:** Como participante, quiero inscribirme a una jornada para asegurar mi lugar.
    * **CA1:** El sistema debe confirmar la inscripción solo si el cupo máximo no ha sido alcanzado.
    * **CA2:** El usuario debe recibir un mensaje de confirmación tras el registro exitoso.

## 3. Requisitos Funcionales y Reglas de Negocio
* **RF1:** Formulario de captura de datos del participante.
* **RF2:** Validación de disponibilidad de cupo en tiempo real.
* **RN1:** La inscripción debe cerrarse automáticamente al llegar a la "Fecha límite de inscripción" definida en el evento.
* **RN2:** No se permiten inscripciones duplicadas para el mismo usuario en un mismo evento.

## 4. Restricciones técnicas específicas de este módulo
* El proceso de inscripción debe ser atómico para evitar que dos personas ocupen el último cupo simultáneamente (uso de transacciones en la base de datos).

## 5. Modelo de datos de este módulo
* **Tabla `inscripciones`**: `id_inscripcion` (PK), `id_usuario` (FK), `id_evento` (FK), `fecha_registro`, `estado`.

## 6. Plan de Tareas
* [ ] Diseñar la base de datos para la relación Usuario-Evento.
* [ ] Implementar la lógica de validación de cupos y fechas.
* [ ] Crear la interfaz web de formulario de inscripción.

## 7. Estrategia de Verificación
* **Prueba:** Intentar inscribirse a un evento con cupo máximo igual a cero y verificar que el sistema devuelva un error de "Cupo agotado".