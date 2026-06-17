# Título: ADR-002 Implementación de Middleware de Control de Acceso Basado en Roles (RBAC) y OWASP Top 10
**Estado:** Aceptado  
**Fecha:** 2026-06-17  
**Decisores:** Aguilera Nahuel, Arndt Franco  
**Relacionado:** Spec `specs/gestion-roles.md`, Spec `specs/generacion-certificados.md`, Issue #8  

## Contexto
Durante la definición detallada de los requerimientos de "Gestión de Roles" y "Generación de Certificados", se identificó la vulnerabilidad crítica de escalada de privilegios y bypass de seguridad mediante la manipulación directa de parámetros o URLs (definido en los riesgos OWASP A01:2021 - Broken Access Control). Se necesita un componente arquitectónico centralizado que impida que un participante acceda a las rutas reservadas para el Organizador o el Disertante.

## Decisión
Se decide implementar un control de acceso perimetral en el backend mediante **Decoradores Personalizados de Python en Flask** que intercepten cada solicitud HTTP antes de resolver la lógica de negocio. El alcance cubre de forma estricta la validación en el servidor de la sesión y el rol asignado al usuario ('ORGANIZADOR', 'DISERTANTE', 'PARTICIPANTE'), prohibiendo delegar este tipo de validaciones de seguridad de forma exclusiva al frontend (JavaScript).

## Alternativas consideradas
- **Opción A (Elegida): Decoradores nativos de Python aplicados a rutas de Flask.** * **Pros:** Centralización de las políticas de seguridad de roles, código limpio y legible, acoplamiento directo con los modelos de la base de datos y mitigación nativa del riesgo OWASP A01.
  * **Contras:** Exige que los desarrolladores recuerden añadir explícitamente el decorador en cada nueva ruta que se programe.
- **Opción B: Validación visual únicamente en el Frontend.** * **Pros:** No consume recursos de procesamiento ni consultas adicionales en el servidor backend.
  * **Contras:** Vulnerabilidad extrema; cualquier usuario con conocimientos mínimos en herramientas de desarrollador del navegador podría forzar el renderizado de botones o invocar endpoints administrativos de forma directa.

## Consecuencias
- **Beneficios esperados:** Blindaje eficaz de las acciones críticas (como cambiar roles de usuarios o emitir PDF de certificados de asistencia) contra solicitudes maliciosas manipuladas desde el cliente.
- **Costos o riesgos que se aceptan:** Leve incremento en el tiempo de respuesta HTTP debido a la verificación de la sesión en cada Request contra la persistencia de datos.
- **Impacto en operación y equipo:** Obliga a los integrantes a incorporar los decoradores `@login_required` y `@role_required('ORGANIZADOR')` al extender funcionalidades del sistema.

## Plan de implementación
- **Pasos mínimos:** Crear el módulo de autenticación central `src/auth.py`, definir las funciones envolventes de verificación utilizando `functools.wraps`, e integrarlas en los controladores correspondientes.
- **Dependencias:** Uso de la librería estándar de Python `functools`.
- **Métrica de éxito:** 100% de los intentos de acceso no autorizados bloqueados con una respuesta HTTP estándar de código 403 (Forbidden/Prohibido).

## Triggers de revisión
- Adopción de esquemas de autenticación y autorización federados externos (ej: OAuth2 o proveedores como Auth0).
- Fecha sugerida de revisión: 2026-08-15.