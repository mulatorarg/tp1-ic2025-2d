extends Node

const SETTINGS_PATH := "user://user.cfg"

## Ocurre cuando se modifica valor de algún recurso, como la energía o el maná.
signal recursos_changed
## Ocurre cuando el jugador llega a 0 de Vida.
signal jugador_muere
## Ocurre cuando el jugador sube un nivel.
signal jugador_sube_nivel
## Ocurre cuando un enemigo muere (eliminado por el jugador)
signal enemigo_eliminado
## Ocurre cuando un enemigo llega a la choza
signal enemigo_llego_choza

## Nivel de maná para .
var mana := 100:
	set(new_value):
		mana = new_value
		recursos_changed.emit()

## Nivel de energía para .
var energia := 100:
	set(new_value):
		energia = new_value
		recursos_changed.emit()

## Valor de vida del usuario.
var salud := 700:
	set(new_value):
		salud = new_value
		recursos_changed.emit()
		if salud <= 0:
			jugador_muere.emit()

## Nivel del usuario.
var nivel := 1:
	set(new_value):
		nivel = new_value
		jugador_sube_nivel.emit(nivel)

var oleadas_totales: int = 0:
	set(new_value):
		oleadas_totales = new_value
		recursos_changed.emit()

var oleada_actual: int = 0:
	set(new_value):
		oleada_actual = new_value
		recursos_changed.emit()

var enemigos_totales: int = 0:
	set(new_value):
		enemigos_totales = new_value
		recursos_changed.emit()

var enemigos_actual: int = 0:
	set(new_value):
		enemigos_actual = new_value
		recursos_changed.emit()

## Contador de enemigos que han muerto (eliminados por el jugador)
var enemigos_eliminados: int = 0:
	set(new_value):
		enemigos_eliminados = new_value
		recursos_changed.emit()

## Contador de enemigos que llegaron a la choza
var enemigos_llegaron_choza: int = 0:
	set(new_value):
		enemigos_llegaron_choza = new_value
		recursos_changed.emit()


## Sumar recursos (maná, energía o salud) según valor pasado por parámetro.
func sumar_recursos(tipo: String, cantidad: int):
	self.set(tipo, self.get(tipo) + cantidad)
	recursos_changed.emit()

## Consumir recursos (maná, energía) según valores pasados por parámetros.
func consumir_recursos(recursos_necesarios: Dictionary) -> bool:
	for recurso in recursos_necesarios.keys():
		if self.get(recurso) < recursos_necesarios[recurso]:
			return false
	for recurso in recursos_necesarios.keys():
		self.set(recurso, self.get(recurso) - recursos_necesarios[recurso])
	recursos_changed.emit()
	return true

## Verificar si el jugador dispone de todos los recursos necesarios para, por ejemplo,
## insertar un guardia a la grilla.
func dispone_recursos(recursos_necesarios: Dictionary) -> bool:
	for recurso in recursos_necesarios.keys():
		if self.get(recurso) < recursos_necesarios[recurso]:
			return false
	return true

## Reiniciar contadores de enemigos al iniciar un nuevo nivel
func reiniciar_contadores_enemigos():
	enemigos_eliminados = 0
	enemigos_llegaron_choza = 0
	enemigos_actual = 0
	oleada_actual = 0

## Registrar que un enemigo fue eliminado
func registrar_enemigo_eliminado():
	enemigos_eliminados += 1
	enemigo_eliminado.emit()

## Registrar que un enemigo llegó a la choza
func registrar_enemigo_llego_choza():
	enemigos_llegaron_choza += 1
	enemigo_llego_choza.emit()
