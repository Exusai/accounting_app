import 'package:accounting_app/domain/model/transaccion.dart';
import 'package:accounting_app/domain/usecase/add_transaction.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  AddTransaction addTransaction =  AddTransaction();

  TransactionBloc() : super(TransactionLoading()) {
    on<NewTransaction>((event, emit) {
      try {
        emit(TransactionLoading());
        addTransaction.call(event.transaccion);
        emit(TransactionLoaded());
      } catch (e) {
        emit(TransactionError());
      }
    });
  }
}
