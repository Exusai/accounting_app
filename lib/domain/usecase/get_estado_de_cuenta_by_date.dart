import 'package:accounting_app/data/remote/repo/accounting_repo.dart';
import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_request.dart';
import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_response.dart';

class GetEstadoDeCuentaByDate {
  AccountingRepo accountingRepo = AccountingRepo();

  Future<GetEstadoDeCuentasResponse> call(GetEstadoDeCuentasRequest getEstadoDeCuentasRequest){
    return accountingRepo.getEstadoDeCuentas(getEstadoDeCuentasRequest);
  }
}