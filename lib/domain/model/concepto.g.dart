// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concepto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Concepto _$ConceptoFromJson(Map<String, dynamic> json) => Concepto(
      idConcepto: json['idConcepto'] as String,
      nombreConcepto: json['nombreConcepto'] as String,
      presupuesto: (json['presupuesto'] as num).toDouble(),
    );

Map<String, dynamic> _$ConceptoToJson(Concepto instance) => <String, dynamic>{
      'idConcepto': instance.idConcepto,
      'nombreConcepto': instance.nombreConcepto,
      'presupuesto': instance.presupuesto,
    };
