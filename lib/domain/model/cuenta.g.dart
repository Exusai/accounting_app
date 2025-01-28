// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuenta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cuenta _$CuentaFromJson(Map<String, dynamic> json) => Cuenta(
      credito: json['credito'] as bool,
      idCuenta: json['idCuenta'] as String,
      nombreCuenta: json['nombreCuenta'] as String,
      saldo: (json['saldo'] as num).toDouble(),
    );

Map<String, dynamic> _$CuentaToJson(Cuenta instance) => <String, dynamic>{
      'idCuenta': instance.idCuenta,
      'credito': instance.credito,
      'nombreCuenta': instance.nombreCuenta,
      'saldo': instance.saldo,
    };
