# Guía de Pruebas: Proyecto B - ChatBot Multiherramienta

Esta guía explica paso a paso cómo probar el funcionamiento del Chatbot en un entorno local, evaluando su capacidad para clasificar intenciones, consumir APIs y generar respuestas en lenguaje natural.

## Requisitos Previos (Para Evaluación)

Antes de iniciar las pruebas, asegúrate de que el entorno esté levantado y configurado:

1.  **Docker y Contenedores Activos:**
    - Debe ejecutarse `docker-compose up -d` desde el directorio `/docker` para levantar `n8n` y la base de datos `PostgreSQL`.
2.  **Ollama en Local:**
    - Debes tener [Ollama instalado](https://ollama.com/) en tu máquina anfitriona (fuera de Docker) con un modelo descargado (ej. `ollama run mistral` o `llama3.2`).
    - El puerto `11434` debe estar accesible para los contenedores de n8n.
3.  **Workflow de n8n Importado:**
    - Asegúrate de haber importado en n8n el archivo `n8n/workflows/chatbot-multiherramienta.json`.
    - Asegúrate de haber rellenado las credenciales de PostgreSQL y de Ollama en n8n si el importador no las conserva.

## Cómo Realizar las Pruebas

Para simular a un usuario final interactuando con el Chatbot, usaremos la extensión **REST Client** de VS Code interactuando contra el Webhook de n8n.

1.  **Abre el archivo de peticiones:** Dirígete al archivo `tests/pruebas.http`.
2.  **Activa el modo de escucha en n8n:** En la interfaz web de n8n, abre el workflow del Chatbot, haz doble clic en el primer nodo (Webhook) y dale al botón `"Listen for test event"`. La plataforma se quedará esperando una petición entrante.
3.  **Lanza la prueba:** Desde el archivo `pruebas.http` en VS Code, haz clic en el texto flotante `Send Request` que aparece encima de cada uno de los bloques `POST`.
4.  **Comprueba el resultado en n8n:** La ventana de n8n te mostrará visualmente cómo la información viaja bloque por bloque hasta generar una respuesta final natural mediante Ollama y guardarla en la base de datos PostgreSQL.

## Casos de Uso que se Pueden Probar

El Orquestador está configurado para manejar 5 escenarios distintos basándose en la intención del texto. Envía cada una de las pruebas desde el `pruebas.http` observando cómo el nodo _Switch_ cambia el enrutamiento visualmente:

- **Prueba 1 (Clima):** `¿Qué tiempo hace en Madrid?` -> Detecta `CLIMA`, consulta OpenMeteo y devuelve la temperatura actual.
- **Prueba 2 (País):** `Háblame sobre España` -> Detecta `PAIS`, consulta la REST Countries API y devuelve datos geográficos (ej. capital, población).
- **Prueba 3 (Wikipedia):** `¿Quién es Albert Einstein?` -> Detecta `WIKIPEDIA`, consulta la Wikipedia API y devuelve un fragmento resumido de su biografía.
- **Prueba 4 (Chiste):** `Cuéntame un chiste de programación` -> Detecta `CHISTE`, consulta la JokeAPI y devuelve un chiste aleatorio.
- **Prueba 5 (Conversación General):** `¿Qué es la inteligencia artificial?` -> Si no coincide con ninguna API, el enrutador manda el mensaje directo al LLM para que responda con su propio conocimiento base sin consumir herramientas externas.

## Verificación de Persistencia (PostgreSQL)

Al finalizar cualquiera de los recorridos del workflow, el último paso inserta un registro de la conversación en PostgreSQL. Para comprobar que el historial no se pierde:

1.  Conéctate a la base de datos `chatbot_db` expuesta en `localhost:5432` con un cliente como **pgAdmin** o **DBeaver** (las credenciales de acceso están en el fichero `docker/.env`).
2.  Haz una consulta a la tabla `historial_chatbot`:
    ```sql
    SELECT * FROM historial_chatbot ORDER BY timestamp DESC;
    ```
3.  Podrás verificar que por cada interacción se ha registrado: La pregunta original, la intención detectada por la IA, la API/herramienta concreta empleada y la respuesta final elaborada.
