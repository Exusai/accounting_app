import 'package:accounting_app/domain/model/resumen_estado_cuenta.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GetEstadoDeCuentasResponse {
  GetEstadoDeCuentasResponse({
    required this.estadoDecuenta,
  });
  
  List<ResumenEstadoCuenta> estadoDecuenta;

  factory GetEstadoDeCuentasResponse.fromJson(List<dynamic> json) {
    return GetEstadoDeCuentasResponse(
      estadoDecuenta: (json)
          .map((e) => ResumenEstadoCuenta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  void sortByDate(bool ascending){
    estadoDecuenta.sort((a,b) => a.fecha.compareTo(b.fecha));
    if (!ascending){
      estadoDecuenta = estadoDecuenta.reversed.toList();
    }
    enableMovimientoVisibility();
  }

  void sortByAmount(bool ascending){
    estadoDecuenta.sort((a,b) => a.monto.compareTo(b.monto));
    if (!ascending) {
      estadoDecuenta = estadoDecuenta.reversed.toList();
    }
    disableMovimientoVisibility();
  }

  void disableMovimientoVisibility(){
    for (var a in estadoDecuenta) {
      if(a.nombreConcepto == "Movimiento"){
        a.visible = false;
      }
    }
  }

  void enableMovimientoVisibility(){
    for (var a in estadoDecuenta) {
      if(a.nombreConcepto == "Movimiento"){
        a.visible = true;
      }
    }
  }
}