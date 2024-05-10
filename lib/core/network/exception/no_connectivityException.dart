class NoConnectivityException implements Exception{
  final String? message;

  /// The duration that was exceeded.
  NoConnectivityException({this.message = 'No Internet Connection'});

  @override
  String toString() {
    String result = 'NoConnectivityException';
    if (message != null) result = '$result: $message';
    return result;
  }
}