// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_estado_de_cuentas_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEstadoDeCuentasResponse _$GetEstadoDeCuentasResponseFromJson(
        Map<String, dynamic> json) =>
    GetEstadoDeCuentasResponse(
      estadoDecuenta: (json['estadoDecuenta'] as List<dynamic>)
          .map((e) => EstadoDeCuenta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetEstadoDeCuentasResponseToJson(
        GetEstadoDeCuentasResponse instance) =>
    <String, dynamic>{
      'estadoDecuenta': instance.estadoDecuenta,
    };
