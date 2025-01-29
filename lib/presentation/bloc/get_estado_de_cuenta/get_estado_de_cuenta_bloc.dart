import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_request.dart';
import 'package:accounting_app/domain/request_response/get_estado_de_cuentas_response.dart';
import 'package:accounting_app/domain/usecase/get_estado_de_cuenta_by_date.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_estado_de_cuenta_event.dart';
part 'get_estado_de_cuenta_state.dart';

class GetEstadoDeCuentaBloc extends Bloc<GetEstadoDeCuentaEvent, GetEstadoDeCuentaState> {
  final GetEstadoDeCuentaByDate getEstadoDeCuentaByDate = GetEstadoDeCuentaByDate();

  GetEstadoDeCuentaBloc() : super(GetEstadoDeCuentaLoading()) {
    on<GetEstadoDeCuentaForDate>((event, emit) async  {
      try {
        emit(GetEstadoDeCuentaLoading());
        GetEstadoDeCuentasResponse getEstadoDeCuentasResponse = await getEstadoDeCuentaByDate.call(event.getEstadoDeCuentasRequest);
        emit(GetEstadoDeCuentaLoaded(
          getEstadoDeCuentasResponse: getEstadoDeCuentasResponse
        ));
      } catch (e) {
        emit(GetEstadoDeCuentaError());
      }
    });
  }
}
