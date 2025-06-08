import 'package:flutter/foundation.dart';
import '../../data/models/crypto_model.dart';
import '../../data/repositories/crypto_repository.dart';
import '../../utils/constants.dart';
import '../../utils/network_checker.dart';

class CryptoViewModel extends ChangeNotifier {
  final CryptoRepository repository;
  final NetworkChecker networkChecker;

  List<CryptoModel> cryptos = [];
  bool isLoading = false;
  String? errorMessage;
  bool isCachedData = false;

  CryptoViewModel(this.repository, this.networkChecker);

  Future<void> fetchCryptos({List<String>? symbols}) async {
    isLoading = true;
    errorMessage = null;
    isCachedData = false;
    notifyListeners();

    try {
      final isConnected = await networkChecker.isConnected();
      if (!isConnected) {
        errorMessage = 'Sem conexão com a internet. Exibindo dados em cache, se disponíveis.';
        final cachedCryptos = await repository.getCryptoData(symbols ?? Constants.defaultCryptos);
        if (cachedCryptos.isNotEmpty) {
          cryptos = cachedCryptos;
          isCachedData = true;
        } else {
          errorMessage = 'Não há internet nem dados em cache disponíveis.';
        }
      } else {
        cryptos = await repository.getCryptoData(symbols ?? Constants.defaultCryptos);
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}