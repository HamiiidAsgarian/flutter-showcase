sealed class AppException implements Exception {
  AppException({
    this.id,
    this.error,
    this.additionalData = '',
    this.isLogged = false,
    this.stackTrace,
  });
  final String? id;
  final String? error;
  final String additionalData;
  final bool isLogged;
  final StackTrace? stackTrace;
}

//----
class JsonParseException extends AppException {
  JsonParseException({
    required super.error,
    this.body,
  }) : super(
          additionalData: 'recieved body: $body',
        );

  String? body;
}
