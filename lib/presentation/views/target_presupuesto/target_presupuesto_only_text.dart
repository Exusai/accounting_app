import 'dart:math';

import 'package:accounting_app/domain/request_response/get_concepts_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TargetPresupuestoOnlyText extends StatelessWidget {
  final GetConceptsResponse getConceptsResponse;
  final Map<String, double> sumaConceptos;
  static NumberFormat moneyNumberFormat = NumberFormat('\$###,###,###,###.##', 'es_MX');
  const TargetPresupuestoOnlyText({super.key, required this.getConceptsResponse, required this.sumaConceptos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.from(getConceptsResponse.conceptos.where((x) => x.presupuesto != 0).map((x) =>
        Column(
          children: [
            Row(
              children: [
                Text("${x.nombreConcepto}: "),
                Text(moneyNumberFormat.format(x.presupuesto)),
                Text(moneyNumberFormat.format(sumaConceptos[x.nombreConcepto] ?? 0)),
                Spacer(),
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
        )
      )),
    );
  }
}