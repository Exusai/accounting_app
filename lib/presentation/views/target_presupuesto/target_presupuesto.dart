import 'package:accounting_app/domain/model/resumen_estado_cuenta.dart';
import 'package:accounting_app/presentation/bloc/conceptos/conceptos_bloc.dart';
import 'package:accounting_app/presentation/bloc/get_estado_de_cuenta/get_estado_de_cuenta_bloc.dart';
import 'package:accounting_app/presentation/views/target_presupuesto/target_presupuesto_gages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TargetPresupuesto extends StatelessWidget {
  const TargetPresupuesto({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetEstadoDeCuentaBloc, GetEstadoDeCuentaState>(
      builder: (context, state1) {
        Map<String, double> sum = {};
        if (state1 is GetEstadoDeCuentaLoaded){
          for (ResumenEstadoCuenta x in state1.getEstadoDeCuentasResponse.estadoDecuenta){
            if (!sum.containsKey(x.nombreConcepto)){
              double sumConcepto = 0;
              for (ResumenEstadoCuenta estado in state1.getEstadoDeCuentasResponse.estadoDecuenta){
                if (estado.nombreConcepto == x.nombreConcepto){
                  sumConcepto += estado.monto;
                }
              }
              sum[x.nombreConcepto] = sumConcepto;
            }
          }
        }

        return BlocBuilder<ConceptosBloc, ConceptosState>(
          builder: (context, state) {
            if (state is ConceptosLoading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (state is ConceptosLoaded) {
              return TargetPresupuestoGages(
                getConceptsResponse: state.getConceptsResponse,
                sumaConceptos: sum,
              );
            }
            return Center(
              child: Text("Error"),
            );
          },
        );
      },
    );
  }
}
