from datetime import datetime

# Simulación de base de datos de eventos
eventos_db = {
    1: {
        "titulo": "Congreso de Sistemas 2026",
        "cupo_maximo": 50,
        "inscriptos": 48,
        "fecha_limite": "2026-05-20"
    }
}

def registrar_inscripcion(usuario_id, evento_id):
    evento = eventos_db.get(evento_id)
    
    # 1. Validar si el evento existe
    if not evento:
        return "Error: Evento no encontrado."

    # 2. Validar Fecha Límite (Regla de Negocio RN1)
    fecha_actual = datetime.now().strftime("%Y-%m-%d")
    if fecha_actual > evento["fecha_limite"]:
        return "Error: La fecha límite de inscripción ha pasado."

    # 3. Validar Cupo Máximo (Regla de Negocio RF2)
    if evento["inscriptos"] >= evento["cupo_maximo"]:
        return "Error: Cupo agotado."

    # Si pasa las validaciones, se incrementa el inscripto
    evento["inscriptos"] += 1
    return f"¡Éxito! Usuario {usuario_id} inscripto al evento {evento_id}."

# Prueba de ejecución
print(registrar_inscripcion(usuario_id="AguileraNahuel", evento_id=1))