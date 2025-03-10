# Desafio Técnico - Sistema de Busca de Passagens Aéreas

Este é um sistema de busca de passagens aéreas que permite aos usuários selecionar aeroportos de
origem e destino,
definir as datas de ida e volta, escolher a companhia aérea e o tipo de passagem. O sistema faz uma
solicitação para
criar uma passagem e redireciona o usuário para a tela de seleção de voos.

## Tecnologias Utilizadas

- **Flutter**: Framework para construção de interfaces nativas.
- **GetX**: Gerenciamento de estado e dependências.
- **Intl**: Manipulação de formatos de data.
- **Flutter Material**: Biblioteca de componentes para interface do usuário.
- **Dart**: Linguagem de programação utilizada.

## Funcionalidades

- **Seleção de Aeroporto**: O usuário pode escolher aeroportos de origem e destino.
- **Seleção de Data**: O usuário pode selecionar a data de ida e volta.
- **Seleção de Companhias Aéreas**: O usuário pode escolher a(s) companhia(s) aérea(s).
- **Tipo de Passagem**: O usuário pode selecionar o tipo de passagem (ida e volta ou só ida).
- **Validação de Formulário**: O sistema valida se todos os campos foram preenchidos corretamente
  antes de realizar a
  solicitação de criação do ticket.

## Como Rodar o Projeto

### Pré-requisitos

- **Flutter**: Certifique-se de que o [Flutter](https://flutter.dev/docs/get-started/install) esteja
  instalado em seu
  sistema.
- **Dart**: O Dart é instalado automaticamente com o Flutter, mas verifique se está configurado
  corretamente.
- **Api**: Executar está [api](https://github.com/gralmeidan/busca-mock-api) localmente, seguindo as
  instruções
  disponíveis no repositório.

### Passos para Execução

1. **Clone o repositório**:

   ```bash
   git clone https://github.com/pedro-henrique1/passagem-express.git
   cd passagem-express
    ```
2. Instale as dependência:

   ```bash
    flutter pub get
   ```
3. Configuração do .env
   ```bash
    cp .env.example .env
   ```
   ```
   BUSCA_MILHAS_URL=htt://{url onde a api externa vai roda}
   ```

4. Executar o programa:
   ```bash
    make run-web
   ```

5. Mais comando:
    ```bash
    make help     
    ```