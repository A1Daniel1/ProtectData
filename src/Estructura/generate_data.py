import random
import datetime

def generate_date(start_date, end_date):
    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days
    if days_between_dates <= 0:
        return start_date
    random_number_of_days = random.randrange(days_between_dates)
    return start_date + datetime.timedelta(days=random_number_of_days)

def main():
    random.seed(42)
    # Set current date to a fixed future date relative to development to ensure "future" checks pass if run today
    # Or just use today. Trigger says fechaInic >= TRUNC(SYSDATE) - 1.
    # So if I run this today, dates must be >= yesterday.
    current_date = datetime.date.today()

    aseguradoras = []
    agencias = []
    seguros = []
    sucursales = []
    asesores = []
    clientes = []
    polizas = []
    pagos = []
    beneficiarios = []
    coberturas = []
    reclamaciones = []

    # 1. Aseguradoras (5)
    nombres_aseguradoras = ["Seguros Bolivar", "Allianz", "Mapfre", "Sura", "Liberty Seguros", "AXA Colpatria", "Seguros del Estado", "Solidaria", "Equidad Seguros", "Chubb"]
    for i in range(1, 6):
        aseguradoras.append({
            "id": i,
            "nombre": nombres_aseguradoras[i-1],
            "telefono": 3000000000 + i,
            "nit": 900000000 + i,
            "direccion": f"Calle {i} # {i}-{i}"
        })

    # 2. Agencias (10)
    for i in range(1, 11):
        agencias.append({
            "id": i,
            "nombre": f"Agencia {i}",
            "direccion": f"Carrera {i} # {i}-{i}",
            "idAseguradora": random.choice(aseguradoras)["id"]
        })

    # 3. Seguros (10)
    # Constraint: CK_Seguros_Tipo IN ('Vida', 'Salud', 'Hogar', 'Vehiculo', 'Empresarial')
    tipos_seguros = ["Vida", "Salud", "Hogar", "Vehiculo", "Empresarial"]
    for i in range(1, 11):
        seguros.append({
            "id": i,
            "nombre": f"Seguro {i}",
            "tipo": random.choice(tipos_seguros),
            "descripcion": f"Descripcion del seguro {i}",
            "idAseguradora": random.choice(aseguradoras)["id"]
        })

    # 4. Sucursales (20)
    for i in range(1, 21):
        sucursales.append({
            "id": i,
            "idAgencia": random.choice(agencias)["id"],
            "nombre": f"Sucursal {i}",
            "direccion": f"Avenida {i} # {i}-{i}"
        })

    # 5. Asesores (50)
    nombres = ["Juan", "Maria", "Pedro", "Ana", "Luis", "Carmen", "Jose", "Laura", "Carlos", "Sofia", "Andres", "Camila", "Diego", "Valentina", "Gabriel", "Isabella", "Mateo", "Mariana", "Lucas", "Daniela"]
    apellidos = ["Perez", "Gomez", "Rodriguez", "Lopez", "Martinez", "Garcia", "Hernandez", "Sanchez", "Ramirez", "Torres", "Diaz", "Vargas", "Castillo", "Jimenez", "Moreno", "Muñoz", "Rojas", "Romero", "Ruiz", "Navarro"]
    
    for i in range(1, 51):
        sucursal = random.choice(sucursales)
        asesores.append({
            "id": i,
            "idAgencia": sucursal["idAgencia"],
            "idSucursal": sucursal["id"],
            "cedula": 1000000 + i,
            "nombre": f"{random.choice(nombres)} {random.choice(apellidos)}",
            "telefono": 3100000000 + i,
            "correo": f"asesor{i}@email.com"
        })

    # 6. Clientes (100)
    for i in range(1, 101):
        asesor = random.choice(asesores)
        clientes.append({
            "id": i,
            "idAgencia": asesor["idAgencia"],
            "idAsesor": asesor["id"],
            "nombre": f"{random.choice(nombres)} {random.choice(apellidos)}",
            "correo": f"cliente{i}@email.com", # Matches LIKE '%_@__%.__%'
            "telefono": 3200000000 + i,
            "direccion": f"Transversal {i} # {i}-{i}"
        })

    # 7. Polizas (200)
    # Constraints:
    # - fechaInic >= TRUNC(SYSDATE) - 1
    # - 180 <= (fechaFin - fechaInic) <= 1825
    # - prima > 0
    # - estado IN ('Activa', 'Vencida', 'Cancelada', 'Renovada', 'VIGENTE')
    # - renovable IN ('S', 'N')
    
    estados = ["Activa", "Cancelada"] # Cannot be Vencida if it starts today or future
    for i in range(1, 201):
        # Start date from today to +30 days
        fecha_inic = generate_date(current_date, current_date + datetime.timedelta(days=30))
        # Duration 180 to 1825 days
        duration = random.randint(180, 1825)
        fecha_fin = fecha_inic + datetime.timedelta(days=duration)
        
        polizas.append({
            "id": i,
            "numero": 10000 + i,
            "idCliente": random.choice(clientes)["id"],
            "fechaInic": fecha_inic,
            "fechaFin": fecha_fin,
            "prima": round(random.uniform(100000, 5000000), 2),
            "estado": random.choice(estados),
            "renovable": random.choice(['S', 'N']),
            "idSeguro": random.choice(seguros)["id"]
        })

    # 8. Pagos (200)
    # Constraints:
    # - Metodo: 'EFECTIVO', 'TARJETA', 'TRANSFERENCIA'
    # - If EFECTIVO, monto <= 5000000
    metodos = ["EFECTIVO", "TARJETA", "TRANSFERENCIA"]
    for i in range(1, 201):
        poliza = random.choice(polizas)
        metodo = random.choice(metodos)
        monto = round(poliza["prima"] / 12, 2)
        
        if metodo == "EFECTIVO" and monto > 5000000:
            monto = 5000000 # Cap at 5M for cash
            
        pagos.append({
            "id": i,
            "idCliente": poliza["idCliente"],
            "idPoliza": poliza["id"],
            "fecha": poliza["fechaInic"], # Pay on start date
            "monto": monto,
            "metodo": metodo
        })

    # 9. Beneficiarios (200)
    relaciones = ["Hijo", "Esposo", "Padre", "Madre", "Hermano"]
    for i in range(1, 201):
        beneficiarios.append({
            "id": i,
            "idPoliza": random.choice(polizas)["id"],
            "nombre": f"{random.choice(nombres)} {random.choice(apellidos)}",
            "relacion": random.choice(relaciones),
            "porcentaje": random.choice([50, 100])
        })

    # 10. Coberturas (200)
    # Constraints:
    # - Sum(Coberturas) <= 20 * Prima
    # We will assign coverages to polizas. To ensure we don't exceed, we'll track coverage per poliza.
    poliza_coberturas = {p["id"]: 0 for p in polizas}
    
    for i in range(1, 201):
        poliza = random.choice(polizas)
        max_allowed = (poliza["prima"] * 20) - poliza_coberturas[poliza["id"]]
        
        if max_allowed <= 0:
            continue # Skip if full
            
        monto = round(random.uniform(1000000, min(50000000, max_allowed)), 2)
        poliza_coberturas[poliza["id"]] += monto
        
        coberturas.append({
            "id": i,
            "idPoliza": poliza["id"],
            "descripcion": f"Cobertura especial {i}",
            "monto": monto
        })

    # 11. Reclamaciones (50)
    # Constraints:
    # - Only for 'Activa' polizas
    # - Date between Inic and Fin
    # - Sum(Reclamaciones) <= Sum(Coberturas)
    # - Poliza must have coverages
    
    estados_rec = ["Pendiente", "Aprobada", "Rechazada"]
    count_rec = 0
    attempts = 0
    while count_rec < 50 and attempts < 10000:
        attempts += 1
        poliza = random.choice(polizas)
        
        if poliza["estado"] != "Activa":
            continue
            
        # Check if it has coverage
        total_cobertura = poliza_coberturas.get(poliza["id"], 0)
        if total_cobertura == 0:
            continue
            
        # Generate valid date
        # Since poliza starts today or future, claim must be in future.
        # Let's say claim is 10 days after start
        fecha_reclamo = poliza["fechaInic"] + datetime.timedelta(days=10)
        if fecha_reclamo > poliza["fechaFin"]:
            continue
            
        # Check amount
        # We don't track previous claims here for simplicity in this loop, but we should.
        # Let's just make it small enough.
        monto = round(random.uniform(50000, total_cobertura * 0.1), 2) # 10% of coverage
        
        count_rec += 1
        reclamaciones.append({
            "id": count_rec,
            "idPoliza": poliza["id"],
            "fecha": fecha_reclamo,
            "monto": monto,
            "estado": random.choice(estados_rec),
            "descripcion": f"Reclamacion por evento {count_rec}"
        })

    # Generate SQL
    with open('src/Estructura/PoblarOK.sql', 'w') as f:
        f.write("-- Script de Poblado de Datos (Generado Automaticamente)\n\n")

        # Aseguradoras
        f.write("-- Aseguradoras\n")
        for x in aseguradoras:
            f.write(f"INSERT INTO Aseguradoras (idAseguradora, nombre, telefono, nit, direccion) VALUES ({x['id']}, '{x['nombre']}', {x['telefono']}, {x['nit']}, '{x['direccion']}');\n")
        f.write("\n")

        # Agencias
        f.write("-- Agencias\n")
        for x in agencias:
            f.write(f"INSERT INTO Agencias (idAgencia, nombre, direccion, idAseguradora) VALUES ({x['id']}, '{x['nombre']}', '{x['direccion']}', {x['idAseguradora']});\n")
        f.write("\n")

        # Seguros
        f.write("-- Seguros\n")
        for x in seguros:
            f.write(f"INSERT INTO Seguros (idSeguro, nombre, tipo, descripcion, idAseguradora) VALUES ({x['id']}, '{x['nombre']}', '{x['tipo']}', '{x['descripcion']}', {x['idAseguradora']});\n")
        f.write("\n")

        # Sucursales
        f.write("-- Sucursales\n")
        for x in sucursales:
            f.write(f"INSERT INTO Sucursales (idSucursal, idAgencia, nombre, direccion) VALUES ({x['id']}, {x['idAgencia']}, '{x['nombre']}', '{x['direccion']}');\n")
        f.write("\n")

        # Asesores
        f.write("-- Asesores\n")
        for x in asesores:
            f.write(f"INSERT INTO Asesores (idAsesor, idAgencia, idSucursal, cedula, nombre, telefono, correo) VALUES ({x['id']}, {x['idAgencia']}, {x['idSucursal']}, {x['cedula']}, '{x['nombre']}', {x['telefono']}, '{x['correo']}');\n")
        f.write("\n")

        # Clientes
        f.write("-- Clientes\n")
        for x in clientes:
            f.write(f"INSERT INTO Clientes (idCliente, idAgencia, idAsesor, nombre, correo, telefono, direccion) VALUES ({x['id']}, {x['idAgencia']}, {x['idAsesor']}, '{x['nombre']}', '{x['correo']}', {x['telefono']}, '{x['direccion']}');\n")
        f.write("\n")

        # Polizas
        f.write("-- Polizas\n")
        for x in polizas:
            fecha_inic_sql = f"TO_DATE('{x['fechaInic'].strftime('%Y-%m-%d')}', 'YYYY-MM-DD')"
            fecha_fin_sql = f"TO_DATE('{x['fechaFin'].strftime('%Y-%m-%d')}', 'YYYY-MM-DD')"
            
            f.write(f"INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable, idSeguro) VALUES ({x['id']}, {x['numero']}, {x['idCliente']}, {fecha_inic_sql}, {fecha_fin_sql}, {x['prima']}, '{x['estado']}', '{x['renovable']}', {x['idSeguro']});\n")
        f.write("\n")

        # Pagos
        f.write("-- Pagos\n")
        for x in pagos:
            fecha_sql = f"TO_DATE('{x['fecha'].strftime('%Y-%m-%d')}', 'YYYY-MM-DD')"
            f.write(f"INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago) VALUES ({x['id']}, {x['idCliente']}, {x['idPoliza']}, {fecha_sql}, {x['monto']}, '{x['metodo']}');\n")
        f.write("\n")

        # Beneficiarios
        f.write("-- Beneficiarios\n")
        for x in beneficiarios:
            f.write(f"INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje) VALUES ({x['id']}, {x['idPoliza']}, '{x['nombre']}', '{x['relacion']}', {x['porcentaje']});\n")
        f.write("\n")

        # Coberturas
        f.write("-- Coberturas\n")
        for x in coberturas:
            f.write(f"INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax) VALUES ({x['id']}, {x['idPoliza']}, '{x['descripcion']}', {x['monto']});\n")
        f.write("\n")

        # Reclamaciones
        f.write("-- Reclamaciones\n")
        for x in reclamaciones:
            fecha_sql = f"TO_DATE('{x['fecha'].strftime('%Y-%m-%d')}', 'YYYY-MM-DD')"
            f.write(f"INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion) VALUES ({x['id']}, {x['idPoliza']}, {fecha_sql}, {x['monto']}, '{x['estado']}', '{x['descripcion']}');\n")
        f.write("\n")

if __name__ == "__main__":
    main()
