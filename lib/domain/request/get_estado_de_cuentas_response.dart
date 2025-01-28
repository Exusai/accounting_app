import 'package:accounting_app/domain/model/estado_de_cuenta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_estado_de_cuentas_response.g.dart';

@JsonSerializable()
class GetEstadoDeCuentasResponse {
  GetEstadoDeCuentasResponse({
    required this.estadoDecuenta
  });

  List<EstadoDeCuenta> estadoDecuenta;

  factory GetEstadoDeCuentasResponse.fromJson(Map<String, dynamic> json) => _$GetEstadoDeCuentasResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetEstadoDeCuentasResponseToJson(this);
}