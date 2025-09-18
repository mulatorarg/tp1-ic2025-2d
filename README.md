# TP 1: Juego 2D

**Desarrollador**: Gabriel Campo (Yacaré Studio)

Adaptación de mitologías del litoral Argentino, al tipo *Plants vs Zombies* desarrollado en Godot Engine 4.5.

# Resumen del juego

**Título provisional:** Campo del Cielo: Rubí vs. Los Siete.
**Género:** Defensa de torre en 2D, grid-based, estilo casual táctico.
**Resolución objetivo:** **HD 1366×768** (UI y HUD diseñados para esta resolución).
**Grid de juego:** **7 columnas × 5 filas** (fijo).
**Estética:** ilustración estilizada, mezcla de folclore guaraní y diseño moderno. Tono: mágico, juvenil, épico.

# Concepto jugable (core loop)

Recolectar **Brillos** (equivalente a "sun") → gastar en **Guardianas** (defensores inspirados en flora y héroes) → colocarlas en la cuadrícula 7×5 → detener oleadas de **Engendros** (los siete hijos malditos de Tau y Kerana, de la mitoligía Guaraní) que avanzan por las columnas hacia el campamento → usar habilidades especiales (Rubí, rituales, meteoritos) → ganar niveles y desbloquear contenido.

# Personajes / Defensores (plantas → defensas)

Diseño inspirado en flora y figuras culturales. Cada defensor tiene coste en Brillos, tiempo de recarga, vida y ataque.

1. **Ceibo Guardián** (básico)

   * Rol: atacante terrestre.
   * Coste: 50 Brillos. DPS bajo, coste bajo.
   * Stats ejemplo inicial: HP 120, DPS 18, rango cuerpo a cuerpo.

2. **Jaguarñá (trampa de liana)**

   * Rol: ralentizador, daño por restricción.
   * Coste: 75. HP 180. Efecto: ralentiza 50% por 3s y da 40 daño por segundo.

3. **Flor de Meteoro (tire proyectiles)**

   * Rol: atacante a distancia.
   * Coste: 100. Cadencia media. DPS 30. Puede sobrecargarse con meteoritos para ataque crítico.

4. **Guardián Mbói (serpiente control)**

   * Rol: control. Coste 125. Lanza veneno que da daño con el tiempo y tiene chance de aturdir 1s.

5. **Chacarera (generadora)**

   * Rol: producción de Brillos (similar a girasol).
   * Coste: 50. Genera 25 Brillos cada 8s. Mejora la moral de filas contiguas (pequeño buff).

6. **Porãsy (unidad de sacrificio/engaño)**

   * Rol: trampas y engaño. Coste: 150. Tiene ulti que engaña a ciertos enemigos para entrar a una cueva (mecánica de misiones especiales).

7. **Rubí (Héroe activable)**

   * No ocupa celda. Habilidad con cooldown (30–90s). Habilidades: Estocada estelar (daño en línea), Escudo de Pléyades (buff temporal), Teletransporte a una fila. Se desbloquea campaña medio-juego.

# Enemigos (zombies → engendros)

Cada enemigo representa a los siete hijos; cada tipo tiene variantes (roaming, pesado, rápido, volador roamer, mini-boss, boss).

1. **Teju Jagua (Cueva)**

   * Tipo: tanque. Lento, alta HP, daño por aplastamiento.
   * Mecánica: inmunidad parcial a efectos de aturdimiento. Encerrado temporalmente tras combate con Rubí.

2. **Mbói Tu’í (Pantano)**

   * Tipo: línea aérea/serpiente que salta entre filas. Puede evadir condiciones de suelos. Ataca con graznidos que desorientan defensores (reduce cadencia).

3. **Moñai (Saqueador)**

   * Tipo: robber. Roba Brillos cada X segundos si pasa sin ser bloqueado. Priorizarlo.

4. **Jasy Jateré (Cazador de niños)**

   * Tipo: furtivo. Invisible por cortos periodos, se teleporta entre celdas excepto si hay luz (Chacarera) o Porãsy engaña.

5. **Kurupí (Sombra)**

   * Tipo: domino/berserker. Empuja defensores fuera de la celda y aplica debuff social (reduce moral en fila → reduce daño). Evitar diseño gráfico sexualizado; en juego su rol es “corruptor” que roba buffs.

6. **Ao Ao (Bestia)**

   * Tipo: mob rápido en manada (wave). Devora unidades con ataque en área.

7. **Lobisón (Cadena de muertos)**

   * Tipo: necro/undead. Debilita curaciones y reanima enemigos caídos como mini-skel. Es miniboss final por zona.

Variante de boss: **Reunión de los Siete** (encuentro final de capítulo; sin invocar contenido sexual, solo batalla épica con fases).

# 2. **Concept Art Guía (PNG a generar)**

### Elementos a incluir:

* **Rubí:** heroína con estética mítica, cabellos oscuros y detalles de ceibo rojo, armadura ligera inspirada en textiles guaraníes.

* **Defensores:**

  * Ceibo Guardián: árbol joven con flores rojas brillantes.
  * Jaguarñá: trampa de lianas con fauces de jaguar.
  * Flor de Meteoro: flor azul que lanza proyectiles llameantes.
  * Guardián Mbói: serpiente verde-azulada con plumas.
  * Chacarera: figura femenina danzante con aura de luz.
  * Porãsy: joven con velo y antorcha, engaño luminoso.

* **Enemigos:** (tomados de la mitoligía Guaraní)

  * Teju Jagua: lagarto gigante con siete cabezas de perro.
  * Mbói Tu’í: serpiente alada con pico.
  * Moñai: figura alta con bastón de sogas.
  * Jasy Jateré: niño rubio con bastón mágico.
  * Kurupí: sombra retorcida con cuerda corruptora.
  * Ao Ao: bestia lanuda en manada.
  * Lobisón: criatura esquelética mitad hombre, mitad lobo.

* **UI / HUD:** iconos de Brillos, cartas con bordes inspirados en motivos guaraníes.