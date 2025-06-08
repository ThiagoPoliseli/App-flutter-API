import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/crypto_model.dart';

class CryptoDetailDialog extends StatelessWidget {
  final CryptoModel crypto;

  const CryptoDetailDialog({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    final usdFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    final brlFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final dateFormat = DateFormat.yMMMMd('en_US');

    return AlertDialog(
      title: Text('${crypto.symbol} - ${crypto.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nome: ${crypto.name}'),
          Text('Símbolo: ${crypto.symbol}'),
          Text('Data adicionada: ${dateFormat.format(DateTime.parse(crypto.dateAdded))}'),
          Text('Preço USD: ${usdFormat.format(crypto.priceUsd)}'),
          Text('Preço BRL: ${brlFormat.format(crypto.priceBrl)}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}