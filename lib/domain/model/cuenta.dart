import 'package:json_annotation/json_annotation.dart';

part 'cuenta.g.dart';

@JsonSerializable()
class Cuenta {
  Cuenta({
    required this.credito,
    required this.idCuenta,
    required this.nombreCuenta,
    required this.saldo,
  });

  String idCuenta;
  bool credito;
  String nombreCuenta;
  double saldo;

  factory Cuenta.fromJson(Map<String, dynamic> json) => _$CuentaFromJson(json);

  Map<String, dynamic> toJson() => _$CuentaToJson(this);
}