// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaccion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaccion _$TransaccionFromJson(Map<String, dynamic> json) => Transaccion(
      descripcion: json['descripcion'] as String?,
      fecha: DateTime.parse(json['fecha'] as String),
      idConcepto: json['idConcepto'] as String,
      idCuenta: json['idCuenta'] as String,
      idTransaccion: json['idTransaccion'] as String?,
      monto: (json['monto'] as num).toDouble(),
      nombre: json['nombre'] as String,
    );

Map<String, dynamic> _$TransaccionToJson(Transaccion instance) =>
    <String, dynamic>{
      'idTransaccion': instance.idTransaccion,
      'fecha': instance.fecha.toIso8601String(),
      'nombre': instance.nombre,
      'monto': instance.monto,
      'idCuenta': instance.idCuenta,
      'idConcepto': instance.idConcepto,
      'descripcion': instance.descripcion,
    };
