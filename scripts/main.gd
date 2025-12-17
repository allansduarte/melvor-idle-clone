extends Control

# Constantes de balanceamento
const MINING_DURATION_BASE = 2.0  # Tempo base de mineração em segundos
const MINING_UPGRADE_REDUCTION = 0.2  # 20% de redução com upgrade
const COMBAT_INTERVAL = 2.0  # Intervalo entre ataques em segundos
const ARMOR_UPGRADE_HP_BONUS = 20  # HP adicional da armadura

# Constantes de monstros
const SLIME_HP = 30
const SLIME_DAMAGE = 3
const SLIME_COINS = 10

# Referências aos nós da UI
@onready var coins_label = $VBoxContainer/TopBar/HBoxContainer/MarginContainer/HBoxContainer/CoinsLabel

# Mining Tab
@onready var mining_level_label = $"VBoxContainer/TabContainer/Coleta/MiningPanel/VBoxContainer/SkillInfo/MarginContainer/VBoxContainer/LevelLabel"
@onready var mining_xp_label = $"VBoxContainer/TabContainer/Coleta/MiningPanel/VBoxContainer/SkillInfo/MarginContainer/VBoxContainer/XPLabel"
@onready var mining_progress_bar = $"VBoxContainer/TabContainer/Coleta/MiningPanel/VBoxContainer/SkillInfo/MarginContainer/VBoxContainer/ProgressBar"
@onready var copper_amount_label = $"VBoxContainer/TabContainer/Coleta/MiningPanel/VBoxContainer/ResourcesGrid/CopperPanel/VBoxContainer/AmountLabel"
@onready var iron_amount_label = $"VBoxContainer/TabContainer/Coleta/MiningPanel/VBoxContainer/ResourcesGrid/IronPanel/VBoxContainer/AmountLabel"
@onready var mining_status_label = $"VBoxContainer/TabContainer/Coleta/MiningPanel/VBoxContainer/MiningProgress/VBoxContainer/StatusLabel"
@onready var mining_progress = $"VBoxContainer/TabContainer/Coleta/MiningPanel/VBoxContainer/MiningProgress/VBoxContainer/ProgressBar"

# Crafting Tab
@onready var wood_sword_craft_button = $"VBoxContainer/TabContainer/Criação/CraftingPanel/VBoxContainer/RecipesGrid/WoodSwordPanel/VBoxContainer/CraftButton"
@onready var iron_sword_craft_button = $"VBoxContainer/TabContainer/Criação/CraftingPanel/VBoxContainer/RecipesGrid/IronSwordPanel/VBoxContainer/CraftButton"

# Combat Tab
@onready var weapon_option = $"VBoxContainer/TabContainer/Combate/CombatPanel/VBoxContainer/WeaponSelection/VBoxContainer/WeaponOption"
@onready var player_hp_label = $"VBoxContainer/TabContainer/Combate/CombatPanel/VBoxContainer/CombatArea/PlayerPanel/VBoxContainer/HPLabel"
@onready var player_damage_label = $"VBoxContainer/TabContainer/Combate/CombatPanel/VBoxContainer/CombatArea/PlayerPanel/VBoxContainer/DamageLabel"
@onready var monster_name_label = $"VBoxContainer/TabContainer/Combate/CombatPanel/VBoxContainer/CombatArea/MonsterPanel/VBoxContainer/MonsterName"
@onready var monster_hp_label = $"VBoxContainer/TabContainer/Combate/CombatPanel/VBoxContainer/CombatArea/MonsterPanel/VBoxContainer/HPLabel"
@onready var monster_damage_label = $"VBoxContainer/TabContainer/Combate/CombatPanel/VBoxContainer/CombatArea/MonsterPanel/VBoxContainer/DamageLabel"
@onready var combat_status_label = $"VBoxContainer/TabContainer/Combate/CombatPanel/VBoxContainer/ControlPanel/VBoxContainer/StatusLabel"
@onready var start_combat_button = $"VBoxContainer/TabContainer/Combate/CombatPanel/VBoxContainer/ControlPanel/VBoxContainer/HBoxContainer/StartCombatButton"
@onready var stop_combat_button = $"VBoxContainer/TabContainer/Combate/CombatPanel/VBoxContainer/ControlPanel/VBoxContainer/HBoxContainer/StopCombatButton"

# Shop Tab
@onready var upgrade1_buy_button = $"VBoxContainer/TabContainer/Loja/ShopPanel/VBoxContainer/ShopGrid/UpgradePanel1/VBoxContainer/BuyButton"
@onready var upgrade2_buy_button = $"VBoxContainer/TabContainer/Loja/ShopPanel/VBoxContainer/ShopGrid/UpgradePanel2/VBoxContainer/BuyButton"

# Estado de mineração
var is_mining = false
var current_mining_resource = ""
var mining_time = 0.0
var mining_duration = MINING_DURATION_BASE

# Estado de combate
var is_in_combat = false
var player_hp = 100
var player_max_hp = 100
var current_monster = {
	"name": "Slime", 
	"hp": SLIME_HP, 
	"max_hp": SLIME_HP, 
	"damage": SLIME_DAMAGE, 
	"coins": SLIME_COINS
}
var combat_timer = 0.0

# Upgrades comprados
var has_mining_upgrade = false
var has_armor_upgrade = false

func _ready():
	# Conectar sinais do GameManager
	GameManager.resource_changed.connect(_on_resource_changed)
	GameManager.coins_changed.connect(_on_coins_changed)
	GameManager.skill_xp_changed.connect(_on_skill_xp_changed)
	
	# Conectar botões de mineração
	$"VBoxContainer/TabContainer/Coleta/MiningPanel/VBoxContainer/ResourcesGrid/CopperPanel/VBoxContainer/MineButton".pressed.connect(_on_mine_copper_pressed)
	$"VBoxContainer/TabContainer/Coleta/MiningPanel/VBoxContainer/ResourcesGrid/IronPanel/VBoxContainer/MineButton".pressed.connect(_on_mine_iron_pressed)
	
	# Conectar botões de crafting
	wood_sword_craft_button.pressed.connect(_on_craft_wood_sword_pressed)
	iron_sword_craft_button.pressed.connect(_on_craft_iron_sword_pressed)
	
	# Conectar botões de combate
	start_combat_button.pressed.connect(_on_start_combat_pressed)
	stop_combat_button.pressed.connect(_on_stop_combat_pressed)
	weapon_option.item_selected.connect(_on_weapon_selected)
	
	# Conectar botões da loja
	upgrade1_buy_button.pressed.connect(_on_buy_mining_upgrade)
	upgrade2_buy_button.pressed.connect(_on_buy_armor_upgrade)
	
	# Inicializar opções de armas
	weapon_option.add_item("Sem Arma")
	
	# Atualizar UI inicial
	update_ui()

func _process(delta):
	# Processar mineração
	if is_mining:
		mining_time += delta
		mining_progress.value = (mining_time / mining_duration) * 100
		
		if mining_time >= mining_duration:
			complete_mining()
	
	# Processar combate
	if is_in_combat:
		combat_timer += delta
		if combat_timer >= COMBAT_INTERVAL:
			combat_timer = 0.0
			process_combat_round()

func _on_mine_copper_pressed():
	start_mining("Cobre")

func _on_mine_iron_pressed():
	start_mining("Ferro")

func start_mining(resource_name: String):
	if not is_mining:
		is_mining = true
		current_mining_resource = resource_name
		mining_time = 0.0
		mining_status_label.text = "Status: Minerando %s..." % resource_name
		mining_progress.value = 0
		
		# Aplicar upgrade de mineração se comprado
		if has_mining_upgrade:
			mining_duration = MINING_DURATION_BASE * (1.0 - MINING_UPGRADE_REDUCTION)
		else:
			mining_duration = MINING_DURATION_BASE

func complete_mining():
	GameManager.add_resource(current_mining_resource, 1)
	GameManager.add_skill_xp("Mineração", 10)
	is_mining = false
	mining_status_label.text = "Status: %s coletado!" % current_mining_resource
	mining_progress.value = 0

func _on_craft_wood_sword_pressed():
	if GameManager.resources.get("Madeira", 0) >= 10:
		GameManager.remove_resource("Madeira", 10)
		GameManager.add_tool("Espada de Madeira", 1)
		GameManager.add_skill_xp("Criação", 20)
		add_weapon_to_dropdown("Espada de Madeira")
		update_ui()
		show_status_message("Espada de Madeira criada com sucesso!")
	else:
		show_status_message("Recursos insuficientes! Precisa de 10 Madeira.")

func _on_craft_iron_sword_pressed():
	if GameManager.resources.get("Ferro", 0) >= 15:
		GameManager.remove_resource("Ferro", 15)
		GameManager.add_tool("Espada de Ferro", 1)
		GameManager.add_skill_xp("Criação", 40)
		add_weapon_to_dropdown("Espada de Ferro")
		update_ui()
		show_status_message("Espada de Ferro criada com sucesso!")
	else:
		show_status_message("Recursos insuficientes! Precisa de 15 Ferro.")

# Helper para adicionar arma ao dropdown se ainda não existir
func add_weapon_to_dropdown(weapon_name: String) -> void:
	var weapon_exists = false
	for i in range(weapon_option.get_item_count()):
		if weapon_option.get_item_text(i) == weapon_name:
			weapon_exists = true
			break
	if not weapon_exists:
		weapon_option.add_item(weapon_name)

# Helper para mostrar mensagens ao usuário
func show_status_message(message: String) -> void:
	# Por enquanto apenas print, mas poderia ser um toast/notification na UI
	print(message)

func _on_start_combat_pressed():
	is_in_combat = true
	player_hp = player_max_hp
	current_monster = {
		"name": "Slime", 
		"hp": SLIME_HP, 
		"max_hp": SLIME_HP, 
		"damage": SLIME_DAMAGE, 
		"coins": SLIME_COINS
	}
	combat_timer = 0.0
	start_combat_button.disabled = true
	stop_combat_button.disabled = false
	combat_status_label.text = "Status: Em combate!"
	update_combat_ui()

func _on_stop_combat_pressed():
	is_in_combat = false
	start_combat_button.disabled = false
	stop_combat_button.disabled = true
	combat_status_label.text = "Status: Combate parado"

func _on_weapon_selected(index: int):
	var weapon_name = weapon_option.get_item_text(index)
	if weapon_name == "Sem Arma":
		GameManager.equipped_weapon = ""  # Permitir desequipar
	else:
		if not GameManager.equip_weapon(weapon_name):
			show_status_message("Não foi possível equipar %s" % weapon_name)
			return
	update_combat_ui()

func process_combat_round():
	# Jogador ataca monstro
	var player_damage = GameManager.get_weapon_damage()
	current_monster["hp"] -= player_damage
	
	if current_monster["hp"] <= 0:
		# Monstro derrotado
		GameManager.add_coins(current_monster["coins"])
		GameManager.add_skill_xp("Combate", 15)
		combat_status_label.text = "Status: %s derrotado! +%d moedas" % [current_monster["name"], current_monster["coins"]]
		# Criar novo monstro
		current_monster = {
			"name": "Slime", 
			"hp": SLIME_HP, 
			"max_hp": SLIME_HP, 
			"damage": SLIME_DAMAGE, 
			"coins": SLIME_COINS
		}
	else:
		# Monstro ataca jogador
		player_hp -= current_monster["damage"]
		
		if player_hp <= 0:
			# Jogador derrotado
			combat_status_label.text = "Status: Você foi derrotado!"
			is_in_combat = false
			start_combat_button.disabled = false
			stop_combat_button.disabled = true
	
	update_combat_ui()

func _on_buy_mining_upgrade():
	if GameManager.coins >= 100 and not has_mining_upgrade:
		if GameManager.remove_coins(100):
			has_mining_upgrade = true
			upgrade1_buy_button.text = "Comprado"
			upgrade1_buy_button.disabled = true

func _on_buy_armor_upgrade():
	if GameManager.coins >= 150 and not has_armor_upgrade:
		if GameManager.remove_coins(150):
			has_armor_upgrade = true
			player_max_hp = 100 + ARMOR_UPGRADE_HP_BONUS
			player_hp = player_max_hp
			upgrade2_buy_button.text = "Comprado"
			upgrade2_buy_button.disabled = true
			update_combat_ui()

func _on_resource_changed(resource_name: String, amount: int):
	update_ui()

func _on_coins_changed(amount: int):
	coins_label.text = "Moedas: %d" % amount

func _on_skill_xp_changed(skill_name: String, xp: int, level: int):
	if skill_name == "Mineração":
		mining_level_label.text = "Nível de Mineração: %d" % level
		var xp_in_level = xp % GameManager.XP_PER_LEVEL
		mining_xp_label.text = "XP: %d / %d" % [xp_in_level, GameManager.XP_PER_LEVEL]
		mining_progress_bar.value = xp_in_level

func update_ui():
	# Atualizar recursos (usar .get() para segurança)
	copper_amount_label.text = "Quantidade: %d" % GameManager.resources.get("Cobre", 0)
	iron_amount_label.text = "Quantidade: %d" % GameManager.resources.get("Ferro", 0)
	
	# Atualizar moedas
	coins_label.text = "Moedas: %d" % GameManager.coins

func update_combat_ui():
	player_hp_label.text = "HP: %d / %d" % [player_hp, player_max_hp]
	player_damage_label.text = "Dano: %d" % GameManager.get_weapon_damage()
	monster_name_label.text = current_monster["name"]
	monster_hp_label.text = "HP: %d / %d" % [current_monster["hp"], current_monster["max_hp"]]
	monster_damage_label.text = "Dano: %d" % current_monster["damage"]
