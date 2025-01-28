import 'package:accounting_app/domain/request/get_estado_de_cuentas_request.dart';
import 'package:accounting_app/domain/request/get_estado_de_cuentas_response.dart';
import 'package:dio/dio.dart';

class AccountingRepo {
  final dio = Dio();

  Future<GetEstadoDeCuentasResponse> getEstadoDeCuentas(GetEstadoDeCuentasRequest getEstadoDeCuentasRequest) async {
    var response = await dio.get(
      'localhost:8080/getResumenEstadoDeCuenta?startDate=${getEstadoDeCuentasRequest.startDate.toIso8601String()}&endDate=${getEstadoDeCuentasRequest.endDate.toIso8601String()}',
    );

    return GetEstadoDeCuentasResponse.fromJson(response.data);
  }
  
}