// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
    ObjectId id;
    String username;
    String name;
    String items;
    String unitPrice;
    String longi;
    String latid;
    String locationAddress;

    MongoDbModel({
        required this.id,
        required this.username,
        required this.name,
        required this.items,
        required this.unitPrice,
        required this.longi,
        required this.latid,
        required this.locationAddress
    });

    factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        username: json["username"],
        name: json["name"],
        items: json["items"],
        unitPrice: json["unit price"],
        longi: json["longi"],
        latid: json["latid"],
        locationAddress: json["locationAddress"]
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "name": name,
        "items": items,
        "unit price": unitPrice,
        "longi": longi,
        "latid": latid,
        "locationAddress": locationAddress
    };
}
