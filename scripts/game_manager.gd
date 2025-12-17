extends Node

# Autoload script para gerenciar o estado global do jogo

# Sinais
signal resource_changed(resource_name: String, amount: int)
signal coins_changed(amount: int)
signal skill_xp_changed(skill_name: String, xp: int, level: int)
signal combat_update(monster_hp: int, player_hp: int)

# Recursos do jogador
var resources := {
	"Cobre": 0,
	"Ferro": 0,
	"Madeira": 10,  # Iniciar com madeira para permitir crafting inicial
}

# Moedas
var coins := 0

# Habilidades e experiência
var skills := {
	"Mineração": {"xp": 0, "level": 1},
	"Combate": {"xp": 0, "level": 1},
	"Criação": {"xp": 0, "level": 1}
}

# Inventário de ferramentas
var tools := {
	"Espada de Madeira": 0,
	"Espada de Ferro": 0,
}

# Equipamento atual
var equipped_weapon: String = ""

# Adicionar recurso
func add_resource(resource_name: String, amount: int) -> void:
	if resources.has(resource_name):
		resources[resource_name] += amount
		resource_changed.emit(resource_name, resources[resource_name])

# Remover recurso (para crafting)
func remove_resource(resource_name: String, amount: int) -> bool:
	if resources.has(resource_name) and resources[resource_name] >= amount:
		resources[resource_name] -= amount
		resource_changed.emit(resource_name, resources[resource_name])
		return true
	return false

# Adicionar moedas
func add_coins(amount: int) -> void:
	coins += amount
	coins_changed.emit(coins)

# Remover moedas
func remove_coins(amount: int) -> bool:
	if coins >= amount:
		coins -= amount
		coins_changed.emit(coins)
		return true
	return false

# Adicionar XP a uma habilidade
func add_skill_xp(skill_name: String, xp_amount: int) -> void:
	if skills.has(skill_name):
		skills[skill_name]["xp"] += xp_amount
		# Sistema simples de level-up (100 XP por nível)
		var new_level = 1 + int(skills[skill_name]["xp"] / 100)
		skills[skill_name]["level"] = new_level
		skill_xp_changed.emit(skill_name, skills[skill_name]["xp"], new_level)

# Adicionar ferramenta ao inventário
func add_tool(tool_name: String, amount: int = 1) -> void:
	if tools.has(tool_name):
		tools[tool_name] += amount
	else:
		tools[tool_name] = amount

# Equipar ferramenta
func equip_weapon(weapon_name: String) -> bool:
	if tools.has(weapon_name) and tools[weapon_name] > 0:
		equipped_weapon = weapon_name
		return true
	return false

# Obter dano da arma equipada
func get_weapon_damage() -> int:
	match equipped_weapon:
		"Espada de Madeira":
			return 5
		"Espada de Ferro":
			return 10
		_:
			return 1  # Dano base sem arma
