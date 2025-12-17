# Guia de Gameplay - Melvor Idle Clone

## 🎮 Interface do Jogo

### Layout Geral
```
┌─────────────────────────────────────────────────────────────┐
│  TOP BAR                                                     │
│  Moedas: 0                                                   │
├─────────────────────────────────────────────────────────────┤
│  [Coleta] [Criação] [Combate] [Loja]                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  CONTEÚDO DA ABA SELECIONADA                                │
│                                                              │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 📑 Aba: Coleta (Mining)

### Sistema de Mineração
```
┌────────────────────────────────────────────────────┐
│           Sistema de Mineração                     │
├────────────────────────────────────────────────────┤
│  Nível de Mineração: 1                            │
│  XP: 0 / 100                                       │
│  [████░░░░░░] Barra de Progresso                  │
├────────────────────────────────────────────────────┤
│  ┌──────────────┐    ┌──────────────┐            │
│  │   [COBRE]   │    │   [FERRO]    │            │
│  │   ▓▓▓▓▓▓    │    │   ▓▓▓▓▓▓     │            │
│  │ Quantidade: 0│    │ Quantidade: 0│            │
│  │ [Minerar]   │    │ [Minerar]    │            │
│  └──────────────┘    └──────────────┘            │
├────────────────────────────────────────────────────┤
│  Status: Aguardando...                            │
│  [░░░░░░░░░░] Progresso de Mineração              │
└────────────────────────────────────────────────────┘
```

### Como Funciona
1. **Clique** em "Minerar Cobre" ou "Minerar Ferro"
2. A **barra de progresso** preenche em 2 segundos (1.6s com upgrade)
3. Você **ganha 1 recurso** e **10 XP** ao completar
4. O processo pode ser repetido infinitamente

### Progressão de Nível
- **100 XP = 1 Nível**
- Níveis aumentam automaticamente com XP
- Barra de progresso mostra XP atual dentro do nível

## 🔨 Aba: Criação (Crafting)

### Receitas Disponíveis
```
┌────────────────────────────────────────────────────┐
│            Sistema de Criação                      │
├────────────────────────────────────────────────────┤
│  ┌─────────────────┐    ┌─────────────────┐       │
│  │ Espada Madeira │    │ Espada Ferro    │       │
│  │  ▓▓▓▓▓▓▓▓▓     │    │  ▓▓▓▓▓▓▓▓▓      │       │
│  │ Requer:        │    │ Requer:         │       │
│  │ 10 Madeira     │    │ 15 Ferro        │       │
│  │ Dano: 5        │    │ Dano: 10        │       │
│  │ [Criar]        │    │ [Criar]         │       │
│  └─────────────────┘    └─────────────────┘       │
└────────────────────────────────────────────────────┘
```

### Receitas Detalhadas

#### Espada de Madeira
- **Recursos**: 10 Madeira
- **Dano**: 5
- **XP Ganho**: 20 XP de Criação
- **Uso**: Equipar para combate

#### Espada de Ferro
- **Recursos**: 15 Ferro
- **Dano**: 10
- **XP Ganho**: 40 XP de Criação
- **Uso**: Equipar para combate (mais forte que madeira)

### Dica
💡 O jogo inicia com **10 Madeira** gratuitas para você poder fazer sua primeira espada!

## ⚔️ Aba: Combate (Combat)

### Interface de Combate
```
┌────────────────────────────────────────────────────┐
│       Sistema de Combate Automático                │
├────────────────────────────────────────────────────┤
│  Selecione sua arma:                               │
│  [Sem Arma ▼]                                      │
├────────────────────────────────────────────────────┤
│  ┌────────────┐          ┌────────────┐           │
│  │  JOGADOR  │          │   SLIME    │           │
│  │  ▓▓▓▓▓▓   │          │   ▓▓▓▓▓▓   │           │
│  │ HP: 100/100│          │ HP: 30/30  │           │
│  │ Dano: 1   │          │ Dano: 3    │           │
│  └────────────┘          └────────────┘           │
├────────────────────────────────────────────────────┤
│  Status: Aguardando...                            │
│  [Iniciar Combate]  [Parar Combate]              │
└────────────────────────────────────────────────────┘
```

### Mecânica de Combate

#### Como Funciona
1. **Selecione uma arma** no menu dropdown (se tiver criado alguma)
2. Clique em **"Iniciar Combate"**
3. O combate ocorre **automaticamente** a cada 2 segundos:
   - Jogador ataca o monstro
   - Se monstro sobreviver, ele contra-ataca
4. **Derrote o monstro** para ganhar moedas e XP
5. Um **novo monstro aparece** automaticamente

#### Dano por Arma
| Arma                | Dano |
|---------------------|------|
| Sem Arma (punhos)   | 1    |
| Espada de Madeira   | 5    |
| Espada de Ferro     | 10   |

#### Estatísticas do Slime
- **HP**: 30
- **Dano**: 3
- **Recompensa**: 10 moedas
- **XP**: 15 XP de Combate (ao derrotar)

#### Estatísticas do Jogador
- **HP Base**: 100
- **HP com Armadura**: 120 (upgrade da loja)
- **Dano**: Baseado na arma equipada

### Estratégias
- 🗡️ **Sem arma**: Leva 30 turnos (1 minuto) para derrotar um Slime
- ⚔️ **Com Espada de Madeira**: Leva 6 turnos (12 segundos)
- 🗡️ **Com Espada de Ferro**: Leva 3 turnos (6 segundos)

## 🏪 Aba: Loja (Shop)

### Upgrades Disponíveis
```
┌────────────────────────────────────────────────────┐
│                   Loja                             │
├────────────────────────────────────────────────────┤
│  ┌──────────────────┐    ┌──────────────────┐     │
│  │ Picareta         │    │ Armadura         │     │
│  │ Melhorada       │    │ Básica           │     │
│  │   ▓▓▓▓▓▓        │    │   ▓▓▓▓▓▓         │     │
│  │ +20% vel.       │    │ +20 HP max       │     │
│  │ mineração       │    │                  │     │
│  │ Preço: 100      │    │ Preço: 150       │     │
│  │ [Comprar]       │    │ [Comprar]        │     │
│  └──────────────────┘    └──────────────────┘     │
└────────────────────────────────────────────────────┘
```

### Detalhes dos Upgrades

#### Picareta Melhorada
- **Custo**: 100 moedas
- **Efeito**: Reduz tempo de mineração de 2.0s para 1.6s
- **Benefício**: +20% velocidade de coleta
- **Permanente**: Sim

#### Armadura Básica
- **Custo**: 150 moedas
- **Efeito**: Aumenta HP máximo de 100 para 120
- **Benefício**: Sobrevive mais tempo no combate
- **Permanente**: Sim

## 🎯 Progressão Sugerida

### Início do Jogo (Primeiros 5 minutos)
1. **Mine Madeira** (já tem 10 disponíveis inicialmente)
2. Vá para **Criação** → Crie **Espada de Madeira**
3. Vá para **Combate** → Selecione a espada → **Inicie combate**
4. **Derrote 10 Slimes** para ganhar 100 moedas
5. Vá para **Loja** → Compre **Picareta Melhorada**

### Meio do Jogo (5-15 minutos)
1. Volte para **Coleta** → Mine **Ferro** (mais rápido com upgrade!)
2. Colete **15 Ferros**
3. Vá para **Criação** → Crie **Espada de Ferro**
4. Volte ao **Combate** → Equipe a espada de ferro
5. **Derrote 15 Slimes** para ganhar 150 moedas
6. Vá para **Loja** → Compre **Armadura Básica**

### Late Game (15+ minutos)
1. Continue minerando e combatendo
2. Acumule recursos e moedas
3. Aumente seus níveis de habilidade
4. Experimente diferentes estratégias

## 📊 Sistema de Experiência

### Tabela de XP por Atividade
| Atividade              | XP Ganho | Habilidade  |
|------------------------|----------|-------------|
| Minerar (qualquer)     | 10 XP    | Mineração   |
| Craftar Espada Madeira | 20 XP    | Criação     |
| Craftar Espada Ferro   | 40 XP    | Criação     |
| Derrotar Slime         | 15 XP    | Combate     |

### Cálculo de Nível
```
Nível = 1 + (XP Total ÷ 100)
```

### Exemplos
- **50 XP** = Nível 1
- **100 XP** = Nível 2
- **250 XP** = Nível 3
- **1000 XP** = Nível 11

## 💡 Dicas e Truques

### Eficiência de Mineração
- ⛏️ Compre a **Picareta Melhorada** o mais cedo possível
- 📈 Priorize Ferro sobre Cobre (mais útil para crafting)
- 🔄 Mine enquanto planeja suas próximas ações

### Eficiência de Combate
- 🗡️ **Sempre use uma arma** - combate sem arma é muito lento
- 💰 Slimes são a única fonte de moedas no momento
- ❤️ Compre armadura se estiver morrendo muito

### Eficiência de Economia
- 💵 Picareta primeiro (100g) → Armadura depois (150g)
- 📊 Cada Slime = 10 moedas = 0.1% do primeiro upgrade
- 🎯 Foque em derrotar Slimes rapidamente para maximizar moedas/minuto

### Maximizando Progressão
1. **Mine Madeira** → Crie espada → Ganhe moedas no combate
2. **Compre Picareta** → Mine Ferro mais rápido
3. **Crie Espada de Ferro** → Mate Slimes mais rápido
4. **Compre Armadura** → Sobreviva mais
5. **Repita** o ciclo para maximizar todas as habilidades

## 🐛 Comportamentos Esperados

### Mineração
- ✅ Progresso reseta se você iniciar nova mineração
- ✅ Você pode minerar indefinidamente
- ✅ Recursos são salvos instantaneamente

### Combate
- ✅ Combate continua até você parar ou morrer
- ✅ Novos monstros aparecem automaticamente
- ✅ HP do jogador reseta ao iniciar novo combate
- ✅ Moedas são creditadas imediatamente

### Crafting
- ✅ Recursos são consumidos instantaneamente
- ✅ Ferramentas vão para o inventário automaticamente
- ✅ Não há limite de crafts

### Loja
- ✅ Upgrades são permanentes
- ✅ Cada upgrade pode ser comprado apenas uma vez
- ✅ Botões ficam desabilitados após compra

## 🎨 Legenda de Cores

- 🟠 **Laranja/Marrom** - Cobre
- ⚪ **Cinza** - Ferro
- 🟤 **Marrom** - Madeira
- 🟢 **Verde** - Jogador
- 🔴 **Vermelho** - Monstro/Inimigo
- 🔵 **Azul** - Upgrades/Melhorias

## 📞 Suporte

Se encontrar bugs ou tiver sugestões:
1. Abra uma **Issue** no GitHub
2. Descreva o problema detalhadamente
3. Inclua passos para reproduzir (se aplicável)

---

**Divirta-se jogando!** 🎮✨
