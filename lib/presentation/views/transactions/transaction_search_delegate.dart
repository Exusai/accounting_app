import 'package:accounting_app/domain/model/resumen_estado_cuenta.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionSearchDelegate extends SearchDelegate {
  final List<ResumenEstadoCuenta> transactions;

  TransactionSearchDelegate(this.transactions);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = transactions.where((element) {
      return element.nombre.toLowerCase().contains(query.toLowerCase()) ||
          element.nombreConcepto.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final tx = results[index];
        return ListTile(
          title: Text(tx.nombre),
          subtitle: Text(tx.nombreConcepto),
          trailing: Text(
            NumberFormat.currency(symbol: '\$').format(tx.monto),
            style: TextStyle(
              color: tx.monto < 0 ? Colors.red : Colors.green,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
     final results = transactions.where((element) {
      return element.nombre.toLowerCase().contains(query.toLowerCase()) ||
          element.nombreConcepto.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final tx = results[index];
        return ListTile(
          onTap: () {
            close(context, null); // Or navigate to details
          },
          title: Text(tx.nombre),
          subtitle: Text(tx.nombreConcepto),
          trailing: Text(
            NumberFormat.currency(symbol: '\$').format(tx.monto),
            style: TextStyle(
              color: tx.monto < 0 ? Colors.red : Colors.green,
            ),
          ),
        );
      },
    );
  }
}
