# MyWallet

## Introdução

Este é um aplicativo desenvolvido com Flutter e Dart como parte dos estudos da disciplina Desenvolvimento Multiplataforma 3 do curso de Especialização em Desenvolvimento de Sistemas para Dispositivos Móveis do IFSP - Câmpus São Carlos.

O objetivo deste projeto é desenvolver um aplicativo multiplataforma para o gerenciamento de transações financeiras, explorando listas, navegação entre telas e armazenamento local com SQLite. A aplicação permite cadastrar, consultar, editar e excluir informações de forma persistente no dispositivo.

## Sobre o aplicativo

O MyWallet permite registrar entradas e despesas informando título, descrição, valor e tipo da transação. Os registros são apresentados em uma lista com data, valor e identificação visual: entradas aparecem em verde e despesas em vermelho.

O saldo total é calculado automaticamente a partir das transações cadastradas e sua cor indica a situação financeira atual. Ao selecionar uma transação, é possível consultar seus dados, editar as informações ou excluí-la após uma confirmação.

Os dados são armazenados localmente em um banco SQLite e permanecem disponíveis mesmo após o encerramento do aplicativo.

## Funcionalidades

- Cadastro de entradas e despesas;
- Listagem das transações financeiras;
- Exibição de título, descrição, data, tipo e valor;
- Cálculo automático do saldo total;
- Identificação visual de entradas, despesas e saldo;
- Consulta e edição de transações;
- Confirmação antes da exclusão;
- Persistência local dos dados com SQLite.

## Tecnologias utilizadas

- Flutter
- Dart
- SQLite

## Bibliotecas utilizadas

- `sqflite`
- `path_provider`
- `intl`
- `currency_text_input_formatter`

## Como executar

Certifique-se de que o Flutter esteja instalado e configurado. Em seguida, instale as dependências do projeto:

```bash
flutter pub get
```

Conecte um dispositivo ou inicie um emulador e execute o aplicativo:

```bash
flutter run
```

Para gerar um APK de depuração para Android:

```bash
flutter build apk --debug
```

## Screenshots

### Cadastro de transações

<p>
  <img src="screenshots/01-tela-inicial-sem-transacoes.png" alt="Tela inicial sem transações" width="220">
  <img src="screenshots/02-formulario-nova-transacao.png" alt="Formulário para cadastrar uma nova transação" width="220">
  <img src="screenshots/03-cadastro-de-despesa.png" alt="Cadastro preenchido de uma despesa" width="220">
</p>

### Lista e saldo

<p>
  <img src="screenshots/04-lista-com-saldo-negativo.png" alt="Lista de transações com saldo negativo" width="220">
  <img src="screenshots/05-lista-com-saldo-positivo.png" alt="Lista de transações com saldo positivo" width="220">
  <img src="screenshots/06-lista-com-receita-adicional.png" alt="Lista de transações após o cadastro de uma receita adicional" width="220">
</p>

### Detalhes, edição e exclusão

<p>
  <img src="screenshots/07-detalhes-da-transacao.png" alt="Detalhes de uma transação cadastrada" width="220">
  <img src="screenshots/08-edicao-da-transacao.png" alt="Edição do valor de uma transação" width="220">
  <img src="screenshots/09-confirmacao-de-exclusao.png" alt="Confirmação para excluir uma transação" width="220">
  <img src="screenshots/10-lista-apos-edicao-e-exclusao.png" alt="Lista de transações após a edição e exclusão" width="220">
</p>

### Armazenamento local

<p>
  <img src="screenshots/11-database-inspector-sqlite.png" alt="Tabela de transações SQLite no Database Inspector do Android Studio" width="900">
</p>
