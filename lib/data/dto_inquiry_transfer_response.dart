import 'dart:convert';

class InquiryTransferResponse {
  final String? amount;
  final String? receiptNumber;
  final int? transactionId;

  InquiryTransferResponse({
    this.amount,
    this.receiptNumber,
    this.transactionId,
  });

  factory InquiryTransferResponse.fromJson(String str) => InquiryTransferResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InquiryTransferResponse.fromMap(Map<String, dynamic> json) => InquiryTransferResponse(
    amount: json["amount"],
    receiptNumber: json["receipt_number"],
    transactionId: json["transaction_id"],
  );

  Map<String, dynamic> toMap() => {
    "amount": amount,
    "receipt_number": receiptNumber,
    "transaction_id": transactionId,
  };
}
