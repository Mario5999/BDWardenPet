# 🐾 WardenPet - Base de Datos con Docker Compose

Configuración completa de PostgreSQL para la aplicación WardenPet usando Docker Compose.

## 📋 Contenido

- **docker-compose.yml**: Configuración de PostgreSQL 16 con volúmenes persistentes
- **init.sql**: Creación de tablas (usuarios, mascotas, recordatorios, registros de salud, rutinas)
- **init-admin.sql**: Creación de usuario administrador por defecto
- **.env**: Variables de entorno (copiar a .env.local para personalizar)

## 🚀 Inicio Rápido

### 1. Iniciar la base de datos

```bash
docker-compose up -d
```

### 2. Verificar que esté funcionando

```bash
docker-compose ps
```

### 3. Conectarse a PostgreSQL

```bash
# Usando psql dentro del contenedor
docker-compose exec postgres psql -U wardenpet_user -d wardenpet_db

# O desde tu máquina (necesitas psql instalado)
psql -h localhost -U wardenpet_user -d wardenpet_db
```

## 🔐 Credenciales por Defecto

- **Usuario**: wardenpet_user
- **Contraseña**: wardenpet_secure_pass
- **Base de datos**: wardenpet_db
- **Admin**: admin@wardenpet.com / admin123

## 📊 Tablas Creadas

### `users` - Usuarios del sistema
- ID (UUID)
- Nombre, Email (único), Contraseña
- Rol (user/admin)
- Timestamps

### `pets` - Mascotas
- ID (UUID)
- Usuario (referencia)
- Nombre, tipo, edad, raza, peso
- Imagen (URL/base64)

### `reminders` - Recordatorios
- ID (UUID)
- Usuario y Mascota (referencias)
- Tipo (vaccine, bath, vet, grooming, other)
- Título, descripción, fecha
- Estado (completado/pendiente)

### `health_records` - Registros de salud
- ID (UUID)
- Usuario y Mascota (referencias)
- Síntomas, notas, temperatura
- Fecha del registro

### `routines` - Rutinas diarias
- ID (UUID)
- Usuario y Mascota (referencias)
- Tipo (food, walk, play, medication, other)
- Hora, descripción

## ⚙️ Comandos Útiles

```bash
# Ver logs en tiempo real
docker-compose logs -f postgres

# Detener la base de datos
docker-compose down

# Detener y eliminar volúmenes (⚠️ borra datos)
docker-compose down -v

# Reinicar la base de datos
docker-compose restart postgres

# Ejecutar comando SQL
docker-compose exec postgres psql -U wardenpet_user -d wardenpet_db -c "SELECT * FROM users;"
```

## 🔧 Personalización

Edita el archivo `.env` para cambiar:
- Credenciales de la base de datos
- Datos del admin
- Host y puerto

## 📦 Conexión desde Node.js

```javascript
const pool = new Pool({
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
});
```

## 🐳 Volúmenes Persistentes

- **postgres_data**: Almacena todos los datos de la base de datos
- Los datos persisten incluso después de hacer `docker-compose down`

## 🆘 Troubleshooting

### Puerto 5432 ya está en uso
```bash
# Cambiar en docker-compose.yml:
ports:
  - "5433:5432"  # Usa 5433 en tu máquina
```

### Resetear la base de datos
```bash
docker-compose down -v
docker-compose up -d
```

### Ver si el contenedor está saludable
```bash
docker-compose ps  # Verifica la columna STATUS
```

---

**¡Tu base de datos está lista! 🎉**
