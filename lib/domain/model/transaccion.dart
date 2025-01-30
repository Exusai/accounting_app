import 'package:json_annotation/json_annotation.dart';

part 'transaccion.g.dart';

@JsonSerializable()
class Transaccion {
  Transaccion({
    required this.descripcion,
    required this.fecha,
    required this.idConcepto,
    required this.idCuenta,
    required this.idTransaccion,
    required this.monto,
    required this.nombre,
  });

  String? idTransaccion; // is null on request, but shall not be null when data comes from db
  DateTime fecha;
  String nombre;
  double monto;
  String idCuenta;
  String idConcepto;
  String? descripcion;

  factory Transaccion.fromJson(Map<String, dynamic> json) => _$TransaccionFromJson(json);

  Map<String, dynamic> toJson() => _$TransaccionToJson(this);
}