import 'package:accounting_app/data/remote/repo/accounting_repo.dart';

class DeleteLasttransaction {
  AccountingRepo accountingRepo = AccountingRepo();
  
  Future<void> call(){
    return accountingRepo.eliminarUltimoMovimientoEstadoCuenta();
  }
}