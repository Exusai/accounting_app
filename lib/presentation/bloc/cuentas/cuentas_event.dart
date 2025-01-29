part of 'cuentas_bloc.dart';

@immutable
sealed class CuentasEvent {}

class GetCuentas extends CuentasEvent {}