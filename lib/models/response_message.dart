class ResponseMessage {
  final int status;
  String reason;

  ResponseMessage({
    required this.status,
    this.reason = 'Error',
  });

  String get message => reason.isEmpty ? 'Unknown reason' : reason;
}
