# Proyecto B: Chatbot Multiherramienta - HITO 3

Este proyecto implementa un asistente conversacional capaz de analizar intenciones y decidir de forma inteligente qué API externa debe consultar (Clima, Países, Wikipedia, Chistes) para dar una respuesta certera. Todo ello gestionado mediante **n8n** como orquestador, **Ollama** como modelo de lenguaje local, y almacenando el historial conversacional en **PostgreSQL**.

## El Proceso de Construcción (Paso a Paso)

El desarrollo de este sistema multiherramienta ha seguido un flujo de trabajo iterativo para asegurar la robustez de los datos y el aislamiento de los contenedores:

### 1. Entorno Aislado con Docker 

Se inició creando una estructura de proyecto profesional. Para evitar conflictos con otros proyectos (como el Proyecto A del Hito 3), el orquestador n8n y la base de datos PostgreSQL se configuraron en un archivo `docker-compose.yml` aislado con el atributo `name: proyecto-b-chatbot`. Se securizó la base de datos haciendo uso de un archivo `.env` que queda excluido de Git para manejar las credenciales y se escribió el script `init.sql` para automatizar la creación de la tabla histórica.

### 2. El Orquestador: Recepción y Toma de Decisiones (n8n)

Todo el cerebro del Chatbot está modelado en el lienzo de n8n.

- **Webhook de Entrada:** El flujo es detomado recibiendo un payload JSON con la pregunta del usuario. Se usa el archivo `tests/pruebas.http` que actúa como Mock del Cliente/Frontend simulando ser el usuario con peticiones `POST`.
- **Análisis de Intenciones:** La pregunta del usuario (ej: _"¿Qué tiempo hace en Madrid?"_) se transfiere al nodo **Ollama**. Mediante un _Prompt Engineering_ estricto y una temperatura a `0`, se obliga a este Modelo Local a comportarse como un clasificador evaluando el texto y etiquetando la intención en un String exacto (CLIMA, PAIS, WIKIPEDIA, CHISTE o GENERAL).
- **Ruteador Semántico (Switch):** El nodo Switch de n8n evalúa la etiqueta extraída por la IA y divide o enruta físicamente el flujo del sistema por 5 vías distintas.

### 3. Consumo de Herramientas (APIs)

Dependiendo de qué rama se haya activado, n8n es instruido mediante nodos secundarios `HTTP Request` para hacer llamadas `GET` a APIs públicas y gratuitas que el Chatbot usa como "herramientas" reales sin hardcodeo de respuestas:

- En la rama CLIMA, llama a **OpenMeteo**.
- En la rama PAIS, llama a **REST Countries**.
- En la rama WIKIPEDIA, llama a la **API de Wikipedia**.
- En la rama CHISTE, llama a **JokeAPI**.
  Adicionalmente, se configuró un bloque de variables dinámicas `Edit Fields` en cada rama simplemente para clasificar qué herramienta acaba de usarse a efectos de guardado.

### 4. Generación de Respuesta Natural y Persistencia

- **Embudo y Fusión (Merge):** Independientemente de qué API ha sido llamada, todos los resultados convergen en un nodo `Merge` (Append).
- **Generación Contextual:** Los datos JSON crudos obtenidos por las diferentes APIs, junto a la pregunta original, se inyectan en un **segundo nodo Ollama final**. Este último cuenta con un Prompt diseñado de nuevo para tomar el JSON ilegible para humanos y redactar una frase en lenguaje natural usando exclusivamente el contexto recibido, devolviendo por fin la solución al desafío del usuario.
- **BBDD:** Un último nodo **PostgreSQL** extrae el bloque entero de la iteración insertando dinámicamente: _Pregunta Usuario_, _Etiqueta Detectada_, _Herramienta Usada_ y _Respuesta de la IA_ en cada viaje sin interrumpir el esquema.

## Tecnologías Utilizadas

- **n8n:** Orquestador visual de workflows.
- **Ollama:** Análisis de intenciones y generación de texto natural (modelos Mistral/Llama3).
- **PostgreSQL:** Persistencia del historial conversacional.
- **APIs Externas:** OpenMeteo, REST Countries, Wikipedia, JokeAPI.
- **VS Code Extension (REST Client):** Simulación de usuario enviando peticiones POST.

## Instalación, Pruebas y Evaluación

Para arrancar el proyecto y evaluar los Casos de Uso del Chatbot consultando la guía oficial y los logs de la DB, por favor dirígete a [`docs/DEMO.md`](docs/DEMO.md).

## Funcionalidades Implementadas

- [x] Análisis de intención con Ollama y Prompt Estratégico.
- [x] Enrutamiento dinámico con nodo Switch de n8n.
- [x] Integración de 4 APIs externas (Clima, Países, Wikipedia, Chistes).
- [x] Base de datos persistente PostgreSQL aislada en Docker para logueo.
- [x] Traducción de payloads JSON a lenguaje NLP con IA final.
- [x] Estructura separada con variables seguras en Git y simulador en archivo `.http`.

----------------------------------------------------------------

## URL del Video Demo

- 
