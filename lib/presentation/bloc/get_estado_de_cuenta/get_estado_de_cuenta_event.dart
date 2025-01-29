part of 'get_estado_de_cuenta_bloc.dart';

@immutable
sealed class GetEstadoDeCuentaEvent {}

final class GetEstadoDeCuentaForDate extends GetEstadoDeCuentaEvent{
  final GetEstadoDeCuentasRequest getEstadoDeCuentasRequest;

  GetEstadoDeCuentaForDate({
    required this.getEstadoDeCuentasRequest
  });
}
