# Arquitetura Técnica - Melvor Idle Clone

## 📐 Visão Geral da Arquitetura

Este documento detalha a arquitetura técnica do projeto, incluindo a organização de código, fluxo de dados e padrões utilizados.

## 🗂️ Estrutura de Arquivos

```
melvor-idle-clone/
│
├── project.godot              # Configuração principal do projeto Godot
├── icon.svg                   # Ícone da aplicação
├── .gitignore                 # Arquivos ignorados pelo Git
│
├── README.md                  # Documentação principal
├── GAMEPLAY.md                # Guia de gameplay detalhado
├── ARCHITECTURE.md            # Este arquivo (documentação técnica)
│
├── scenes/                    # Cenas do Godot (.tscn)
│   └── main.tscn             # Cena principal do jogo
│
├── scripts/                   # Scripts GDScript (.gd)
│   ├── game_manager.gd       # Singleton global (autoload)
│   └── main.gd               # Controller da cena principal
│
└── resources/                 # Assets e recursos
    └── icons/                 # Futuros ícones e sprites
```

## 🔄 Fluxo de Dados

### Arquitetura Singleton Pattern

```
┌─────────────────────────────────────────────────┐
│         GameManager (Autoload Singleton)        │
│  • Estado Global                                │
│  • Resources (Dict)                             │
│  • Coins (Int)                                  │
│  • Skills (Dict)                                │
│  • Tools/Weapons (Dict)                         │
│  • Signals para UI updates                      │
└──────────────┬──────────────────────────────────┘
               │
               ├──────── Emit Signals ──────────┐
               │                                 │
               ▼                                 ▼
┌──────────────────────────┐    ┌──────────────────────────┐
│      Main Scene (UI)     │    │   Future Scenes          │
│  • Tabs (Coleta/Craft/   │    │  • Dungeons              │
│    Combat/Shop)          │    │  • Inventory             │
│  • Update UI on signals  │    │  • Character Screen      │
│  • Process game loops    │    │  • Settings              │
└──────────────────────────┘    └──────────────────────────┘
```

## 🎯 Sistema de Sinais (Signals)

### GameManager Signals

```gdscript
# Quando um recurso é adicionado/removido
signal resource_changed(resource_name: String, amount: int)

# Quando moedas mudam
signal coins_changed(amount: int)

# Quando XP/Level de habilidade muda
signal skill_xp_changed(skill_name: String, xp: int, level: int)

# Para futuras atualizações de combate em tempo real
signal combat_update(monster_hp: int, player_hp: int)
```

### Fluxo de Atualização da UI

```
┌──────────────┐
│   Ação do    │
│   Jogador    │
└──────┬───────┘
       │
       ▼
┌──────────────────────┐
│  main.gd             │
│  (Process Action)    │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│  GameManager         │
│  (Update State)      │
└──────┬───────────────┘
       │
       ▼ emit signal
┌──────────────────────┐
│  main.gd             │
│  (Connected Handler) │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│  UI Update           │
│  (Labels, Bars, etc) │
└──────────────────────┘
```

## 🏗️ Componentes Principais

### 1. GameManager (game_manager.gd)

**Responsabilidade**: Gerenciador de estado global do jogo

**Dados Gerenciados**:
```gdscript
resources: Dictionary {
    "Cobre": int,
    "Ferro": int,
    "Madeira": int
}

coins: int

skills: Dictionary {
    "Mineração": {"xp": int, "level": int},
    "Combate": {"xp": int, "level": int},
    "Criação": {"xp": int, "level": int}
}

tools: Dictionary {
    "Espada de Madeira": int,
    "Espada de Ferro": int
}

equipped_weapon: String
```

**Métodos Principais**:
- `add_resource(name, amount)` - Adiciona recursos
- `remove_resource(name, amount)` - Remove recursos (retorna bool)
- `add_coins(amount)` - Adiciona moedas
- `remove_coins(amount)` - Remove moedas (retorna bool)
- `add_skill_xp(skill, xp)` - Adiciona XP e calcula level
- `add_tool(name, amount)` - Adiciona ferramenta ao inventário
- `equip_weapon(name)` - Equipa arma (retorna bool)
- `get_weapon_damage()` - Retorna dano da arma equipada

### 2. Main Controller (main.gd)

**Responsabilidade**: Controla lógica do jogo e UI da cena principal

**Estados Gerenciados**:
```gdscript
# Mining State
is_mining: bool
current_mining_resource: String
mining_time: float
mining_duration: float

# Combat State
is_in_combat: bool
player_hp: int
player_max_hp: int
current_monster: Dictionary
combat_timer: float
combat_interval: float

# Upgrades State
has_mining_upgrade: bool
has_armor_upgrade: bool
```

**Métodos Principais**:
- `_process(delta)` - Loop principal (mining & combat)
- `start_mining(resource)` - Inicia processo de mineração
- `complete_mining()` - Finaliza mineração e dá recompensas
- `process_combat_round()` - Processa um turno de combate
- `update_ui()` - Atualiza labels e displays
- Signal handlers para GameManager

### 3. Main Scene (main.tscn)

**Estrutura de Nós**:
```
Main (Control)
├── ColorRect (Background)
└── VBoxContainer
    ├── TopBar (Panel)
    │   └── CoinsLabel
    └── TabContainer
        ├── Coleta (Mining Tab)
        │   ├── Skill Info (Level, XP, Progress)
        │   ├── ResourcesGrid
        │   │   ├── CopperPanel
        │   │   └── IronPanel
        │   └── MiningProgress
        ├── Criação (Crafting Tab)
        │   └── RecipesGrid
        │       ├── WoodSwordPanel
        │       └── IronSwordPanel
        ├── Combate (Combat Tab)
        │   ├── WeaponSelection
        │   ├── CombatArea
        │   │   ├── PlayerPanel
        │   │   └── MonsterPanel
        │   └── ControlPanel
        └── Loja (Shop Tab)
            └── ShopGrid
                ├── UpgradePanel1 (Mining)
                └── UpgradePanel2 (Armor)
```

## ⚙️ Sistemas de Jogo

### Sistema de Mineração

```
┌─────────────────┐
│ Jogador Clica   │
│ "Minerar X"     │
└────────┬────────┘
         │
         ▼
┌─────────────────────┐
│ is_mining = true    │
│ mining_time = 0     │
│ current_resource= X │
└────────┬────────────┘
         │
         ▼ _process(delta)
┌─────────────────────┐
│ mining_time += δ    │
│ Update progress bar │
└────────┬────────────┘
         │
         ▼ (time >= duration)
┌─────────────────────┐
│ GameManager.        │
│   add_resource(X,1) │
│   add_skill_xp(10)  │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│ is_mining = false   │
│ Show completion msg │
└─────────────────────┘
```

### Sistema de Combate

```
┌─────────────────┐
│ Start Combat    │
│ Button Pressed  │
└────────┬────────┘
         │
         ▼
┌───────────────────────┐
│ is_in_combat = true   │
│ Reset player HP       │
│ Spawn monster         │
└────────┬──────────────┘
         │
         ▼ _process(delta) every 2s
┌───────────────────────────┐
│ Player attacks monster    │
│   damage = weapon_damage  │
│   monster_hp -= damage    │
└────────┬──────────────────┘
         │
         ├─── Monster HP > 0 ───┐
         │                       ▼
         │              ┌────────────────────┐
         │              │ Monster attacks    │
         │              │ player_hp -= dmg   │
         │              └────────┬───────────┘
         │                       │
         │                       ├─ Player dies? ─> End Combat
         │                       └─ Continue loop
         │
         └─── Monster HP <= 0 ──┐
                                 ▼
                        ┌────────────────────┐
                        │ GameManager.       │
                        │   add_coins(10)    │
                        │   add_xp(15)       │
                        │ Spawn new monster  │
                        └────────────────────┘
```

### Sistema de Crafting

```
┌─────────────────┐
│ Craft Button    │
│ Pressed         │
└────────┬────────┘
         │
         ▼
┌──────────────────────┐
│ Check if resources   │
│ sufficient           │
└────────┬─────────────┘
         │
         ├─── YES ───────┐
         │                ▼
         │     ┌──────────────────────┐
         │     │ GameManager.         │
         │     │   remove_resource()  │
         │     │   add_tool()         │
         │     │   add_skill_xp()     │
         │     └──────────┬───────────┘
         │                │
         │                ▼
         │     ┌──────────────────────┐
         │     │ Add to weapon list   │
         │     │ Update UI            │
         │     └──────────────────────┘
         │
         └─── NO ────────┐
                         ▼
                  ┌──────────────┐
                  │ Show error   │
                  │ (print msg)  │
                  └──────────────┘
```

### Sistema de Loja

```
┌─────────────────┐
│ Buy Button      │
│ Pressed         │
└────────┬────────┘
         │
         ▼
┌──────────────────────┐
│ Check coins & status │
│ (enough? not bought?)│
└────────┬─────────────┘
         │
         ├─── YES ───────┐
         │                ▼
         │     ┌──────────────────────┐
         │     │ GameManager.         │
         │     │   remove_coins()     │
         │     └──────────┬───────────┘
         │                │
         │                ▼
         │     ┌──────────────────────┐
         │     │ Apply upgrade effect │
         │     │ has_upgrade = true   │
         │     └──────────┬───────────┘
         │                │
         │                ▼
         │     ┌──────────────────────┐
         │     │ Disable button       │
         │     │ Update UI            │
         │     └──────────────────────┘
         │
         └─── NO ────────> (nothing happens)
```

## 🔧 Padrões de Design Utilizados

### 1. Singleton Pattern
- **GameManager**: Único ponto de acesso ao estado global
- **Benefício**: Evita duplicação de dados, facilita acesso

### 2. Observer Pattern (via Signals)
- **Signals**: GameManager emite sinais quando estado muda
- **Observers**: UI components conectam aos sinais
- **Benefício**: Desacoplamento entre lógica e UI

### 3. State Machine (Implicit)
- **Mining**: idle → mining → complete → idle
- **Combat**: idle → fighting → (victory/defeat) → idle
- **Benefício**: Estados claros e transições definidas

## 📊 Balanceamento de Valores

### Mining
```
Mining Duration: 2.0s (base) → 1.6s (com upgrade -20%)
XP per Resource: 10 XP
Resources por minuto: 30 (base) → 37.5 (com upgrade)
```

### Combat
```
Combat Interval: 2.0s por ataque
Player HP: 100 (base) → 120 (com upgrade +20)
Weapon Damage:
  - Sem Arma: 1
  - Espada Madeira: 5 (5x)
  - Espada Ferro: 10 (10x)

Monster (Slime):
  - HP: 30
  - Damage: 3
  - Coins: 10
  - XP: 15
```

### Crafting
```
Wood Sword:
  - Cost: 10 Madeira
  - Damage: 5
  - XP: 20

Iron Sword:
  - Cost: 15 Ferro
  - Damage: 10
  - XP: 40
```

### Shop
```
Mining Upgrade:
  - Cost: 100 coins (10 Slimes)
  - Effect: -20% mining time

Armor Upgrade:
  - Cost: 150 coins (15 Slimes)
  - Effect: +20 max HP
```

### Leveling
```
XP to Level: 100 XP = 1 level
Level Formula: level = 1 + floor(total_xp / 100)

Example progression:
  0-99 XP   → Level 1
  100-199   → Level 2
  200-299   → Level 3
  1000+     → Level 11+
```

## 🚀 Extensibilidade

### Adicionar Novo Recurso

1. **GameManager**: Adicionar ao dictionary `resources`
2. **Main Scene**: Adicionar novo painel na ResourcesGrid
3. **Main Script**: Adicionar handler do botão

### Adicionar Novo Monstro

1. **Main Script**: Criar novo dictionary com stats
2. Adicionar lógica de spawn/seleção
3. Opcional: Criar UI específica

### Adicionar Nova Receita

1. **Main Scene**: Adicionar painel na RecipesGrid
2. **Main Script**: Adicionar handler do botão de craft
3. **GameManager**: Adicionar ferramenta ao dictionary `tools`

### Adicionar Novo Upgrade

1. **Main Scene**: Adicionar painel na ShopGrid
2. **Main Script**: Adicionar variável `has_X_upgrade`
3. Adicionar handler e lógica de aplicação

## 🧪 Testando o Código

### Testes Manuais Recomendados

1. **Test Mining Flow**
   - Clicar em minerar
   - Verificar barra de progresso
   - Confirmar recurso adicionado
   - Verificar XP aumentou

2. **Test Crafting Flow**
   - Verificar recursos iniciais (10 madeira)
   - Craftar espada de madeira
   - Confirmar recursos consumidos
   - Verificar espada no inventário

3. **Test Combat Flow**
   - Equipar arma
   - Iniciar combate
   - Verificar dano aplicado
   - Verificar moedas ao derrotar monstro

4. **Test Shop Flow**
   - Ganhar 100+ moedas
   - Comprar upgrade
   - Verificar moedas deduzidas
   - Verificar efeito aplicado

## 📚 Referências de Código

### Convenções GDScript
- **snake_case** para variáveis e funções
- **PascalCase** para classes e nós
- **UPPER_CASE** para constantes (não usado ainda)
- Tipagem estática quando possível (`: Type`)

### Estrutura de Funções
```gdscript
func function_name(param: Type) -> ReturnType:
    # Código
    return value
```

### Signals
```gdscript
signal signal_name(param1: Type, param2: Type)

# Emitir
signal_name.emit(value1, value2)

# Conectar
signal_name.connect(handler_function)
```

## 🔮 Roadmap Técnico

### Próximas Melhorias Arquiteturais

1. **Save/Load System**
   - Criar SaveManager singleton
   - Serializar estado do GameManager
   - Salvar em JSON ou ConfigFile

2. **Resource Manager**
   - Separar recursos em próprio manager
   - Adicionar sistema de raridade
   - Implementar stacks e limites

3. **Combat Manager**
   - Separar lógica de combate
   - Implementar diferentes tipos de monstros
   - Sistema de loot tables

4. **UI Manager**
   - Centralizar updates de UI
   - Sistema de notificações/toasts
   - Transições entre telas

5. **Data-Driven Design**
   - Mover stats para JSON/CSV
   - Criar sistema de loading de dados
   - Facilitar balanceamento

---

**Documento atualizado**: 2024
**Versão do Projeto**: 1.0 (Prototype)
