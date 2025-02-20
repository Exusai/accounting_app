import 'dart:math';

import 'package:accounting_app/domain/model/concepto.dart';
import 'package:accounting_app/domain/request_response/get_concepts_response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TargetPresupuestoGages extends StatelessWidget {
  final GetConceptsResponse getConceptsResponse;
  final Map<String, double> sumaConceptos;
  static NumberFormat moneyNumberFormat = NumberFormat('\$###,###,###,###.##', 'es_MX');
  const TargetPresupuestoGages({super.key, required this.getConceptsResponse, required this.sumaConceptos});

  @override
  Widget build(BuildContext context) {
    Concepto ingresos = getConceptsResponse.conceptos.firstWhere((element) => element.idConcepto == "1f1120e7-20ce-4e3d-8d7e-1cd656c45a2a",);
    double egresos = 0;
    sumaConceptos.forEach((key, value) {
      if(key != "Ingreso" && key != "Movimiento"){
        egresos += value;
      }
    },);
    return Column(
      children: [
        Text(
          "Ingreso mensual estimado: ${moneyNumberFormat.format(ingresos.presupuesto)}"
        ),
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.green,
                  title: "",
                  value: (ingresos.presupuesto + egresos) > 0 ? (ingresos.presupuesto + egresos) : 0,
                  badgeWidget: Text(moneyNumberFormat.format(ingresos.presupuesto + egresos))
                ),
                PieChartSectionData(
                  color: Colors.red,
                  title: "",
                  value: egresos.abs(),
                  badgeWidget: Text(moneyNumberFormat.format(egresos)),
                  badgePositionPercentageOffset: 0
                ),

              ]
            )
          ),
        ),
        // TODO: agregar gastos principales del mes
        Divider(),
        ...getGages(),
      ],
    );
  }

  List<Widget> getGages() {
    return List<Widget>.from(getConceptsResponse.conceptos.where((x) => x.presupuesto != 0 && x.nombreConcepto != "Ingreso").map((x) =>
      Container(
        decoration: x.nombreConcepto == "PPR" || x.nombreConcepto.contains("Ahorro") ? BoxDecoration(
          border:  Border.all(
            color: Colors.blue.withValues(alpha: .6),
            width: 3
          )
        ) : null,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${x.nombreConcepto}: ",
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  )
                ),
                Text(moneyNumberFormat.format(x.presupuesto)),
                Text(moneyNumberFormat.format(sumaConceptos[x.nombreConcepto] ?? 0)),
                Text(": "),
                Text(moneyNumberFormat.format(x.presupuesto + (sumaConceptos[x.nombreConcepto] ?? 0)))
              ],
            ),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 20,
              ),
              child: Slider(
                value: min(sumaConceptos[x.nombreConcepto]?.abs() ?? 0, x.presupuesto),
                max: max(x.presupuesto, sumaConceptos[x.nombreConcepto]?.abs() ?? 0),
                onChanged: (v){},
                inactiveColor: x.presupuesto + (sumaConceptos[x.nombreConcepto] ?? 0) < 0 
                  ? const Color.fromARGB(255, 141, 26, 26) : Colors.grey,
                activeColor: x.presupuesto + (sumaConceptos[x.nombreConcepto] ?? 0) < 0 
                  ? Colors.red : Colors.green,
                thumbColor: x.presupuesto + (sumaConceptos[x.nombreConcepto] ?? 0) < 0 
                  ? Colors.red : Colors.green,
                allowedInteraction: SliderInteraction.tapOnly,                
              ),
            ),
          ],
        ),
      )
    ));
  }
}