import 'package:accounting_app/data/remote/repo/accounting_repo.dart';
import 'package:accounting_app/domain/request_response/get_concepts_response.dart';

class GetConcepts {
  AccountingRepo accountingRepo = AccountingRepo();

  Future<GetConceptsResponse> call(){
    return accountingRepo.getConcepts();
  }
}