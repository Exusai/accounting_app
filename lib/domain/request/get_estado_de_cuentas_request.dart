class GetEstadoDeCuentasRequest {
  GetEstadoDeCuentasRequest({
    required this.endDate,
    required this.startDate,
  });
  
  DateTime startDate;
  DateTime endDate;
}