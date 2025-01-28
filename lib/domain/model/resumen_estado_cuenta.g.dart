// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resumen_estado_cuenta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumenEstadoCuenta _$ResumenEstadoCuentaFromJson(Map<String, dynamic> json) =>
    ResumenEstadoCuenta(
      deudaTotal: (json['deudaTotal'] as num).toDouble(),
      fecha: DateTime.parse(json['fecha'] as String),
      monto: (json['monto'] as num).toDouble(),
      nombre: json['nombre'] as String,
      nombreConcepto: json['nombreConcepto'] as String,
      nombreCuenta: json['nombreCuenta'] as String,
      saldoCuentaTransaccion:
          (json['saldoCuentaTransaccion'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$ResumenEstadoCuentaToJson(
        ResumenEstadoCuenta instance) =>
    <String, dynamic>{
      'fecha': instance.fecha.toIso8601String(),
      'nombre': instance.nombre,
      'nombreConcepto': instance.nombreConcepto,
      'monto': instance.monto,
      'nombreCuenta': instance.nombreCuenta,
      'saldoCuentaTransaccion': instance.saldoCuentaTransaccion,
      'total': instance.total,
      'deudaTotal': instance.deudaTotal,
    };
