import 'package:accounting_app/domain/model/cuenta.dart';
import 'package:accounting_app/presentation/bloc/cuentas/cuentas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountsDropdown extends StatefulWidget {
  const AccountsDropdown({super.key});

  @override
  State<AccountsDropdown> createState() => _AccountsDropdownState();
}

class _AccountsDropdownState extends State<AccountsDropdown> {
  Cuenta? selectedCuenta;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CuentasBloc, CuentasState>(
      builder: (context, state) {
        if (state is CuentasLoading){
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is CuentasLoaded){
          return DropdownButton<Cuenta>(
            hint: Text("Select cuenta"),
            value: selectedCuenta,
            items: List.from(
              state.getAccountsResponse.cuenta.map((x) => DropdownMenuItem(value: x, child: Text(x.nombreCuenta)),)
            ),
            onChanged: (Cuenta? cta) {
              setState(() {
                selectedCuenta = cta;
              });
            },
          );
        }
        return Center(child: Text("Error"),);
        
      },
    );
  }
}
