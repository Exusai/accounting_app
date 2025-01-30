import 'package:accounting_app/domain/model/concepto.dart';
import 'package:accounting_app/presentation/bloc/conceptos/conceptos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConceptsDropdown extends StatefulWidget {
  final void Function(Concepto?)? onSelected;
  const ConceptsDropdown({super.key, this.onSelected});

  @override
  State<ConceptsDropdown> createState() => _ConceptsDropdownState();
}

class _ConceptsDropdownState extends State<ConceptsDropdown> {
  Concepto? selectedConcepto;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConceptosBloc, ConceptosState>(
      builder: (context, state) {
        if (state is ConceptosLoading){
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is ConceptosLoaded){
          return DropdownButton<Concepto>(
            hint: Text("Select concepto"),
            value: selectedConcepto,
            items: List.from(
              state.getConceptsResponse.conceptos.map((x) => DropdownMenuItem(value: x, child: Text(x.nombreConcepto)),)
            ),
            onChanged: (Concepto? cons) {
              setState(() {
                selectedConcepto = cons;
              });
              widget.onSelected?.call(cons);
            },
          );
        }
        return Center(child: Text("Error"),);
        
      },
    );
  }
}
