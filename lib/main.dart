import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/coinmarketcap_datasource.dart';
import 'data/repositories/crypto_repository.dart';
import 'presentation/viewmodels/crypto_viewmodel.dart';
import 'presentation/views/crypto_list_screen.dart';
import 'utils/network_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => CoinMarketCapDataSource()),
        Provider(create: (context) => CryptoRepository(context.read<CoinMarketCapDataSource>())),
        Provider(create: (_) => NetworkChecker()),
        ChangeNotifierProvider(
          create: (context) => CryptoViewModel(
            context.read<CryptoRepository>(),
            context.read<NetworkChecker>(),
          )..fetchCryptos(),
        ),
      ],
      child: MaterialApp(
        title: 'Crypto Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CryptoListScreen(),
      ),
    );
  }
}