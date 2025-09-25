extends Node

signal inicia_oleada ## Ocurre cuando el nivel inicia una oledaad.
signal termina_oleada ## Ocurre cuando el nivel termina una oleadad.
signal inicia_oleada_final ## Ocurre cuando el nivel inicia la oleada final.
signal termina_oleada_final ## Ocurre cuando el nivel termina la oleadad final.

var oleadas_totales : int = 1 ## Cantidad de oleadas que tiene el nivel.
var oleada_actual : int = 0 ## Número de oleada que se está ejecutando en el nivel.
var espera_entre_oleadas : float = 5.0 ## Tiempo en segundos que separan entre oleadas.

# Mi idea es que cada nivel, le diga cuantas oleadas y qué enemigos tiene que instanciar
var oleadas : Dictionary = {}

func iniciar_oleada() -> void:
	if oleada_actual < oleadas_totales:
		print("Inicia oleada")
		inicia_oleada.emit()
	else:
		print_rich("[color=red]Ya se iniciaron todas las Oleadas.[/color]")

func terminar_oleada() -> void:
	print("Finaliza oleada")
	termina_oleada.emit()

func iniciar_oleada_final() -> void:
	print("Inicia oleada final")
	inicia_oleada_final.emit()

func terminar_oleada_final() -> void:
	print("Finaliza oleada final")
	termina_oleada_final.emit()
