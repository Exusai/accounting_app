import 'package:json_annotation/json_annotation.dart';

part 'estado_de_cuenta.g.dart';

@JsonSerializable()
class EstadoDeCuenta {
  EstadoDeCuenta({
    required this.deudaTotal,
    required this.idEstadoCuenta,
    required this.idTransaccion,
    required this.saldoCuentaTransaccion,
    required this.total,
  });

  final String idEstadoCuenta;
  final String idTransaccion;
  final double total;
  final double deudaTotal;
  final double saldoCuentaTransaccion;

  factory EstadoDeCuenta.fromJson(Map<String, dynamic> json) => _$EstadoDeCuentaFromJson(json);

  Map<String, dynamic> toJson() => _$EstadoDeCuentaToJson(this);
}