# **Game Design Document (GDD)**

## 1. Información general

* **Título provisional**: *Rubí: Guardianes del Litoral*
* **Género**: Tower defense / estrategia en tiempo real.
* **Plataforma**: PC, multiplataforma.
* **Público objetivo**: +10 años, jugadores casuales y amantes de mitología latinoamericana.

---

## 2. Narrativa

* **Premisa**: Los hijos de Taú y Keraná amenazan el litoral. Rubí, guardiana estelar, convoca a las criaturas de la flora y fauna para defender las tierras del Chaco, Corrientes y los esteros.
* **Progresión narrativa**:

  1. Tutorial (Campo del Cielo, aparición de Rubí).
  2. Primeros niveles en el monte chaqueño.
  3. Niveles intermedios en el Paraná.
  4. Niveles avanzados en los Esteros del Iberá.
  5. Batalla final contra Lobisón en los cementerios.

---

## 3. Mecánicas de juego

* **Mapa dividido en filas (5–7 líneas)**, estilo PvZ.
* **Unidades defensoras (Guardianes)**: inspirados en flora/fauna mítica:

  * Carpincho: ralentiza enemigos.
  * Yacaré: ataque en corto alcance.
  * Garza blanca: ataque aéreo (proyectil).
  * Ceibo florido: genera “energía estelar” (recurso).
  * Ciervo de los pantanos: embiste en línea recta.
  * Lanza estelar (de Rubí): unidad poderosa desbloqueada en niveles clave.
* **Recursos**: “Energía estelar” caída del cielo (similar a soles en PvZ).
* **Oleadas de enemigos (Monstruos)**:

  * Teju Jagua (lento, resistente).
  * Mbói Tu’í (serpentea entre filas).
  * Moñai (roba recursos).
  * Jasy Jateré (hipnotiza defensores, cambia bando temporalmente).
  * Kurupí (acelera al cargar).
  * Ao Ao (horda en grupo, múltiples instancias).
  * Lobisón (jefe final, invoca sombras).

---

## 4. Progresión de niveles

* **Niveles por región**:

  * Chaco: tutorial + primeros monstruos.
  * Corrientes/Paraná: introducción de mecánicas de agua.
  * Iberá: aparición de enemigos combinados.
  * Cementerio final: jefe Lobisón.
* **Incremento de dificultad**: más monstruos, mayor velocidad, mecánicas especiales (lluvia, niebla, noche).

---

## 5. Estilo visual y sonoro

* **Arte**:

  * Colores cálidos para el Chaco, verdes intensos para Corrientes, azules/plateados para Iberá, tonos oscuros para cementerio.
  * Diseño de enemigos basado en grabados guaraníes con un toque cartoon.
* **Música**:

  * Instrumentos regionales (arpa paraguaya, tambores, sonidos de agua y aves).
  * Tono alegre en tutorial, sombrío en niveles nocturnos.

---

## 6. UI / UX

* **Pantalla principal**: Logo, menú iniciar, bestiario, enciclopedia de guardianes.
* **HUD en juego**:

  * Barra superior con recursos estelares.
  * Slots de guardianes seleccionados.
  * Oleada actual / total.

---

## 7. Producción

* **Fases**:

  1. Preproducción (este GDD, mockups de UI, concept art).
  2. Prototipo jugable en Godot (1 fila, 1 guardián, 1 enemigo).
  3. Expansión a tablero completo.
  4. Desarrollo progresivo de enemigos/guardianes.
  5. Integración narrativa y mapas.
  6. Pulido visual y sonoro.
* **Duración estimada**: 6–9 meses para un prototipo completo con 15–20 niveles.

---

## 8. Riesgos y mitigaciones

* **Exceso de unidades** → planificar árbol de desbloqueo gradual.
* **Sobrecarga visual en esteros** → usar capas de tiles optimizadas.
* **Compatibilidad Godot 4.5** → mantener recursos simples y revisar changelog oficial para migración.

