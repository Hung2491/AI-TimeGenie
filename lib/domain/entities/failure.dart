class Failure {
  String? error;
  
  Failure({this.error});

  @override
  String toString() => 'Failure(message: $error)';
}
