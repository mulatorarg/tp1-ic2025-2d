extends Node
## Clase Singleton que gestiona datos de los recursos del Player.

## Ocurre cuando se modifica valor de algún recurso, como la energía o el maná.
signal recursos_changed
## Ocurre cuando el jugador llega a 0 de Vida.
signal jugador_muere
## Ocurre cuando el jugador sube un nivel.
signal jugador_sube_nivel

## Nivel de maná para .
var mana := 300:
	set(new_value):
		mana = new_value
		recursos_changed.emit()

## Nivel de energía para .
var energia := 300:
	set(new_value):
		energia = new_value
		recursos_changed.emit()

## Valor de vida del usuario.
var salud := 100:
	set(new_value):
		salud = new_value
		if salud <= 0:
			jugador_muere.emit()

## Nivel del usuario.
var nivel := 1:
	set(new_value):
		nivel = new_value
		if nivel <= 0:
			jugador_sube_nivel.emit(nivel)

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

## Verificar si el usuario dispone de todos los recursos necesario para, por ejemplo,
## insertar un guardiar a la grilla.
func dispone_recursos(recursos_necesarios: Dictionary) -> bool:
	for recurso in recursos_necesarios.keys():
		if self.get(recurso) < recursos_necesarios[recurso]:
			return false
	return true
