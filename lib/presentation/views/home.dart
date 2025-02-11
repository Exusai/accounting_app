import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_request.dart';
import 'package:accounting_app/presentation/bloc/conceptos/conceptos_bloc.dart';
import 'package:accounting_app/presentation/bloc/cuentas/cuentas_bloc.dart';
import 'package:accounting_app/presentation/bloc/get_estado_de_cuenta/get_estado_de_cuenta_bloc.dart';
import 'package:accounting_app/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:accounting_app/presentation/views/accounts_overview/accounts_overview.dart';
import 'package:accounting_app/presentation/views/insert_data/insert_data.dart';
import 'package:accounting_app/presentation/views/sheet/sheet.dart';
import 'package:accounting_app/presentation/views/target_presupuesto/target_presupuesto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionLoaded){
          DateTime now = DateTime.now();
          BlocProvider.of<GetEstadoDeCuentaBloc>(context).add(
            GetEstadoDeCuentaForDate(
              getEstadoDeCuentasRequest: GetEstadoDeCuentasRequest(
                startDate: DateTime(now.year, now.month, 1),
                endDate: DateTime(now.year, now.month + 1, 1),
              )
            )
          );
          BlocProvider.of<CuentasBloc>(context).getAccounts();
          BlocProvider.of<ConceptosBloc>(context).getConcepts();
        }
      },
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              children: [Expanded(child: const Sheet()), InsertData()],
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountsOverview(),
                    Divider(),
                    TargetPresupuesto()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
