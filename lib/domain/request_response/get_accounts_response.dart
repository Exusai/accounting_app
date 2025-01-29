import 'package:accounting_app/domain/model/cuenta.dart';

class GetAccountsResponse {
  GetAccountsResponse({
    required this.cuenta
  });
  
  List<Cuenta> cuenta;

  factory GetAccountsResponse.fromJson(List<dynamic> json) {
    return GetAccountsResponse(
      cuenta: (json)
          .map((e) => Cuenta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}