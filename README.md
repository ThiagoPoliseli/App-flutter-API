App-Coin-Market-Cap
Uma aplicação Flutter que consome a API do CoinMarketCap para listar criptomoedas com base em critérios definidos, seguindo o padrão arquitetural MVVM.
Visão Geral
Este aplicativo exibe uma lista de criptomoedas com seus símbolos, nomes e preços atuais em USD e BRL. Inclui uma funcionalidade de busca, opções de atualização e visualização detalhada para criptomoedas selecionadas. 

Pré-requisitos

Flutter SDK (versão 3.16.0 ou superior recomendada)
Visual Studio Code com as extensões Flutter e Dart
Android Studio (para emulador Android)

Instalação
1. Clone o Repositório
git clone [https://github.com/ThiagoPolisel/App-flutter-API](https://github.com/ThiagoPoliseli/App-flutter-API)
cd App-flutter-API

2. Instale as Dependências
Execute o seguinte comando para instalar os pacotes necessários:
flutter pub get

3. Execute a Aplicação

Certifique-se de que o emulador está em execução.
No terminal do VS Code, execute:



flutter clean

flutter pub get

flutter run


Alternativamente, pressione F5 no VS Code para iniciar a depuração.
Selecione o emulador se solicitado.

4. Resolva Problemas Comuns

Erro 401 Não Autorizado ("Chave API ausente"):
Esse erro indica uma chave API inválida ou ausente.
Verifique se a chave API em constants.dart corresponde à do CoinMarketCap.

Se falhar, gere uma nova chave no CoinMarketCap e atualize o constants.dart.


Emulador Não Detectado:
Execute flutter doctor para diagnosticar problemas.
Certifique-se de que o Android Studio está configurado corretamente.


Problemas de Desempenho:
Use um emulador leve (ex.: Pixel 4) e aumente a RAM do AVD se necessário.

Problemas de Rede:
Certifique-se de que o emulador tem acesso à internet (Android: verifique Wi-Fi; iOS: verifique a conexão do host).

5. Uso

Lista Padrão: O app carrega uma lista predefinida de criptomoedas (BTC, ETH, SOL, etc.) ao iniciar.
Busca: Insira símbolos separados por vírgula (ex.: BTC,ETH) no campo de busca e pressione o ícone de busca.
Atualizar: Use o botão de atualização ou puxe para atualizar os dados.
Detalhes: Toque em uma criptomoeda para ver um diálogo com Nome, Símbolo, Data de Adição e preços em USD/BRL.


Funcionalidades

Arquitetura MVVM: Separa UI, ViewModel, Repositório e DataSource.
Localização: Datas exibidas de postagem
Preços Formatados: USD ($) e BRL (R$) 

Contribuição
Licença
Este projeto está licenciado sob a Licença MIT - veja o arquivo LICENSE para detalhes.
Agradecimentos

Construído com Flutter.
Dados da API fornecidos por CoinMarketCap.

