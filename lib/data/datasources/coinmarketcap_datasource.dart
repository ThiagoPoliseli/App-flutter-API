import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/crypto_model.dart';
import '../../utils/constants.dart';

class CoinMarketCapDataSource {
  Future<List<CryptoModel>> getCryptoData(List<String> symbols) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'crypto_data_${symbols.join(',')}';
    final cachedData = prefs.getString(cacheKey);

    if (cachedData != null) {
      final List<dynamic> jsonList = jsonDecode(cachedData);
      return jsonList.map((json) => CryptoModel.fromCache(json)).toList();
    }

    final url = Uri.parse('${Constants.baseUrl}${Constants.endpoint}?symbol=${symbols.join(',')}');
    final response = await http.get(
      url,
      headers: {'X-CMC_PRO_API_KEY': Constants.apiKey},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      final cryptos = data.entries
          .map((entry) => CryptoModel.fromJson(entry.key, entry.value))
          .toList();
      await prefs.setString(cacheKey, jsonEncode(cryptos.map((c) => c.toJson()).toList()));
      return cryptos;
    } else {
      throw Exception('Falha ao carregar dados criptográficos: ${response.statusCode} - ${response.body}');
    }
  }
}