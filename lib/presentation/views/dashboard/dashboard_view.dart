import 'package:accounting_app/domain/model/cuenta.dart';
import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_request.dart';
import 'package:accounting_app/presentation/bloc/conceptos/conceptos_bloc.dart';
import 'package:accounting_app/presentation/bloc/cuentas/cuentas_bloc.dart';
import 'package:accounting_app/presentation/bloc/get_estado_de_cuenta/get_estado_de_cuenta_bloc.dart';
import 'package:accounting_app/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:accounting_app/presentation/widgets/budget_comparison_chart.dart';
import 'package:accounting_app/presentation/widgets/month_selector.dart';
import 'package:accounting_app/presentation/widgets/summary_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:accounting_app/presentation/views/transactions/transaction_search_delegate.dart';
import 'package:intl/intl.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DateTime _currentDate = DateTime.now();
  int _monthOffset = 0;
  int _touchedIndex = -1;

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
          title: Text(l10n.dashboard),
          actions: [
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
            MonthSelector(
              selectedDate: _getDateWithOffset(),
              onMonthChanged: _updateMonth,
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: BlocBuilder<GetEstadoDeCuentaBloc, GetEstadoDeCuentaState>(
          builder: (context, state) {
            if (state is GetEstadoDeCuentaLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetEstadoDeCuentaLoaded) {
              final transactions = List.from(state.getEstadoDeCuentasResponse.estadoDecuenta)
                ..sort((a, b) => b.fecha.compareTo(a.fecha));
              
              double income = 0;
              double expense = 0;
              Map<String, double> expensesByCategory = {};

              for (var tx in transactions) {
                if (tx.nombreConcepto.toLowerCase() == 'movimiento') {
                  continue;
                }
                if (tx.monto >= 0) {
                  income += tx.monto;
                } else {
                  expense += tx.monto;
                  expensesByCategory.update(
                    tx.nombreConcepto,
                    (value) => value + tx.monto.abs(),
                    ifAbsent: () => tx.monto.abs(),
                  );
                }
              }
              final balance = income + expense;

              return LayoutBuilder(
                builder: (context, constraints) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: BlocBuilder<ConceptosBloc, ConceptosState>(
                            builder: (context, conceptosState) {
                              return BlocBuilder<CuentasBloc, CuentasState>(
                                builder: (context, contasState) {
                                  return LayoutBuilder(
                                    builder: (context, boxConstraints) {
                                      final isWide = boxConstraints.maxWidth > 1000;

                                      Widget summaryCards = Column(
                                        children: [
                                          SummaryCard(
                                            title: l10n.income,
                                            amount: income,
                                            color: Colors.green,
                                            icon: Icons.arrow_upward,
                                          ),
                                          const SizedBox(height: 16),
                                          SummaryCard(
                                            title: l10n.expense,
                                            amount: expense.abs(),
                                            color: Colors.red,
                                            icon: Icons.arrow_downward,
                                          ),
                                          const SizedBox(height: 16),
                                          SummaryCard(
                                            title: l10n.balance,
                                            amount: balance,
                                            color: balance >= 0 ? Colors.blue : Colors.orange,
                                            icon: Icons.account_balance_wallet,
                                          ),
                                        ],
                                      );
                                      
                                      Widget chartSection = Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (expensesByCategory.isNotEmpty) ...[
                                            SizedBox(
                                              height: 400,
                                              child: PieChart(
                                                PieChartData(
                                                  pieTouchData: PieTouchData(
                                                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                                      setState(() {
                                                        if (!event.isInterestedForInteractions ||
                                                            pieTouchResponse == null ||
                                                            pieTouchResponse.touchedSection == null) {
                                                          _touchedIndex = -1;
                                                          return;
                                                        }
                                                        _touchedIndex = pieTouchResponse
                                                            .touchedSection!.touchedSectionIndex;
                                                      });
                                                    },
                                                  ),
                                                  sections: expensesByCategory.entries.toList().asMap().entries.map((entry) {
                                                      final index = entry.key;
                                                      final data = entry.value;
                                                      final isTouched = index == _touchedIndex;
                                                      final fontSize = isTouched ? 16.0 : 12.0;
                                                      final radius = isTouched ? 110.0 : 100.0;
                                                      final title = isTouched
                                                          ? "${data.key}\n${NumberFormat.currency(symbol: '\$').format(data.value)}"
                                                          : data.key;
                  
                                                      return PieChartSectionData(
                                                        value: data.value,
                                                        title: title,
                                                        titleStyle: TextStyle(
                                                          fontSize: fontSize,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                        radius: radius,
                                                        color: Colors.primaries[
                                                            data.key.hashCode % Colors.primaries.length],
                                                      );
                                                  }).toList(),
                                                  sectionsSpace: 2,
                                                  centerSpaceRadius: 40,
                                                ),
                                              ),
                                            ),
                                          ] else
                                             const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(32.0),
                                                child: Text("No expenses to show"),
                                              ),
                                            ),
                                        ],
                                      );

                                      Widget accountsSection = Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (contasState is CuentasLoaded)
                                            Column(
                                              children: (List<Cuenta>.from(contasState.getAccountsResponse.cuenta)
                                                    ..sort((a, b) => b.saldo.compareTo(a.saldo)))
                                                  .map((account) {
                                                return Card(
                                                  child: ListTile(
                                                    title: Text(account.nombreCuenta),
                                                    trailing: Text(
                                                      NumberFormat.currency(symbol: '\$').format(account.saldo),
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: account.saldo >= 0 ? Colors.green : Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            )
                                          else if (contasState is CuentasLoading)
                                            const Center(child: CircularProgressIndicator())
                                          else
                                            const Text("Error loading accounts"),
                                        ],
                                      );

                                      // Budget comparison section
                                      Widget budgetSection = const SizedBox();
                                      if (conceptosState is ConceptosLoaded) {
                                        budgetSection = BudgetComparisonChart(
                                          conceptos: conceptosState.getConceptsResponse.conceptos,
                                          actualSpending: expensesByCategory,
                                        );
                                      }

                                      if (isWide) {
                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(child: summaryCards),
                                                      const SizedBox(width: 32),
                                                      Expanded(child: chartSection),
                                                    ],
                                                  ),
                                                  budgetSection
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Flexible(flex: 2, child: accountsSection,),
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          children: [
                                            summaryCards,
                                            const SizedBox(height: 32),
                                            chartSection,
                                            const SizedBox(height: 32),
                                            accountsSection,
                                            const SizedBox(height: 32),
                                            budgetSection,
                                          ],
                                        );
                                      }
                                    }
                                  );
                                }
                              );
                            }
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Divider()
                      ),
                      if (constraints.maxWidth < 600)
                        SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final tx = transactions[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Card(
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
                                  ),
                                );
                              },
                              childCount: transactions.length,
                            ),
                          ),
                        )
                      else
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: DataTable(
                                columns: [
                                  DataColumn(label: Text(l10n.date)),
                                  DataColumn(label: Text(l10n.name)),
                                  DataColumn(label: Text(l10n.concept)),
                                  DataColumn(label: Text(l10n.amount), numeric: true),
                                  DataColumn(label: Text(l10n.account)),
                                  DataColumn(label: Flexible(child: Text(l10n.accountBalance)), numeric: true),
                                  DataColumn(label: Text(l10n.total), numeric: true),
                                  DataColumn(label: Text(l10n.totalDebt), numeric: true),
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
                                    DataCell(Text(NumberFormat.currency(symbol: '\$').format(tx.total))),
                                    DataCell(Text(NumberFormat.currency(symbol: '\$').format(tx.deudaTotal))),
                                  ]);
                                }).toList(),
                              ),
                            ),
                          ), // Removed redundant SliverPadding logic
                        ),
                    ],
                  );
                }
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
