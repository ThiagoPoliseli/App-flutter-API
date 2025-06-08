import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../viewmodels/crypto_viewmodel.dart';
import 'crypto_detail_dialog.dart';

class CryptoListScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  CryptoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CryptoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Market Cap De Thiago'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar criptomoedas (ex:BTC,ETH)',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final symbols = _searchController.text
                        .split(',')
                        .map((s) => s.trim().toUpperCase())
                        .toList();
                    viewModel.fetchCryptos(symbols: symbols.isNotEmpty ? symbols : null);
                  },
                ),
              ),
            ),
          ),
          if (viewModel.isCachedData)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Exibindo dados em cache. Conecte-se à internet para atualizar.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => viewModel.fetchCryptos(
                symbols: _searchController.text.isNotEmpty
                    ? _searchController.text.split(',').map((s) => s.trim().toUpperCase()).toList()
                    : null,
              ),
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.errorMessage != null
                      ? Center(child: Text(viewModel.errorMessage!))
                      : ListView.builder(
                          itemCount: viewModel.cryptos.length,
                          itemBuilder: (context, index) {
                            final crypto = viewModel.cryptos[index];
                            final usdFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');
                            final brlFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
                            return ListTile(
                              title: Text('${crypto.symbol} - ${crypto.name}'),
                              subtitle: Text(
                                'USD: ${usdFormat.format(crypto.priceUsd)}\n'
                                'BRL: ${brlFormat.format(crypto.priceBrl)}',
                              ),
                              onTap: () => showDialog(
                                context: context,
                                builder: (_) => CryptoDetailDialog(crypto: crypto),
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.fetchCryptos(
          symbols: _searchController.text.isNotEmpty
              ? _searchController.text.split(',').map((s) => s.trim().toUpperCase()).toList()
              : null,
        ),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}