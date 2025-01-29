import 'package:accounting_app/presentation/bloc/get_estado_de_cuenta/get_estado_de_cuenta_bloc.dart';
import 'package:accounting_app/presentation/views/sheet/sheet_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Sheet extends StatelessWidget {
  const Sheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetEstadoDeCuentaBloc, GetEstadoDeCuentaState>(
      builder: (context, state) {
        if (state is GetEstadoDeCuentaLoading){
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is GetEstadoDeCuentaLoaded){
          return SheetLoaded(getEstadoDeCuentasResponse: state.getEstadoDeCuentasResponse);
        }
        return Center(
          child: Text("Error")
        );
      },
    );
  }
}
