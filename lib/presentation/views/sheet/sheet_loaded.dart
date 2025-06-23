import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_response.dart';
import 'package:accounting_app/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SheetLoaded extends StatefulWidget {
  final GetEstadoDeCuentasResponse getEstadoDeCuentasResponse;
  static NumberFormat moneyNumberFormat = NumberFormat('\$###,###,###,###.##', 'es_MX');
  static DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  const SheetLoaded({super.key, required this.getEstadoDeCuentasResponse});

  @override
  State<SheetLoaded> createState() => _SheetLoadedState();
}

class _SheetLoadedState extends State<SheetLoaded> {
  late GetEstadoDeCuentasResponse edoCta;
  int sortColumnIndex = 0;
  bool sortAscending = false;
  @override
  void initState() {
    edoCta = widget.getEstadoDeCuentasResponse;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = List<DataRow>.from(
      edoCta.estadoDecuenta.where((a) => a.visible).map(((x) => DataRow(
        onLongPress: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Eliminar"),
                content: Text("Deseas borrar el último movimiento?"),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: Text("Cancelar")
                  ),
                  TextButton(
                    onPressed: (){
                      BlocProvider.of<TransactionBloc>(context).add(
                        DeleteLastTransaction()
                      );
                      Navigator.of(context).pop();
                    }, 
                    child: Text("Si")
                  ),
                ],
              );

            },
          );

        },
        cells: [
          DataCell(
            Text(SheetLoaded.dateFormat.format(x.fecha))
          ),
          DataCell(
            Text(x.nombre)
          ),
          DataCell(
            Text(x.nombreConcepto)
          ),
          DataCell(
            Text(SheetLoaded.moneyNumberFormat.format(x.monto))
          ),
          DataCell(
            Text(x.nombreCuenta)
          ),
          DataCell(
            Text(SheetLoaded.moneyNumberFormat.format(x.saldoCuentaTransaccion))
          ),
          DataCell(
            Text(SheetLoaded.moneyNumberFormat.format(x.total))
          ),
          DataCell(
            Text(SheetLoaded.moneyNumberFormat.format(x.deudaTotal)),
          ),
        ]
      )))
    );
    return SingleChildScrollView(
      child: DataTable(
        sortColumnIndex: sortColumnIndex,
        sortAscending: sortAscending,
        columns: [
          DataColumn(
            label: Text("Fecha"), 
            onSort: (columnIndex, ascending) {
              setState(() {
                sortColumnIndex = columnIndex;
                sortAscending = ascending;
                edoCta.sortByDate(ascending);
              });
            },
          ),
          DataColumn(label: Text("Nombre")),
          DataColumn(label: Text("Concepto")),
          DataColumn(
            label: Text("Monto"), 
            numeric: true,
            onSort: (columnIndex, ascending) {
              setState(() {
                sortColumnIndex = columnIndex;
                sortAscending = ascending;
                edoCta.sortByAmount(ascending);
              });
            },
          ),
          DataColumn(label: Text("Cuenta")),
          DataColumn(label: Flexible(child: Text("Saldo cuenta")), numeric: false),
          DataColumn(label: Text("Total"), numeric: true),
          DataColumn(label: Text("Deuda total"), numeric: true),
        ],
        rows: rows,
        dataRowMinHeight: 15,
        dataRowMaxHeight: 20,
      ),
    );
  }
}