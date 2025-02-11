import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SheetLoaded extends StatelessWidget {
  final GetEstadoDeCuentasResponse getEstadoDeCuentasResponse;
  static NumberFormat moneyNumberFormat = NumberFormat('\$###,###,###,###.##', 'es_MX');
  static DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  const SheetLoaded({super.key, required this.getEstadoDeCuentasResponse});

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = List<DataRow>.from(
      getEstadoDeCuentasResponse.estadoDecuenta.map(((x) => DataRow(
        cells: [
          DataCell(
            Text(dateFormat.format(x.fecha))
          ),
          DataCell(
            Text(x.nombre)
          ),
          DataCell(
            Text(x.nombreConcepto)
          ),
          DataCell(
            Text(moneyNumberFormat.format(x.monto))
          ),
          DataCell(
            Text(x.nombreCuenta)
          ),
          DataCell(
            Text(moneyNumberFormat.format(x.saldoCuentaTransaccion))
          ),
          DataCell(
            Text(moneyNumberFormat.format(x.total))
          ),
          DataCell(
            Text(moneyNumberFormat.format(x.deudaTotal))
          ),
        ]
      )))
    );
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text("Fecha")),
          DataColumn(label: Text("Nombre")),
          DataColumn(label: Text("Concepto")),
          DataColumn(label: Text("Monto"), numeric: true),
          DataColumn(label: Text("Cuenta")),
          DataColumn(label: Flexible(child: Text("Saldo cuenta")), numeric: false),
          DataColumn(label: Text("Total"), numeric: true),
          DataColumn(label: Text("Deuda total"), numeric: true),
        ],
        rows: rows,
      ),
    );
  }
}