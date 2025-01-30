import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_request.dart';
import 'package:accounting_app/presentation/bloc/conceptos/conceptos_bloc.dart';
import 'package:accounting_app/presentation/bloc/cuentas/cuentas_bloc.dart';
import 'package:accounting_app/presentation/bloc/get_estado_de_cuenta/get_estado_de_cuenta_bloc.dart';
import 'package:accounting_app/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:accounting_app/presentation/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetEstadoDeCuentaBloc()..add(
          GetEstadoDeCuentaForDate(
            getEstadoDeCuentasRequest: GetEstadoDeCuentasRequest(
              startDate: DateTime(now.year, now.month, 1),
              endDate: DateTime(now.year, now.month + 1, 1),
            )
          )
        )),

        BlocProvider(create: (context) => CuentasBloc()..add(
          GetCuentas()  
        )),

        BlocProvider(create: (context) => ConceptosBloc()..add(
          GetConceptos()
        )),

        BlocProvider(create: (context) => TransactionBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Home(),
        ),
      ),
    );
  }
}
