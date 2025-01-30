part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

class NewTransaction extends TransactionEvent {
  final Transaccion transaccion;

  NewTransaction({
    required this.transaccion
  });
}
