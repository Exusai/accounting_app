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
        Row(
          children: [
            Text(x.nombreConcepto),
            Text(moneyNumberFormat.format(x.presupuesto)),
            Text(moneyNumberFormat.format(sumaConceptos[x.nombreConcepto])),
            Spacer(),
            Text(moneyNumberFormat.format(x.presupuesto + (sumaConceptos[x.nombreConcepto] ?? 0)))
          ],
        )
      )),
    );
  }
}