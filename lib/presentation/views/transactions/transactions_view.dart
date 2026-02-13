import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_request.dart';
import 'package:accounting_app/presentation/bloc/get_estado_de_cuenta/get_estado_de_cuenta_bloc.dart';
import 'package:accounting_app/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:accounting_app/presentation/views/transactions/transaction_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:accounting_app/l10n/app_localizations.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key});

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  final DateTime _currentDate = DateTime.now();
  int _monthOffset = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionLoaded) {
          _refreshData();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.transactions),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => _updateMonth(-1),
            ),
            Center(
              child: Text(
                DateFormat.yMMMM(Localizations.localeOf(context).toString())
                    .format(_getDateWithOffset()),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                 final state = BlocProvider.of<GetEstadoDeCuentaBloc>(context).state;
                 if (state is GetEstadoDeCuentaLoaded) {
                   showSearch(
                     context: context,
                     delegate: TransactionSearchDelegate(state.getEstadoDeCuentasResponse.estadoDecuenta),
                   );
                 }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => _updateMonth(1),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: BlocBuilder<GetEstadoDeCuentaBloc, GetEstadoDeCuentaState>(
          builder: (context, state) {
            if (state is GetEstadoDeCuentaLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetEstadoDeCuentaLoaded) {
              final transactions = state.getEstadoDeCuentasResponse.estadoDecuenta;
              if (transactions.isEmpty) {
                return const Center(child: Text("No transactions"));
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: transactions.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final tx = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: tx.monto < 0
                                  ? Theme.of(context).colorScheme.errorContainer
                                  : Theme.of(context).colorScheme.primaryContainer,
                              child: Icon(
                                tx.monto < 0 ? Icons.arrow_downward : Icons.arrow_upward,
                                color: tx.monto < 0
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            title: Text(tx.nombre),
                            subtitle: Text((tx.nombreConcepto)),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  NumberFormat.currency(symbol: '\$').format(tx.monto),
                                  style: TextStyle(
                                    color: tx.monto < 0
                                        ? Theme.of(context).colorScheme.error
                                        : Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM').format(tx.fecha),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text(l10n.date)),
                            DataColumn(label: Text(l10n.name)),
                            DataColumn(label: Text(l10n.category)),
                            DataColumn(label: Text(l10n.amount), numeric: true),
                            DataColumn(label: Text(l10n.account)),
                            DataColumn(label: Text(l10n.balance), numeric: true),
                          ],
                          rows: transactions.map((tx) {
                            return DataRow(cells: [
                              DataCell(Text(DateFormat('dd/MM/yyyy').format(tx.fecha))),
                              DataCell(Text(tx.nombre)),
                              DataCell(Text(tx.nombreConcepto)),
                              DataCell(
                                Text(
                                  NumberFormat.currency(symbol: '\$').format(tx.monto),
                                  style: TextStyle(
                                    color: tx.monto < 0
                                        ? Theme.of(context).colorScheme.error
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              DataCell(Text(tx.nombreCuenta)),
                              DataCell(Text(NumberFormat.currency(symbol: '\$').format(tx.saldoCuentaTransaccion))),
                            ]);
                          }).toList(),
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return const Center(child: Text("Error loading data"));
            }
          },
        ),
      ),
    );
  }

  void _updateMonth(int offset) {
    setState(() {
      _monthOffset += offset;
    });
    _refreshData();
  }

  DateTime _getDateWithOffset() {
    return DateTime(_currentDate.year, _currentDate.month + _monthOffset, 1);
  }

  void _refreshData() {
    final targetDate = _getDateWithOffset();
    BlocProvider.of<GetEstadoDeCuentaBloc>(context).add(
      GetEstadoDeCuentaForDate(
        getEstadoDeCuentasRequest: GetEstadoDeCuentasRequest(
          startDate: targetDate,
          endDate: DateTime(targetDate.year, targetDate.month + 1, 1),
        ),
      ),
    );
  }
}
