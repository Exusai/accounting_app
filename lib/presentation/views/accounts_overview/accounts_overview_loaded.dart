import 'package:accounting_app/domain/request_response/get_accounts_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountsOverviewLoaded extends StatelessWidget {
  final GetAccountsResponse getAccountsResponse;

  static NumberFormat moneyNumberFormat = NumberFormat('\$###,###,###,###.##', 'es_MX');
  
  const AccountsOverviewLoaded({super.key, required this.getAccountsResponse});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List<Widget>.from(
        getAccountsResponse.cuenta.map((x) => Row(
          children: [
            Text(x.nombreCuenta),
            Spacer(),
            Text(moneyNumberFormat.format(x.saldo))
          ],
        ))
      ),
    );
  }
}