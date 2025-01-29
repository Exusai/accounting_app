part of 'get_estado_de_cuenta_bloc.dart';

@immutable
sealed class GetEstadoDeCuentaState {}

final class GetEstadoDeCuentaLoading extends GetEstadoDeCuentaState {}
final class GetEstadoDeCuentaLoaded extends GetEstadoDeCuentaState {
  final GetEstadoDeCuentasResponse getEstadoDeCuentasResponse;

  GetEstadoDeCuentaLoaded({
    required this.getEstadoDeCuentasResponse
  });
}
final class GetEstadoDeCuentaError extends GetEstadoDeCuentaState {}
