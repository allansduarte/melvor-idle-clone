# Guia de Contribuição

Obrigado por considerar contribuir com o Melvor Idle Clone! Este documento fornece diretrizes para contribuir com o projeto.

## 🎯 Como Contribuir

### 1. Reportar Bugs

Se você encontrou um bug:

1. **Verifique** se já não existe uma issue sobre o bug
2. **Crie uma nova issue** com:
   - Título descritivo
   - Passos para reproduzir
   - Comportamento esperado vs. atual
   - Screenshots (se aplicável)
   - Versão do Godot e SO

**Template de Bug Report:**
```markdown
**Descrição do Bug**
Descrição clara e concisa do bug.

**Passos para Reproduzir**
1. Vá para '...'
2. Clique em '...'
3. Veja o erro

**Comportamento Esperado**
O que deveria acontecer.

**Screenshots**
Se aplicável, adicione screenshots.

**Ambiente**
- Godot Version: [e.g. 4.5]
- OS: [e.g. Windows 11]
```

### 2. Sugerir Funcionalidades

Para sugerir novas features:

1. **Verifique** se já não existe uma issue similar
2. **Crie uma issue** com label "enhancement"
3. **Descreva**:
   - O problema que resolve
   - A solução proposta
   - Alternativas consideradas
   - Impacto no projeto

**Template de Feature Request:**
```markdown
**Problema a Resolver**
Descrição clara do problema ou necessidade.

**Solução Proposta**
Como você imagina que isso funcionaria?

**Alternativas**
Outras abordagens que você considerou?

**Contexto Adicional**
Qualquer outra informação relevante.
```

### 3. Contribuir com Código

#### Setup do Ambiente

1. **Fork** o repositório
2. **Clone** seu fork:
   ```bash
   git clone https://github.com/seu-usuario/melvor-idle-clone.git
   cd melvor-idle-clone
   ```
3. **Abra no Godot 4.5+**
4. Crie uma **branch** para sua feature:
   ```bash
   git checkout -b feature/nome-da-feature
   ```

#### Diretrizes de Código

##### Estilo GDScript

```gdscript
# Use snake_case para variáveis e funções
var player_health = 100
func calculate_damage() -> int:
    return 5

# Use PascalCase para classes e nós
class_name PlayerManager
@onready var PlayerSprite = $Sprite2D

# Tipagem estática sempre que possível
var coins: int = 0
func add_resource(name: String, amount: int) -> void:
    pass

# Comentários claros em português
# Calcula o dano total baseado na arma equipada
func get_total_damage() -> int:
    return base_damage + weapon_damage
```

##### Organização de Código

```gdscript
extends Node

# ============================================
# SIGNALS
# ============================================
signal health_changed(new_health: int)

# ============================================
# CONSTANTS
# ============================================
const MAX_HEALTH = 100

# ============================================
# EXPORTED VARIABLES
# ============================================
@export var starting_gold: int = 0

# ============================================
# PUBLIC VARIABLES
# ============================================
var health: int = MAX_HEALTH

# ============================================
# PRIVATE VARIABLES
# ============================================
var _internal_timer: float = 0.0

# ============================================
# ONREADY VARIABLES
# ============================================
@onready var sprite = $Sprite2D

# ============================================
# LIFECYCLE METHODS
# ============================================
func _ready():
    pass

func _process(delta):
    pass

# ============================================
# PUBLIC METHODS
# ============================================
func take_damage(amount: int) -> void:
    health -= amount
    health_changed.emit(health)

# ============================================
# PRIVATE METHODS
# ============================================
func _calculate_defense() -> int:
    return 0

# ============================================
# SIGNAL HANDLERS
# ============================================
func _on_button_pressed():
    pass
```

##### Boas Práticas

✅ **FAÇA:**
- Use tipagem estática
- Comente código complexo
- Mantenha funções pequenas e focadas
- Use sinais para comunicação entre nós
- Nomeie variáveis de forma descritiva
- Trate casos de erro

❌ **NÃO FAÇA:**
- Magic numbers sem explicação
- Funções muito longas (>50 linhas)
- Acoplamento forte entre sistemas
- Ignorar warnings do Godot
- Commitar código comentado
- Usar `get_node()` em loops

#### Commits

Use mensagens de commit claras e descritivas:

**Formato:**
```
<tipo>: <descrição curta>

<descrição detalhada opcional>
```

**Tipos:**
- `feat:` Nova funcionalidade
- `fix:` Correção de bug
- `docs:` Documentação
- `style:` Formatação, pontuação
- `refactor:` Refatoração de código
- `test:` Adição de testes
- `chore:` Manutenção, build

**Exemplos:**
```bash
feat: Add fishing skill system

Implements basic fishing mechanic with:
- Random catch system
- New fish resources
- Fishing XP and leveling
```

```bash
fix: Correct mining progress bar not resetting

The progress bar was not resetting to 0 after completing mining.
Fixed by setting value to 0 in complete_mining() function.
```

#### Pull Requests

1. **Atualize** sua branch com a main:
   ```bash
   git fetch origin
   git rebase origin/main
   ```

2. **Teste** suas mudanças extensivamente

3. **Crie** um Pull Request com:
   - Título descritivo
   - Descrição das mudanças
   - Screenshots/GIFs se houver mudanças visuais
   - Referência a issues relacionadas

**Template de PR:**
```markdown
## Descrição
Breve descrição do que foi mudado e por quê.

## Tipo de Mudança
- [ ] Bug fix
- [ ] Nova feature
- [ ] Breaking change
- [ ] Documentação

## Testes Realizados
Descreva os testes que você realizou:
- [ ] Testei no Godot 4.5
- [ ] Verifiquei que não há warnings
- [ ] Testei em [Windows/Linux/Mac]

## Screenshots
Se aplicável, adicione screenshots.

## Checklist
- [ ] Meu código segue o estilo do projeto
- [ ] Revisei meu próprio código
- [ ] Comentei código complexo
- [ ] Atualizei documentação
- [ ] Minhas mudanças não geram warnings
- [ ] Não há issues relacionadas que devam ser fechadas
```

## 🏗️ Estrutura do Projeto

### Arquivos e Responsabilidades

```
melvor-idle-clone/
│
├── scenes/                    # Cenas do jogo
│   ├── main.tscn             # ✏️ UI principal
│   └── [futuras cenas]
│
├── scripts/                   # Lógica do jogo
│   ├── game_manager.gd       # ✏️ Estado global
│   ├── main.gd               # ✏️ Controller principal
│   └── [futuros sistemas]
│
├── resources/                 # Assets
│   ├── icons/                # 🎨 Ícones e sprites
│   └── [futuros assets]
│
├── docs/                      # 📚 Documentação adicional (futuro)
│
├── README.md                  # 📖 Documentação principal
├── GAMEPLAY.md                # 🎮 Guia de gameplay
├── ARCHITECTURE.md            # 🏗️ Docs técnica
└── CONTRIBUTING.md            # 📝 Este arquivo
```

### Quando Modificar Cada Arquivo

**game_manager.gd** - Modifique quando:
- Adicionar novos recursos globais
- Criar novas habilidades
- Adicionar sistema de inventário
- Implementar save/load

**main.gd** - Modifique quando:
- Adicionar lógica de gameplay
- Criar novos sistemas de UI
- Implementar loops de jogo

**main.tscn** - Modifique quando:
- Adicionar nova UI
- Reorganizar layout
- Criar novos painéis/abas

## 🎨 Contribuindo com Arte

### Assets Necessários

Estamos procurando por:
- 🎨 Sprites para recursos (16x16 ou 32x32)
- 🐉 Sprites para monstros
- ⚔️ Ícones para armas/ferramentas
- 🏪 Ícones para upgrades
- 🎭 Sprites para UI elements

### Diretrizes de Arte

- **Formato:** PNG com transparência
- **Estilo:** Pixel art ou flat design
- **Tamanho:** Múltiplos de 16px (16, 32, 64)
- **Paleta:** Coerente com o jogo
- **Licença:** Deve ser livre ou com atribuição clara

## 📚 Recursos para Aprender

### Godot Engine
- [Documentação Oficial](https://docs.godotengine.org/)
- [GDScript Basics](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/)
- [Godot Tutorials](https://www.youtube.com/c/GodotEngineOfficial)

### Design de Jogos Idle
- [Idle Game Design](https://www.gamasutra.com/blogs/IdleGames/)
- [Balanceamento de Jogos](https://www.redblobgames.com/)

## 🐛 Debug e Troubleshooting

### Problemas Comuns

#### "GameManager not found"
```gdscript
# Verifique se está registrado como autoload em project.godot
[autoload]
GameManager="*res://scripts/game_manager.gd"
```

#### "Invalid call to nonexistent function"
```gdscript
# Verifique tipagem e se o método existe
# Use code completion (Ctrl+Space) para ajudar
```

#### "Scene não carrega"
```gdscript
# Verifique paths relativos
# Use res:// para paths absolutos
```

### Ferramentas de Debug

```gdscript
# Print com contexto
print("Player HP: ", player_hp)

# Assert para validação
assert(health > 0, "Health cannot be negative")

# Breakpoints
# Clique na margem esquerda do editor para adicionar
```

## 🤝 Código de Conduta

### Nossos Valores

- 🌟 **Respeito**: Trate todos com cortesia
- 💡 **Construtividade**: Críticas devem ser construtivas
- 🤗 **Inclusão**: Todos são bem-vindos
- 📚 **Aprendizado**: Compartilhe conhecimento
- 🎯 **Foco**: Mantenha discussões relevantes

### Comportamentos Esperados

✅ Usar linguagem acolhedora e inclusiva
✅ Respeitar pontos de vista diferentes
✅ Aceitar críticas construtivas
✅ Focar no que é melhor para a comunidade

❌ Linguagem sexualizada ou inapropriada
❌ Trolling, insultos ou ataques pessoais
❌ Assédio público ou privado
❌ Publicar informação privada de outros

## 📞 Comunicação

### Onde Pedir Ajuda

- **Issues**: Para bugs e features
- **Discussions**: Para perguntas gerais
- **Pull Requests**: Para code review

### Tempo de Resposta

- Issues: 1-3 dias
- Pull Requests: 2-5 dias
- Perguntas: 1-7 dias

Seja paciente! Este é um projeto mantido por voluntários.

## 🎉 Reconhecimento

Contribuidores são reconhecidos em:
- README.md (seção de Contributors)
- Release notes
- Commits (via Co-authored-by)

## 📄 Licença

Ao contribuir, você concorda que suas contribuições serão licenciadas sob a mesma licença do projeto.

---

**Obrigado por contribuir!** 🙏

Cada contribuição, não importa o tamanho, é valorizada e ajuda a tornar este projeto melhor.

Se tiver dúvidas, não hesite em perguntar abrindo uma issue com a tag "question".

Happy coding! 🚀
