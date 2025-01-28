import 'package:json_annotation/json_annotation.dart';

part 'resumen_estado_cuenta.g.dart';

@JsonSerializable()
class ResumenEstadoCuenta {
  ResumenEstadoCuenta({
    required this.deudaTotal,
    required this.fecha,
    required this.monto,
    required this.nombre,
    required this.nombreConcepto,
    required this.nombreCuenta,
    required this.saldoCuentaTransaccion,
    required this.total,
  });

  final DateTime fecha;
  final String nombre;
  final String nombreConcepto;
  final double monto;
  final String nombreCuenta;
  final double saldoCuentaTransaccion;
  final double total;
  final double deudaTotal;

  factory ResumenEstadoCuenta.fromJson(Map<String, dynamic> json) => _$ResumenEstadoCuentaFromJson(json);

  Map<String, dynamic> toJson() => _$ResumenEstadoCuentaToJson(this);
}