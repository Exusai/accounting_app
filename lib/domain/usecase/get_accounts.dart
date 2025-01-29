import 'package:accounting_app/data/remote/repo/accounting_repo.dart';
import 'package:accounting_app/domain/request_response/get_accounts_response.dart';

class GetAccounts {
  AccountingRepo accountingRepo = AccountingRepo();

  Future<GetAccountsResponse> call(){
    return accountingRepo.getAccounts();
  }
}