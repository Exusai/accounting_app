import 'package:json_annotation/json_annotation.dart';

part 'concepto.g.dart';

@JsonSerializable()
class Concepto {
  Concepto({
    required this.idConcepto,
    required this.nombreConcepto
  });

  final String idConcepto;
  final String nombreConcepto;

  factory Concepto.fromJson(Map<String, dynamic> json) => _$ConceptoFromJson(json);

  Map<String, dynamic> toJson() => _$ConceptoToJson(this);
}