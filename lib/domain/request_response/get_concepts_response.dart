import 'package:accounting_app/domain/model/concepto.dart';

class GetConceptsResponse {
  GetConceptsResponse({
    required this.conceptos
  });
  
  List<Concepto> conceptos;

  factory GetConceptsResponse.fromJson(List<dynamic> json) {
    return GetConceptsResponse(
      conceptos: (json)
          .map((e) => Concepto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}