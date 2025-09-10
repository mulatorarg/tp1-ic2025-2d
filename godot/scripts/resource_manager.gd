var semillas := 50
var gotas := 50
var chispas := 50
var susurros := 50

signal resources_changed

func add_resource(type: String, amount: int):
	self.set(type, self.get(type) + amount)
	resources_changed.emit()

func spend(cost: Dictionary) -> bool:
	for k in cost.keys():
		if self.get(k) < cost[k]:
			return false
	for k in cost.keys():
		self.set(k, self.get(k) - cost[k])
	resources_changed.emit()
	return true
