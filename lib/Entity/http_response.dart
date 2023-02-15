class CustomHttpResponse {
  dynamic body;
  int statusCode;
  String message;

  CustomHttpResponse(
      {this.body, required this.statusCode, required this.message});

  @override
  String toString() {
    return 'CustomHttpResponse{statusCode: $statusCode, message: $message, body: $body, }';
  }
}
