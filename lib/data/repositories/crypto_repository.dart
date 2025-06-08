import '../datasources/coinmarketcap_datasource.dart';
import '../models/crypto_model.dart';

class CryptoRepository {
  final CoinMarketCapDataSource dataSource;

  CryptoRepository(this.dataSource);

  Future<List<CryptoModel>> getCryptoData(List<String> symbols) async {
    return await dataSource.getCryptoData(symbols);
  }
}