import 'package:accounting_app/data/remote/repo/accounting_repo.dart';
import 'package:accounting_app/domain/model/transaccion.dart';

class AddTransaction {
  AccountingRepo accountingRepo = AccountingRepo();
  
  Future<void> call(Transaccion transaccion){
    return accountingRepo.addTransaction(transaccion);
  }
}