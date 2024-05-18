import 'dart:convert';

class VerifyTransferBody {
  final String? accountNumber;
  final String? beneficiaryAccountNumber;
  final int? amount;
  final String? receiptNumber;
  final String? transactionId;

  VerifyTransferBody({
    this.accountNumber,
    this.beneficiaryAccountNumber,
    this.amount,
    this.receiptNumber,
    this.transactionId,
  });

  factory VerifyTransferBody.fromJson(String str) => VerifyTransferBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyTransferBody.fromMap(Map<String, dynamic> json) => VerifyTransferBody(
    accountNumber: json["account_number"],
    beneficiaryAccountNumber: json["beneficiary_account_number"],
    amount: json["amount"],
    receiptNumber: json["receipt_number"],
    transactionId: json["transaction_id"],
  );

  Map<String, dynamic> toMap() => {
    "account_number": accountNumber,
    "beneficiary_account_number": beneficiaryAccountNumber,
    "amount": amount,
    "receipt_number": receiptNumber,
    "transaction_id": transactionId,
  };
}
