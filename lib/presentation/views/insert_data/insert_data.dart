import 'package:accounting_app/domain/model/transaccion.dart';
import 'package:accounting_app/presentation/bloc/get_estado_de_cuenta/get_estado_de_cuenta_bloc.dart';
import 'package:accounting_app/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:accounting_app/presentation/views/insert_data/accounts_dropdown.dart';
import 'package:accounting_app/presentation/views/insert_data/concepts_dropdown.dart';
import 'package:accounting_app/presentation/views/insert_data/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InsertData extends StatefulWidget {
  final String? restorationId;

  const InsertData({super.key, this.restorationId});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> with RestorationMixin {
  String? idCuenta;
  String? idConcepto;
  String? descripcion;
  double? monto;
  String? name;

  @override
  String? get restorationId => widget.restorationId;
  
  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture = RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: (BlocProvider.of<GetEstadoDeCuentaBloc>(context).state is GetEstadoDeCuentaLoaded)
            ? (BlocProvider.of<GetEstadoDeCuentaBloc>(context).state as GetEstadoDeCuentaLoaded).getEstadoDeCuentasResponse.estadoDecuenta.last.fecha
            : DateTime(DateTime.now().year-1),
          lastDate: DateTime(DateTime.now().year+1),
        );
      },
    );
  }  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).highlightColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: (){
              _restorableDatePickerRouteFuture.present();
            }, 
            child: Text(DateFormat('dd/MM/yyyy').format(_selectedDate.value))
          ),
          Flexible(
            child: CustomTextField(
              hint: "Nombre",
              onChanged: (p0) {
                setState(() {
                  name = p0;
                });
              },
            ),
          ),
          Flexible(
            child: CustomTextField(
              hint: "Monto",
              textInputType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.,-]')),
              ],
              onChanged: (p0) {
                setState(() {
                  monto = double.tryParse(p0 ?? "nan");
                });
              },
            ),
          ),
          Flexible(
            child: AccountsDropdown(
              onSelected: (p0) {
                setState(() {
                  idCuenta = p0?.idCuenta;
                });
              },
            )
          ),
          Flexible(
            child: ConceptsDropdown(
              onSelected: (p0) {
                setState(() {
                  idConcepto = p0?.idConcepto;
                });
              },
            ),
          ),
          Flexible(
            child: CustomTextField(
              hint: "Descripción",
              onChanged: (p0) {
                setState(() {
                  descripcion = p0;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: !isValid() ? null : (){
              DateTime now = DateTime.now();
              BlocProvider.of<TransactionBloc>(context).add(
                NewTransaction(
                  transaccion: Transaccion(
                    descripcion: descripcion, 
                    fecha: DateTime(
                      _selectedDate.value.year,
                      _selectedDate.value.month,
                      _selectedDate.value.day,
                      now.hour,
                      now.minute,
                      now.second,
                    ), 
                    idConcepto: idConcepto!, 
                    idCuenta: idCuenta!, 
                    idTransaccion: null, 
                    monto: monto!, 
                    nombre: name!,
                  )
                )
              );
            }, 
            child: Text("Agregar movimiento")
          ),
        ],
      ),
    );
  }

  bool isValid(){
    return name != null && monto != null
      && idConcepto != null && idCuenta != null;
  }
}