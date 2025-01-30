import 'package:accounting_app/presentation/bloc/cuentas/cuentas_bloc.dart';
import 'package:accounting_app/presentation/views/accounts_overview/accounts_overview_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountsOverview extends StatelessWidget {
  const AccountsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Cuentas"),
        Divider(),
        BlocBuilder<CuentasBloc, CuentasState>(
          builder: (context, state) {
            if (state is CuentasLoading){
              return Center(child: CircularProgressIndicator.adaptive(),);
            }
        
            if(state is CuentasLoaded){
              return AccountsOverviewLoaded(
                getAccountsResponse: state.getAccountsResponse,
              );
            }
        
            return Center(child: Text("Error"),);
          },
        ),
      ],
    );
  }
}
