-- Tabla: Historial de consultas Chatbot Multiherramienta
CREATE TABLE historial_chatbot (
  id SERIAL PRIMARY KEY,
  pregunta_usuario TEXT NOT NULL,
  intencion_detectada VARCHAR(100),
  herramienta_usada VARCHAR(100),
  respuesta_bot TEXT NOT NULL,
  timestamp TIMESTAMP DEFAULT NOW()
);

-- Índice para consultas recientes
CREATE INDEX idx_historial_timestamp 
ON historial_chatbot(timestamp DESC);
