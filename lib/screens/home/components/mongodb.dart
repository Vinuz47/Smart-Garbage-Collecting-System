import 'dart:developer';

//import 'package:firebase_auth/firebase_auth.dart';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shop_app/screens/home/components/UserPages/reusable_widget/MongoDBModel.dart';
import 'package:shop_app/screens/home/components/content.dart';

class MongoDatabase {
  static var collection1, collection2;
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    
    print(status);
    collection1 = db.collection(COLLECTION_NAME1);
    collection2 = db.collection(COLLECTION_NAME2);

    // print(await collection1.find().toList());
    //  print(await collection2.find().toList());
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await collection2.find().toList();
    return arrData;
  }

  static Future<void> postData(MongoDbModel data) async {
    try {
      var result = await collection2.insertOne(data.toJson());
      if (result.isSuccess) {
        //return "Data inserted";
      } else {
        // return "Something Wrong while inserting data";
      }
    } catch (e) {
      print(e.toString());
      //return e.toString();
    }
  }
}
