part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionLoading extends TransactionState {}
final class TransactionLoaded extends TransactionState {}
final class TransactionError extends TransactionState {}
