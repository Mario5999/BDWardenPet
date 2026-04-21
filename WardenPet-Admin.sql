-- ════════════════════════════════════════════════════════════════
-- CREACIÓN DE USUARIO ADMINISTRADOR POR DEFECTO
-- ════════════════════════════════════════════════════════════════

BEGIN;

-- Insertar admin por defecto (contraseña hasheada con bcrypt)
-- Contraseña: admin123 (hasheada con bcrypt round 10)
INSERT INTO users (name, email, password, role)
VALUES (
  'Administrador',
  'admin@wardenpet.com',
  '$2a$10$YOr.0NUnnMEKJIXVqkrFte5eVVfvB8XqVeVHBgvTsHqLqrZvswzTS',
  'admin'
)
ON CONFLICT (email) DO NOTHING;

COMMIT;
