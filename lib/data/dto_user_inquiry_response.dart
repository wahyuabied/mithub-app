import 'dart:convert';

class UserInquiryResponse {
  final String? accountNumber;
  final String? availableBalance;
  final String? balance;
  final String? customerNumber;
  final String? phoneNumber;
  final int? state;

  UserInquiryResponse({
    this.accountNumber,
    this.availableBalance,
    this.balance,
    this.customerNumber,
    this.phoneNumber,
    this.state,
  });

  factory UserInquiryResponse.fromJson(String str) => UserInquiryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInquiryResponse.fromMap(Map<String, dynamic> json) => UserInquiryResponse(
    accountNumber: json["account_number"],
    availableBalance: json["available_balance"],
    balance: json["balance"],
    customerNumber: json["customer_number"],
    phoneNumber: json["phone_number"],
    state: json["state"],
  );

  Map<String, dynamic> toMap() => {
    "account_number": accountNumber,
    "available_balance": availableBalance,
    "balance": balance,
    "customer_number": customerNumber,
    "phone_number": phoneNumber,
    "state": state,
  };
}
