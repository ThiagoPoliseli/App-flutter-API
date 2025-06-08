class CryptoModel {
  final String id;
  final String name;
  final String symbol;
  final double priceUsd;
  final double priceBrl;
  final String dateAdded;

  CryptoModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.priceUsd,
    required this.priceBrl,
    required this.dateAdded,
  });

  factory CryptoModel.fromJson(String id, Map<String, dynamic> json) {
    final quote = json['quote']['USD'];
    const double usdToBrl = 5.3;
    return CryptoModel(
      id: id,
      name: json['name'],
      symbol: json['symbol'],
      priceUsd: quote['price'],
      priceBrl: quote['price'] * usdToBrl,
      dateAdded: json['date_added'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'symbol': symbol,
        'priceUsd': priceUsd,
        'priceBrl': priceBrl,
        'dateAdded': dateAdded,
      };

  factory CryptoModel.fromCache(Map<String, dynamic> json) => CryptoModel(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        priceUsd: json['priceUsd'],
        priceBrl: json['priceBrl'],
        dateAdded: json['dateAdded'],
      );
}