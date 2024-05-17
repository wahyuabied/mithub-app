import 'dart:convert';

class ContentMarketPlaceResponse {
  final String? description;
  final double? distance;
  final FileClass? file;
  final int? id;
  final String? name;
  final int? price;
  final String? status;
  final Store? store;
  final String? type;

  ContentMarketPlaceResponse({
    this.description,
    this.distance,
    this.file,
    this.id,
    this.name,
    this.price,
    this.status,
    this.store,
    this.type,
  });

  factory ContentMarketPlaceResponse.fromJson(String str) => ContentMarketPlaceResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentMarketPlaceResponse.fromMap(Map<String, dynamic> json) => ContentMarketPlaceResponse(
    description: json["description"],
    distance: json["distance"]?.toDouble(),
    file: json["file"] == null ? null : FileClass.fromMap(json["file"]),
    id: json["id"],
    name: json["name"],
    price: json["price"],
    status: json["status"],
    store: json["store"] == null ? null : Store.fromMap(json["store"]),
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "description": description,
    "distance": distance,
    "file": file?.toMap(),
    "id": id,
    "name": name,
    "price": price,
    "status": status,
    "store": store?.toMap(),
    "type": type,
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
  final int? id;
  final String? name;
  final String? phoneNumber;

  Store({
    this.address,
    this.id,
    this.name,
    this.phoneNumber,
  });

  factory Store.fromJson(String str) => Store.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Store.fromMap(Map<String, dynamic> json) => Store(
    address: json["address"],
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toMap() => {
    "address": address,
    "id": id,
    "name": name,
    "phone_number": phoneNumber,
  };
}
