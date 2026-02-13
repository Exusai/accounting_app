import 'package:accounting_app/domain/model/transaccion.dart';
import 'package:accounting_app/presentation/bloc/get_estado_de_cuenta/get_estado_de_cuenta_bloc.dart';
import 'package:accounting_app/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:accounting_app/presentation/views/insert_data/accounts_dropdown.dart';
import 'package:accounting_app/presentation/views/insert_data/concepts_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:accounting_app/l10n/app_localizations.dart';

class InsertDataDialog extends StatefulWidget {
  const InsertDataDialog({super.key});

  @override
  State<InsertDataDialog> createState() => _InsertDataDialogState();
}

class _InsertDataDialogState extends State<InsertDataDialog> {
  final _formKey = GlobalKey<FormState>();
  String? idCuenta;
  String? idConcepto;
  String? descripcion;
  double? monto;
  String? name;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.addTransaction),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.name,
                  prefixIcon: const Icon(Icons.label),
                ),
                validator: (value) => value == null || value.isEmpty ? l10n.requiredField : null,
                onSaved: (value) => name = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.amount,
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,-]')),
                ],
                validator: (value) => value == null || value.isEmpty ? l10n.requiredField : null,
                onSaved: (value) => monto = double.tryParse(value ?? "0"),
              ),
              const SizedBox(height: 16),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: l10n.date,
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: Text(DateFormat.yMMMd().format(_selectedDate)),
                ),
              ),
              const SizedBox(height: 16),
              AccountsDropdown(
                onSelected: (p0) {
                  setState(() {
                    idCuenta = p0?.idCuenta;
                  });
                },
              ),
              const SizedBox(height: 16),
              ConceptsDropdown(
                onSelected: (p0) {
                  setState(() {
                    idConcepto = p0?.idConcepto;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.description,
                  prefixIcon: const Icon(Icons.description),
                ),
                onSaved: (value) => descripcion = value,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(l10n.save),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && idCuenta != null && idConcepto != null) {
      _formKey.currentState!.save();
      final now = DateTime.now();
      final transactionDate = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        now.hour,
        now.minute,
        now.second,
      );

      BlocProvider.of<TransactionBloc>(context).add(
        NewTransaction(
          transaccion: Transaccion(
            descripcion: descripcion,
            fecha: transactionDate,
            idConcepto: idConcepto!,
            idCuenta: idCuenta!,
            idTransaccion: null,
            monto: monto!,
            nombre: name!,
          ),
        ),
      );
      Navigator.of(context).pop();
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.requiredField))
        );
    }
  }
}
