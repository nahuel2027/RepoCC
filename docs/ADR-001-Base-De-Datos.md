# ADR-001: Elección de PostgreSQL como motor de base de datos

**Estado:** Aceptado
**Fecha:** 2026-06-16
**Decisores:** Franco Emanuel Arndt, Nahuel Alexander Aguilera
**Relacionado:** Issue recién creado en GitHub, project.md

## Contexto
- **Qué problema se está resolviendo:** El sistema de gestión de eventos necesita almacenar de forma persistente y segura la información de los participantes, los roles asignados, el estado de las acreditaciones y el registro de los certificados generados.
- **Qué restricciones aplican:** Es imperativo mantener la integridad relacional de los datos (por ejemplo, un certificado no puede existir si no está vinculado a un participante acreditado). Se requiere un soporte robusto para transacciones ACID.
- **Qué datos de proyecto sustentan la decisión:** Las especificaciones del módulo de acreditación y generación automatizada de certificados demandan consultas complejas cruzando múltiples tablas.

## Decisión
**Qué se decide exactamente:**
Se decide utilizar PostgreSQL como el motor de base de datos relacional principal para el entorno de desarrollo y futura producción.
- **Alcance:** Cubre el almacenamiento de todos los datos transaccionales y de negocio del sistema de eventos.

## Alternativas consideradas
- **Opción A (MySQL/MariaDB):** - *Pros:* Amplia adopción, rápido para operaciones de lectura. 
  - *Contras:* Menor rigurosidad en el cumplimiento de algunos estándares SQL en configuraciones por defecto comparado con PostgreSQL.
- **Opción B (MongoDB - NoSQL):** - *Pros:* Esquema flexible, excelente escalabilidad horizontal. 
  - *Contras:* Carece de esquema relacional estricto, lo que dificulta mantener la integridad de los vínculos complejos entre usuarios, eventos y roles sin agregar lógica extra en el backend.

## Consecuencias
- **Beneficios esperados:** Fuerte integridad de datos, excelente integración con el ecosistema de Python, y capacidad de escalar verticalmente de manera segura.
- **Costos o riesgos que se aceptan:** Mayor consumo inicial de memoria RAM en el contenedor comparado con motores más livianos (como SQLite).
- **Impacto en operación y equipo:** El equipo debe mantener la configuración de Docker Compose para asegurar que todos los desarrolladores tengan la misma versión (15-alpine) corriendo localmente.

## Plan de implementación
- **Pasos mínimos para ejecutarla:** Configurar el servicio `db` en el archivo `docker-compose.yml` utilizando la imagen oficial de Postgres, exponer el puerto 5432 y configurar las variables de entorno de autenticación. *(Nota: Este paso ya fue completado en la fase de configuración de entornos).*

## Dependencias
- Motor de contenedores (Docker Desktop) para orquestación local.

## Métrica de éxito
- Capacidad de levantar el contenedor localmente y establecer conexión exitosa desde la aplicación web backend sin pérdida de datos tras reiniciar el servicio.

## Triggers de revisión
- **Qué condiciones obligan a reabrir esta ADR:** Si el volumen de usuarios consultando y descargando certificados simultáneamente genera bloqueos prolongados o si los tiempos de respuesta de lectura superan los umbrales aceptables.
- **Fecha sugerida de revisión:** Antes del despliegue a un entorno de pruebas (Staging).