import 'package:accounting_app/domain/model/transaccion.dart';
import 'package:accounting_app/domain/request_response/get_accounts_response.dart';
import 'package:accounting_app/domain/request_response/get_concepts_response.dart';
import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_request.dart';
import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_response.dart';
import 'package:dio/dio.dart';

class AccountingRepo {
  final dio = Dio();

  Future<GetEstadoDeCuentasResponse> getEstadoDeCuentas(GetEstadoDeCuentasRequest getEstadoDeCuentasRequest) async {
    try {
      var response = await dio.get(
        'http://localhost:8080/getResumenEstadoDeCuenta?startDate=${getEstadoDeCuentasRequest.startDate.toIso8601String()}&endDate=${getEstadoDeCuentasRequest.endDate.toIso8601String()}',
      );
      return GetEstadoDeCuentasResponse.fromJson(response.data);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<GetConceptsResponse> getConcepts() async {
    try {
      var response = await dio.get(
        'http://localhost:8080/getConcepts',
      );
      return GetConceptsResponse.fromJson(response.data);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<GetAccountsResponse> getAccounts() async {
    try {
      var response = await dio.get(
        'http://localhost:8080/getAccounts',
      );
      return GetAccountsResponse.fromJson(response.data);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> addTransaction(Transaccion transaccion) async {
    try {
      var _ = await dio.post(
        'http://localhost:8080/insertarMovimientoEstadoCuenta',
        data: transaccion.toJson()
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> eliminarUltimoMovimientoEstadoCuenta() async {
    try {
      var _ = await dio.post(
        'http://localhost:8080/eliminarUltimoMovimientoEstadoCuenta',
        data: {},
      );
    } on Exception catch (_) {
      rethrow;
    }
  }
  
}