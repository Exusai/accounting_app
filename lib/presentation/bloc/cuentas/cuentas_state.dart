part of 'cuentas_bloc.dart';

@immutable
sealed class CuentasState {}

final class CuentasLoading extends CuentasState {}
final class CuentasLoaded extends CuentasState {
  final GetAccountsResponse getAccountsResponse;

  CuentasLoaded({
    required this.getAccountsResponse
  });
}
final class CuentasError extends CuentasState {}
