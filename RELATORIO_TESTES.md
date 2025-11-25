# Relatório de Testes Automatizados - Estudazz App

## 1. Introdução

Este documento detalha a implementação inicial de uma suíte de testes automatizados para o aplicativo Estudazz. O objetivo foi criar uma base sólida de testes para garantir a qualidade, a manutenibilidade e a confiabilidade do código.

A estratégia adotada seguiu as melhores práticas para desenvolvimento Flutter, focando em duas categorias principais de testes:

- **Testes de Unidade (Unit Tests):** Para validar a lógica de negócio pura e isolada, como funções de validação e formatação.
- **Testes de Widget (Widget Tests):** Para verificar a renderização e a interatividade de componentes de UI individuais e de telas completas.

## 2. Ferramentas e Bibliotecas

A suíte de testes foi construída utilizando o framework padrão fornecido pelo SDK do Flutter:

- **`flutter_test`**: Biblioteca principal para a escrita de todos os testes de unidade e de widget.

Nenhuma outra dependência de teste foi necessária para a implementação atual.

## 3. Resumo dos Testes Implementados

Foram criados um total de **17 testes** automatizados, cobrindo lógica de validação, componentes de UI reutilizáveis e uma tela estática.

| Categoria | Alvo do Teste | Arquivo de Teste | Nº de Casos |
| :--- | :--- | :--- | :--- |
| Teste de Unidade | `textFieldValidator` | `textFieldValidator_test.dart` | 6 |
| Teste de Widget | `CustomAppBar` | `customAppBar_test.dart` | 6 |
| Teste de Widget | `ItensCards` | `itensCards_test.dart` | 3 |
| Teste de Widget | `AboutPage` | `aboutPage_test.dart` | 2 |

---

## 4. Detalhes dos Testes

### 4.1. Testes de Unidade

#### `TextFieldValidator`
- **Objetivo:** Garantir que a função de validação de campos de texto funcione corretamente para diferentes entradas.
- **Casos de Teste:**
  - Retorna erro quando o valor é `null`.
  - Retorna erro quando o valor é uma string vazia (`''`).
  - Retorna erro quando o valor contém apenas espaços em branco.
  - Retorna erro quando o valor tem menos de 3 caracteres.
  - Retorna sucesso (`null`) para valores válidos.

### 4.2. Testes de Widget

#### `CustomAppBar`
- **Objetivo:** Validar a UI e a lógica de exibição condicional da barra de aplicativos principal.
- **Casos de Teste:**
  - Renderiza o título fornecido corretamente.
  - Não exibe nenhum ícone de ação por padrão.
  - Exibe o ícone de "perfil" (`Icons.person`) quando `showPersonIcon` é `true`.
  - Exibe o ícone de "configurações" (`Icons.settings`) quando `showSettingsIAIcon` é `true`.
  - Exibe o ícone de "membros" (`Icons.group`) quando `showMembersIcon` é `true`.
  - Exibe múltiplos ícones simultaneamente de forma correta.

#### `ItensCards`
- **Objetivo:** Assegurar que o card genérico da home page renderize os dados e responda a interações.
- **Casos de Teste:**
  - Renderiza corretamente o título, a descrição e os ícones fornecidos.
  - Aciona a função de callback `onTap` quando o widget é tocado.
  - Não aciona a função `onTap` se não houver interação.

#### `AboutPage`
- **Objetivo:** Garantir que a tela "Sobre" seja montada com todo o seu conteúdo estático.
- **Casos de Teste:**
  - Renderiza o título na `AppBar`, o cabeçalho principal, o parágrafo de descrição e o texto de versão.
  - Garante que o corpo da tela é rolável (contém um `SingleChildScrollView`).

## 5. Como Executar os Testes

Para executar todos os testes e validar os resultados, utilize o seguinte comando no terminal, na raiz do projeto:

```shell
flutter test
```

## 6. Próximos Passos e Recomendações

Esta suíte de testes é uma excelente base, mas para uma cobertura "completa", os seguintes passos são recomendados:

1.  **Expandir Testes de Unidade:** Cobrir todas as outras funções de validação e formatação em `lib/utils/`.
2.  **Testar os Controllers:** A lógica de negócio mais importante está nos controllers. Para testá-los, é **altamente recomendável refatorar** o código para usar **injeção de dependência**, permitindo o uso de "mocks".
3.  **Expandir Testes de Widget:** Criar testes para os demais cards, diálogos e, principalmente, para telas com formulários (`SignInPage`, `SignUpPage`).
4.  **Implementar Testes de Integração:** Criar testes para os fluxos mais críticos do app, como **autenticação completa** e **criação de eventos/tarefas**, que simulam a jornada do usuário de ponta a ponta.
