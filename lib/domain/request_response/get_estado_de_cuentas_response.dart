import 'package:accounting_app/domain/model/resumen_estado_cuenta.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GetEstadoDeCuentasResponse {
  GetEstadoDeCuentasResponse({
    required this.estadoDecuenta
  });
  
  List<ResumenEstadoCuenta> estadoDecuenta;

  factory GetEstadoDeCuentasResponse.fromJson(List<dynamic> json) {
    return GetEstadoDeCuentasResponse(
      estadoDecuenta: (json)
          .map((e) => ResumenEstadoCuenta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}