part of 'conceptos_bloc.dart';

@immutable
sealed class ConceptosState {}

final class ConceptosLoading extends ConceptosState {}
final class ConceptosLoaded extends ConceptosState {
  final GetConceptsResponse getConceptsResponse;
  ConceptosLoaded({
    required this.getConceptsResponse
  });
}
final class ConceptosError extends ConceptosState {}
