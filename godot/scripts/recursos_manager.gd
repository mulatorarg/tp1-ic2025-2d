extends Node
## Clase Singleton que gestiona datos de los recursos del Player.

signal recursos_changed ## Ocurre cuando se modifica valor de algún recurso, como la energía o el maná.

var mana := 50 ## Nivel de maná para .
var energia := 150: ## Nivel de energía para .
	set(value):
		energia = value
		recursos_changed.emit()

var salud := 100 ## Valor de vida del usuario.
var nivel := 1 ## Nivel del usuario.

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
