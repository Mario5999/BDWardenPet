BEGIN;

INSERT INTO users (name, email, password, role)
VALUES (
  'Administrador',
  'admin@wardenpet.com',
  crypt('admin123', gen_salt('bf', 10)),
  'admin'
)
ON CONFLICT (email) DO NOTHING;

COMMIT;
