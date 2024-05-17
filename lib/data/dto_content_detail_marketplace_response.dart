import 'dart:convert';

class ContentDetailMarketPlace {
  final Borrower? borrower;
  final String? description;
  final FileClass? file;
  final int? id;
  final String? name;
  final int? price;
  final String? status;
  final Store? store;
  final String? type;

  ContentDetailMarketPlace({
    this.borrower,
    this.description,
    this.file,
    this.id,
    this.name,
    this.price,
    this.status,
    this.store,
    this.type,
  });

  factory ContentDetailMarketPlace.fromJson(String str) => ContentDetailMarketPlace.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentDetailMarketPlace.fromMap(Map<String, dynamic> json) => ContentDetailMarketPlace(
    borrower: json["borrower"] == null ? null : Borrower.fromMap(json["borrower"]),
    description: json["description"],
    file: json["file"] == null ? null : FileClass.fromMap(json["file"]),
    id: json["id"],
    name: json["name"],
    price: json["price"],
    status: json["status"],
    store: json["store"] == null ? null : Store.fromMap(json["store"]),
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "borrower": borrower?.toMap(),
    "description": description,
    "file": file?.toMap(),
    "id": id,
    "name": name,
    "price": price,
    "status": status,
    "store": store?.toMap(),
    "type": type,
  };
}

class Borrower {
  final String? customerNumber;
  final FileClass? file;
  final int? id;
  final String? name;
  final String? nik;
  final String? phoneNumber;

  Borrower({
    this.customerNumber,
    this.file,
    this.id,
    this.name,
    this.nik,
    this.phoneNumber,
  });

  factory Borrower.fromJson(String str) => Borrower.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Borrower.fromMap(Map<String, dynamic> json) => Borrower(
    customerNumber: json["customer_number"],
    file: json["file"] == null ? null : FileClass.fromMap(json["file"]),
    id: json["id"],
    name: json["name"],
    nik: json["nik"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toMap() => {
    "customer_number": customerNumber,
    "file": file?.toMap(),
    "id": id,
    "name": name,
    "nik": nik,
    "phone_number": phoneNumber,
  };
}

class FileClass {
  final String? path;

  FileClass({
    this.path,
  });

  factory FileClass.fromJson(String str) => FileClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileClass.fromMap(Map<String, dynamic> json) => FileClass(
    path: json["path"],
  );

  Map<String, dynamic> toMap() => {
    "path": path,
  };
}

class Store {
  final String? address;
  final String? description;
  final FileClass? file;
  final int? id;
  final String? name;
  final String? phoneNumber;
  final String? status;

  Store({
    this.address,
    this.description,
    this.file,
    this.id,
    this.name,
    this.phoneNumber,
    this.status,
  });

  factory Store.fromJson(String str) => Store.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Store.fromMap(Map<String, dynamic> json) => Store(
    address: json["address"],
    description: json["description"],
    file: json["file"] == null ? null : FileClass.fromMap(json["file"]),
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "address": address,
    "description": description,
    "file": file?.toMap(),
    "id": id,
    "name": name,
    "phone_number": phoneNumber,
    "status": status,
  };
}
