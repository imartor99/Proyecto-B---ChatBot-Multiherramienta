# Demo del Proyecto B: ChatBot Multiherramienta

## 🎥 Vídeo Demostración

[Enlace al vídeo en YouTube/Plataforma] <!-- Sustituir por el enlace real del vídeo -->

## 📋 Guion del Vídeo

1. **Introducción (30 seg):**
   - Presentación personal y elección del Proyecto B (Chatbot Multiherramienta).

2. **Arquitectura (1 min):**
   - Explicación de n8n como orquestador.
   - Rol de Ollama en el análisis de intenciones y generación de respuestas naturales.
   - Uso de APIs Externas (OpenMeteo, REST Countries, Wikipedia, JokeAPI).
   - PostgreSQL para guardar el historial.

3. **Demo en vivo (2-3 min):**
   - Pregunta 1 (Clima): "¿Qué tiempo hace en Madrid?"
   - Pregunta 2 (País): "Háblame sobre Japón"
   - Pregunta 3 (Wiki): "¿Quién es Albert Einstein?"
   - Pregunta 4 (Chiste): "Cuéntame un chiste de programación"
   - Pregunta 5 (Ollama General): "¿Qué es la inteligencia artificial?"
   - Mostrar tabla _historial_chatbot_ en PostgreSQL con los resultados.

4. **Workflow en n8n (1 min):**
   - Breve recorrido por los nodos: Webhook, Ollama (Intención), Switch, HTTP Requests (APIs), y Ollama (Respuesta natural).

5. **Conclusiones (30 seg):**
   - Aprendizajes clave, retos encontrados y posibles mejoras.
