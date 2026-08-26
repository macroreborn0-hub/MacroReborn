-- ============================================
-- MacroReborn — 000: Tabla base "users"
-- ============================================
-- Este proyecto de Supabase NO tiene la tabla "users" que usan las
-- 17 migraciones (001 a 017). Solo existe "auth.users" (la de
-- autenticación de Supabase, con id UUID), que es OTRA tabla y no
-- sirve para las referencias "users(id) INTEGER" que usan tus
-- migraciones y tu código (api/users.js, api/_password.js, etc).
--
-- Este script reconstruye "users" con las columnas que se pudieron
-- confirmar leyendo las 17 migraciones (columnas que ellas agregan,
-- alteran, o que otras tablas copian/denormalizan):
--   - id            (PK entera, referenciada como INTEGER en todas)
--   - username       (denormalizado en comments/likes/chat/moderación)
--   - password       (texto plano, existía NOT NULL — ver 014)
--
-- ADVERTENCIA IMPORTANTE:
-- Solo tengo los 17 archivos de /migrations, no el resto del código
-- del sitio (api/users.js, js/motor/registro.js, etc). Si tu app usa
-- columnas adicionales en el registro/login (por ejemplo: email,
-- fecha_registro, nivel, xp, avatar por defecto, etc.) que ninguna
-- de las 17 migraciones toca, esas columnas NO están incluidas acá
-- porque no hay evidencia de ellas en los archivos que me pasaste.
-- Si el registro o login siguen fallando después de esto, compartime
-- el archivo real que hace el INSERT de usuarios nuevos (o el .zip
-- del sitio) y lo ajusto con precisión.
--
-- Seguro de re-ejecutar (usa IF NOT EXISTS).
-- Este script debe correr ANTES de 001_fase1.sql.
-- ============================================

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
