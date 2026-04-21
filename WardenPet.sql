-- ════════════════════════════════════════════════════════════════
-- INICIALIZACIÓN DE BASE DE DATOS WARDENPET
-- ════════════════════════════════════════════════════════════════

BEGIN;

-- ── USUARIOS ──────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        VARCHAR(100) NOT NULL,
  email       VARCHAR(150) UNIQUE NOT NULL,
  password    VARCHAR(255) NOT NULL,
  role        VARCHAR(20) NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'admin')),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_login  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

-- ── MASCOTAS ──────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS pets (
  id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id   UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name      VARCHAR(100) NOT NULL,
  type      VARCHAR(20) NOT NULL CHECK (type IN ('dog','cat','rabbit','bird','other')),
  age       INTEGER NOT NULL CHECK (age >= 0),
  breed     VARCHAR(100),
  weight    NUMERIC(5,2),
  image     TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_pets_user_id ON pets(user_id);
CREATE INDEX IF NOT EXISTS idx_pets_type ON pets(type);

-- ── RECORDATORIOS ─────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS reminders (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  pet_id      UUID NOT NULL REFERENCES pets(id) ON DELETE CASCADE,
  type        VARCHAR(30) NOT NULL CHECK (type IN ('vaccine','bath','vet','grooming','other')),
  title       VARCHAR(150) NOT NULL,
  description TEXT,
  date        TIMESTAMPTZ NOT NULL,
  completed   BOOLEAN NOT NULL DEFAULT FALSE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_reminders_user_id ON reminders(user_id);
CREATE INDEX IF NOT EXISTS idx_reminders_pet_id ON reminders(pet_id);
CREATE INDEX IF NOT EXISTS idx_reminders_completed ON reminders(completed);
CREATE INDEX IF NOT EXISTS idx_reminders_date ON reminders(date);

-- ── REGISTROS DE SALUD ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS health_records (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  pet_id      UUID NOT NULL REFERENCES pets(id) ON DELETE CASCADE,
  date        TIMESTAMPTZ NOT NULL,
  symptoms    TEXT NOT NULL,
  notes       TEXT,
  temperature NUMERIC(4,1),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_health_records_user_id ON health_records(user_id);
CREATE INDEX IF NOT EXISTS idx_health_records_pet_id ON health_records(pet_id);
CREATE INDEX IF NOT EXISTS idx_health_records_date ON health_records(date);

-- ── RUTINAS ───────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS routines (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  pet_id      UUID NOT NULL REFERENCES pets(id) ON DELETE CASCADE,
  type        VARCHAR(30) NOT NULL CHECK (type IN ('food','walk','play','medication','other')),
  time        TIME NOT NULL,
  description VARCHAR(255) NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_routines_user_id ON routines(user_id);
CREATE INDEX IF NOT EXISTS idx_routines_pet_id ON routines(pet_id);
CREATE INDEX IF NOT EXISTS idx_routines_type ON routines(type);

COMMIT;
