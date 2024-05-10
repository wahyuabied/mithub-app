class NotificationData {
  final String? type;
  final String? deeplink;
  final String? transactionId;

  NotificationData({
    this.deeplink,
    this.type,
    this.transactionId,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        type: json['type'],
        deeplink: json['deeplink'],
        transactionId: json['reference_id'],
      );
}