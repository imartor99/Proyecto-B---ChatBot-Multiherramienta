# Proyecto B: Chatbot Multiherramienta - HITO 3

Este proyecto implementa un asistente conversacional capaz de analizar intenciones y decidir qué API externa consultar (clima, países, Wikipedia, chistes) utilizando n8n como orquestador y Ollama como modelo de lenguaje local.

## 🚀 Arquitectura

- **n8n:** Orquestador visual de workflows.
- **Ollama:** Análisis de intenciones y generación de texto natural.
- **PostgreSQL:** Persistencia del historial conversacional.
- **APIs Externas:** OpenMeteo, REST Countries, Wikipedia, JokeAPI.

## 🛠 Instalación y Configuración

1. Clonar el repositorio.
2. Copiar `docker/.env.example` a `docker/.env`.
3. Levantar los servicios con Docker Compose:
   ```bash
   cd docker
   docker-compose up -d
   ```
4. Asegurarse de tener Ollama corriendo localmente con un modelo descargado:
   ```bash
   ollama pull mistral
   ```
5. Importar el workflow desde `n8n/workflows/chatbot-multiherramienta.json` a n8n.

## 📁 Estructura del Proyecto

- `docker/`: Configuración de contenedores.
- `n8n/`: Workflows exportados.
- `postgres/`: Script de inicialización de la base de datos.
- `tests/`: Pruebas de API vía HTTP.
- `docs/`: Documentación y demostración.

## ✅ Funcionalidades Implementadas

- [ ] Análisis de intención con Ollama.
- [ ] Enrutamiento con nodo Switch de n8n.
- [ ] Integración de APIs (Clima, Países, Wikipedia, Chistes).
- [ ] Base de datos PostgreSQL para historial.
- [ ] Respuestas en lenguaje natural generadas por IA.
- [ ] Manejo básico de errores integrado.
