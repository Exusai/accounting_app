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
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<GetConceptsResponse> getConcepts() async {
    try {
      var response = await dio.get(
        'http://localhost:8080/getConcepts',
      );
      return GetConceptsResponse.fromJson(response.data);
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<GetAccountsResponse> getAccounts() async {
    try {
      var response = await dio.get(
        'http://localhost:8080/getAccounts',
      );
      return GetAccountsResponse.fromJson(response.data);
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }
  
}