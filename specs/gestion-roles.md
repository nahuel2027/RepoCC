# Spec: Gestión de Roles y Asignación de Disertantes

## 1. Objetivo y Contexto
Permitir que los organizadores del evento puedan administrar los privilegios de los usuarios, transformando a un participante común en "Disertante" para que su perfil sea público en la agenda del evento.

## 2. Historias de Usuario y Criterios de Aceptación
* **HU:** Como Organizador, quiero asignar el rol de Disertante a un usuario registrado para que figure como expositor en el programa.
    * **CA1:** El sistema solo debe permitir cambiar el rol a usuarios que ya estén inscriptos en el evento.
    * **CA2:** El cambio de rol debe reflejarse inmediatamente en la base de datos y en la vista pública del evento.

## 3. Requisitos Funcionales y Reglas de Negocio
* **RF1:** Panel de administración de usuarios por evento.
* **RF2:** Selector de roles (Participante / Disertante / Organizador).
* **RN1:** Solo un usuario con rol "Organizador" tiene permisos para modificar roles de otros.
* **RN2:** Un usuario no puede quitarse a sí mismo el rol de Organizador si es el único responsable del evento.

## 4. Restricciones técnicas específicas de este módulo
* El sistema debe validar los permisos de sesión (cookies/tokens) antes de procesar cualquier cambio de rol en el backend.

## 5. Modelo de datos de este módulo
* **Relación**: Se utiliza la tabla `inscripciones`.
* **Campo**: `id_rol` (FK hacia tabla Roles) o un campo `tipo_rol` (String: 'Participante', 'Disertante', 'Organizador').

## 6. Plan de Tareas
* [ ] Crear interfaz de gestión de usuarios dentro del panel del organizador.
* [ ] Desarrollar el endpoint (API) para actualizar el rol en la base de datos.
* [ ] Actualizar la vista de "Agenda" para que filtre y muestre a los usuarios con rol 'Disertante'.

## 7. Estrategia de Verificación
* **Prueba:** Intentar cambiar el rol de un usuario usando una cuenta de "Participante" y verificar que el sistema bloquee la acción con un error 403 (Prohibido).

### Avance de Roles
- Se definen permisos para Administrador, Organizador y Disertante.
