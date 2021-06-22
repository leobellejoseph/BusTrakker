class Failure {
  final String code;
  final String message;

  Failure({required this.code, required this.message});

  factory Failure.none() => Failure(code: '', message: '');
}
