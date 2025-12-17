# Melvor Idle Clone

Um clone simplificado do jogo Melvor Idle, desenvolvido em Godot 4.5.

## 📋 Descrição

Este projeto é um protótipo funcional de um jogo incremental/idle inspirado no Melvor Idle. O foco está em mecânicas essenciais e placeholders visuais para demonstrar a estrutura do jogo.

## 🎮 Funcionalidades Implementadas

### 1. Interface Principal (HUD)
- Sistema de abas para navegação entre diferentes áreas do jogo
- Barra superior com display de moedas
- Interface responsiva com painéis organizados

### 2. Sistema de Coleta (Mineração)
- Mineração de recursos: **Cobre** e **Ferro**
- Barra de progresso de coleta (2 segundos por recurso)
- Sistema de experiência e níveis de habilidade
- Progressão: 100 XP = 1 nível
- Interface com placeholders coloridos para cada recurso

### 3. Sistema de Combate Automático
- Combate automático contra monstros (Slime)
- Sistema de HP para jogador e monstro
- Seleção de armas/ferramentas
- Recompensas em moedas após derrotar monstros
- Sistema de dano baseado na arma equipada:
  - Sem arma: 1 de dano
  - Espada de Madeira: 5 de dano
  - Espada de Ferro: 10 de dano
- Ataque automático a cada 2 segundos
- Geração automática de novos monstros após derrota

### 4. Sistema de Criação (Crafting)
- Receita: **Espada de Madeira** (Requer: 10 Madeira, Dano: 5)
- Receita: **Espada de Ferro** (Requer: 15 Ferro, Dano: 10)
- Sistema de consumo de recursos
- Ganho de XP de Criação ao fabricar itens
- Ferramentas criadas são automaticamente adicionadas ao inventário

### 5. Sistema de Economia
- Moedas ganhas através do combate
- Loja com upgrades disponíveis:
  - **Picareta Melhorada**: +20% velocidade de mineração (100 moedas)
  - **Armadura Básica**: +20 HP máximo (150 moedas)
- Sistema persistente de moedas

### 6. Estrutura Modular
Organização do código preparada para expansão:
```
melvor-idle-clone/
├── project.godot          # Configuração do projeto
├── icon.svg              # Ícone do projeto
├── scenes/
│   └── main.tscn        # Cena principal com todas as abas
├── scripts/
│   ├── game_manager.gd  # Singleton global (recursos, economia, habilidades)
│   └── main.gd          # Lógica principal do jogo
└── resources/
    └── icons/           # Diretório para futuros ícones
```

## 🎨 Design Visual

O projeto utiliza **placeholders geométricos** com cores distintas:
- **Cobre**: Laranja/marrom (#CC8033)
- **Ferro**: Cinza metálico (#999999)
- **Madeira**: Marrom escuro (#996633)
- **Jogador**: Verde (#33CC33)
- **Monstro**: Vermelho (#CC3333)
- **Upgrades**: Azul (#4D7FCC) e Vermelho (#CC4D4D)

## 🚀 Como Executar

### Requisitos
- **Godot Engine 4.3+** (recomendado 4.5)
- Sistema operacional: Windows, Linux ou macOS

### Passos
1. Baixe e instale o Godot Engine 4.5 em [godotengine.org](https://godotengine.org/)
2. Clone este repositório:
   ```bash
   git clone https://github.com/allansduarte/melvor-idle-clone.git
   cd melvor-idle-clone
   ```
3. Abra o Godot Engine
4. Clique em "Import" e selecione o arquivo `project.godot`
5. Clique em "Import & Edit"
6. Pressione **F5** ou clique no botão "Play" para executar o jogo

## 🎯 Gameplay Básico

1. **Comece Minerando**: Na aba "Coleta", clique em "Minerar Cobre" para coletar recursos
2. **Ganhe XP**: Cada recurso coletado dá 10 XP de Mineração
3. **Craft Armas**: Com recursos suficientes, vá para "Criação" e fabrique uma Espada
4. **Entre em Combate**: Na aba "Combate", selecione sua arma e clique em "Iniciar Combate"
5. **Ganhe Moedas**: Derrote monstros para ganhar moedas (10 por Slime)
6. **Compre Upgrades**: Use suas moedas na "Loja" para melhorar suas habilidades

## 🔧 Arquitetura Técnica

### GameManager (Autoload Singleton)
Sistema central que gerencia:
- Recursos do jogador (dictionary)
- Moedas (integer)
- Habilidades e XP (dictionary)
- Inventário de ferramentas (dictionary)
- Arma equipada (string)
- Sinais (signals) para atualização de UI

### Main Script
Controla:
- Lógica de mineração com timer
- Sistema de combate automático
- Interface e atualização de UI
- Compra de upgrades
- Crafting de itens

## 📈 Próximas Expansões Possíveis

- [ ] Adicionar mais recursos (Ouro, Prata, Gemas)
- [ ] Mais tipos de monstros com diferentes recompensas
- [ ] Sistema de dungeons
- [ ] Mais habilidades (Pesca, Culinária, Alquimia)
- [ ] Sistema de achievements
- [ ] Save/Load do progresso
- [ ] Animações e efeitos visuais
- [ ] Sistema de prestige/reset
- [ ] Multipliers e boost temporários

## 📝 Notas de Desenvolvimento

- O projeto usa Godot 4.3+ features (GDScript 2.0)
- Interface construída com Control nodes e containers
- Sistema modular permite fácil adição de novos recursos
- Todos os valores são balanceados para demonstração rápida
- Código comentado em português para facilitar contribuições

## 🤝 Contribuindo

Pull requests são bem-vindos! Para mudanças maiores:
1. Abra uma issue primeiro para discutir a mudança
2. Fork o projeto
3. Crie uma branch para sua feature
4. Commit suas mudanças
5. Push para a branch
6. Abra um Pull Request

## 📄 Licença

Este é um projeto educacional e de código aberto.

## 👥 Autor

**Allan Duarte** - [@allansduarte](https://github.com/allansduarte)