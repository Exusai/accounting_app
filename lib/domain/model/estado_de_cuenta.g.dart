// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estado_de_cuenta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstadoDeCuenta _$EstadoDeCuentaFromJson(Map<String, dynamic> json) =>
    EstadoDeCuenta(
      deudaTotal: (json['deudaTotal'] as num).toDouble(),
      idEstadoCuenta: json['idEstadoCuenta'] as String,
      idTransaccion: json['idTransaccion'] as String,
      saldoCuentaTransaccion:
          (json['saldoCuentaTransaccion'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$EstadoDeCuentaToJson(EstadoDeCuenta instance) =>
    <String, dynamic>{
      'idEstadoCuenta': instance.idEstadoCuenta,
      'idTransaccion': instance.idTransaccion,
      'total': instance.total,
      'deudaTotal': instance.deudaTotal,
      'saldoCuentaTransaccion': instance.saldoCuentaTransaccion,
    };
