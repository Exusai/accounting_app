import 'package:json_annotation/json_annotation.dart';

part 'concepto.g.dart';

@JsonSerializable()
class Concepto {
  Concepto({
    required this.idConcepto,
    required this.nombreConcepto,
    required this.presupuesto
  });

  final String idConcepto;
  final String nombreConcepto;
  final double presupuesto;

  factory Concepto.fromJson(Map<String, dynamic> json) => _$ConceptoFromJson(json);

  Map<String, dynamic> toJson() => _$ConceptoToJson(this);
}