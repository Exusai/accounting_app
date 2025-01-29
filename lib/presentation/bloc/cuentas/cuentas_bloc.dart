import 'package:accounting_app/domain/request_response/get_accounts_response.dart';
import 'package:accounting_app/domain/usecase/get_accounts.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cuentas_event.dart';
part 'cuentas_state.dart';

class CuentasBloc extends Bloc<CuentasEvent, CuentasState> {
  GetAccounts getAccounts = GetAccounts();

  CuentasBloc() : super(CuentasLoading()) {
    on<GetCuentas>((event, emit) async {
      try {
        emit(CuentasLoading());
        GetAccountsResponse getAccountsResponse = await getAccounts.call();
        emit(CuentasLoaded(getAccountsResponse: getAccountsResponse));
      } catch (e) {
        emit(CuentasError());
      }
    });
  }
}
