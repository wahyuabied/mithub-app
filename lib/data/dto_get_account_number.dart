import 'dart:convert';

class GetAccountNumberResponse {
  final String? accountNumber;
  final String? customerNumber;
  final String? name;
  final String? phoneNumber;

  GetAccountNumberResponse({
    this.accountNumber,
    this.customerNumber,
    this.name,
    this.phoneNumber,
  });

  factory GetAccountNumberResponse.fromJson(String str) => GetAccountNumberResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAccountNumberResponse.fromMap(Map<String, dynamic> json) => GetAccountNumberResponse(
    accountNumber: json["account_number"],
    customerNumber: json["customer_number"],
    name: json["name"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toMap() => {
    "account_number": accountNumber,
    "customer_number": customerNumber,
    "name": name,
    "phone_number": phoneNumber,
  };
}