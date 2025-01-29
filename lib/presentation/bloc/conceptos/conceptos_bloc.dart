import 'package:accounting_app/domain/request_response/get_concepts_response.dart';
import 'package:accounting_app/domain/usecase/get_concepts.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'conceptos_event.dart';
part 'conceptos_state.dart';

class ConceptosBloc extends Bloc<ConceptosEvent, ConceptosState> {
  GetConcepts getConcepts = GetConcepts();

  ConceptosBloc() : super(ConceptosLoading()) {
    on<GetConceptos>((event, emit) async {
      try {
        emit(ConceptosLoading());
        GetConceptsResponse getConceptsResponse = await getConcepts.call();
        emit(ConceptosLoaded(
          getConceptsResponse: getConceptsResponse
        ));
      } catch (e) {
        emit(ConceptosError());
      }
    });
  }
}
