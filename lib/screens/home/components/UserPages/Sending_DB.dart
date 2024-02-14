import 'package:mongo_dart/mongo_dart.dart';
import 'package:shop_app/screens/home/MongoDB/Mongoconst.dart';

class DataBaseServices {
  static Future<void> insertingdata(String user, String type, int points, String text) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);

    await collection.update(where.eq('username', user), modify.inc(type, points));
    await collection.update(where.eq('username', user), modify.push('items', text));
  }

  static Future<void> insertingPoints(String user, int points) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);

    await collection.update(where.eq('username', user), modify.inc('points', points));
  }

  static Future<void> insertinguser(String user) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);

    await collection.insertOne(
        {"username": user, "plastic": 0, "glass": 0, "tin": 0, "paper": 0, "cardboard": 0, "electronic": 0, "other": 0, "points": 0, "items": []});
  }

  static Future<void> after_point_transfer(String user) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);
    // await collection.update(
    //   where.eq('username', user),
    //   modify.set({
    //     "plastic": 0,
    //     "glass": 0,
    //     "tin": 0,
    //     "paper": 0,
    //     "cardboard": 0,
    //     "electronic": 0,
    //     "other": 0,
    //     "points": 0,
    //     "items": [],
    //   }),
    // );

    await collection.update(where.eq('username', user), modify.set('plastic', 0));
    await collection.update(where.eq('username', user), modify.set('glass', 0));
    await collection.update(where.eq('username', user), modify.set('tin', 0));
    await collection.update(where.eq('username', user), modify.set('paper', 0));
    await collection.update(where.eq('username', user), modify.set('electronic', 0));
    await collection.update(where.eq('username', user), modify.set('other', 0));
    await collection.update(where.eq('username', user), modify.set('points', 0));
    await collection.update(where.eq('username', user), modify.set('items', []));
  }

  Future<Map<String, dynamic>> getData(String username) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    final collection = db.collection(COLLECTION_NAME);
    final query = collection.find(where.eq('username', username));
    final document = await query.first;

    return {
      'plasticPoints': document['plastic'] as int,
      'glassPoints': document['glass'] as int,
      'tinPoints': document['tin'] as int,
      'paperPoints': document['paper'] as int,
      'cardboardPoints': document['cardboard'] as int,
      'electronicPoints': document['electronic'] as int,
      'otherPoints': document['other'] as int,
      'transferPoints': document['points'] as int,
      'totalPoints': (document['plastic'] as int) +
          (document['glass'] as int) +
          (document['tin'] as int) +
          (document['paper'] as int) +
          (document['cardboard'] as int) +
          (document['electronic'] as int) +
          (document['other'] as int) +
          (document['points'] as int),
      'indicator': ((document['plastic'] as int) +
              (document['glass'] as int) +
              (document['tin'] as int) +
              (document['paper'] as int) +
              (document['cardboard'] as int) +
              (document['electronic'] as int) +
              (document['other'] as int) +
              (document['points'] as int)) /
          1000,
    };
  }

  Future<List<dynamic>> fetchmongo(String ToPass) async {
    int plastic100 = 0;
    int plastic250 = 0;
    int plastic500 = 0;
    int plastic750 = 0;
    int plastic15 = 0;
    int plastic2 = 0;
    int papersmall = 0;
    int papermedium = 0;
    int paperlarge = 0;
    int glass100 = 0;
    int mobilephone = 0;
    int computerparts = 0;
    int other = 0;
    int count;
    int pageSize = 10;
    List<dynamic> resultlist = [];

    var db = await Db.create(MONGO_URL);
    await db.open();

    final collection = db.collection(COLLECTION_NAME);

    final query = collection.find(
      where.eq('username', ToPass),
    );

    // final documents = await query.toList();

// // Adjust the page and pageSize values to skip and limit the results
//     final startIndex = (page - 1) * pageSize;
//     final endIndex = startIndex + pageSize;
//     print("Document length : ${documents.length}");
//     print("page value: $page");
// // Ensure startIndex is within bounds
//     if (documents.length == 1) {
//       // Use sublist to get the items for the current page
//       //final documentsForPage = documents.sublist(startIndex, endIndex > documents.length ? documents.length : endIndex);

//       final arrayField = documents[0]['items'];

//       for (String item in List<String>.from(arrayField)) {
//         // Your existing logic for processing items...
//         if (item.contains("plastic 100ml")) {
//           count = int.parse(item.split(" ")[0]);
//           plastic100 += count;
//           // resultlist.add(item);
//         }

//         if (item.contains("plastic 250ml")) {
//           count = int.parse(item.split(" ")[0]);
//           plastic250 += count;
//         }
//         if (item.contains("plastic 500ml")) {
//           count = int.parse(item.split(" ")[0]);
//           plastic500 += count;
//         }
//         if (item.contains("plastic 750ml")) {
//           count = int.parse(item.split(" ")[0]);
//           plastic750 += count;
//         }
//         if (item.contains("plastic 1.5L")) {
//           count = int.parse(item.split(" ")[0]);
//           plastic15 += count;
//         }
//         if (item.contains("plastic 2L")) {
//           count = int.parse(item.split(" ")[0]);
//           plastic2 += count;
//         }

//         if (item.contains("glass 100ml")) {
//           count = int.parse(item.split(" ")[0]);
//           glass100 += count;
//         }

//         if (item.contains("paper small amount")) {
//           papersmall += 1;
//         }
//         if (item.contains("paper medium amount")) {
//           papermedium += 1;
//         }
//         if (item.contains("paper large amount")) {
//           paperlarge += 1;
//         }
//         if (item.contains("Computer parts")) {
//           computerparts += 1;
//         }
//         if (item.contains("Mobile phone")) {
//           mobilephone += 1;
//         }
//         if (item.contains("Other")) {
//           other += 1;
//         }
//       }

//       // Your existing logic for adding results to resultlist...
//       if (plastic100 != 0) {
//         resultlist.add("Plastic 100ml plastic bottels : $plastic100");
//       }
//       if (plastic250 != 0) {
//         resultlist.add("Plastic 250ml plastic bottels : $plastic250");
//       }
//       if (plastic500 != 0) {
//         resultlist.add("Plastic 500ml plastic bottels : $plastic500");
//       }
//       if (plastic750 != 0) {
//         resultlist.add("Plastic 750ml plastic bottels : $plastic750");
//       }
//       if (plastic15 != 0) {
//         resultlist.add("Plastic 1.5L plastic bottels : $plastic15");
//       }
//       if (plastic2 != 0) {
//         resultlist.add("Plastic 2L plastic bottels : $plastic2");
//       }
//       if (papersmall != 0) {
//         resultlist.add("Paper Small amount : $papersmall");
//       }
//       if (papermedium != 0) {
//         resultlist.add("Paper medium amount : $papermedium");
//       }
//       if (paperlarge != 0) {
//         resultlist.add("Paper large amout : $paperlarge");
//       }
//       if (mobilephone != 0) {
//         resultlist.add("Mobile phone : $mobilephone");
//       }
//       if (computerparts != 0) {
//         resultlist.add("Computer parts : $computerparts");
//       }
//       if (other != 0) {
//         resultlist.add("Other : $other");
//       }
//     } else {
//       // Handle the case when the start index is beyond the available documents
//       print('Page index out of bounds');
//     }

    // This commented code snipet is used before page pagination
    final document = await query.first;
    final arrayField = document['items'];

    for (String item in List<String>.from(arrayField)) {
      if (item.contains("plastic 100ml")) {
        count = int.parse(item.split(" ")[0]);
        plastic100 += count;
        // resultlist.add(item);
      }

      if (item.contains("plastic 250ml")) {
        count = int.parse(item.split(" ")[0]);
        plastic250 += count;
      }
      if (item.contains("plastic 500ml")) {
        count = int.parse(item.split(" ")[0]);
        plastic500 += count;
      }
      if (item.contains("plastic 750ml")) {
        count = int.parse(item.split(" ")[0]);
        plastic750 += count;
      }
      if (item.contains("plastic 1.5L")) {
        count = int.parse(item.split(" ")[0]);
        plastic15 += count;
      }
      if (item.contains("plastic 2L")) {
        count = int.parse(item.split(" ")[0]);
        plastic2 += count;
      }

      if (item.contains("glass 100ml")) {
        count = int.parse(item.split(" ")[0]);
        glass100 += count;
      }

      if (item.contains("paper small amount")) {
        papersmall += 1;
      }
      if (item.contains("paper medium amount")) {
        papermedium += 1;
      }
      if (item.contains("paper large amount")) {
        paperlarge += 1;
      }
      if (item.contains("Computer parts")) {
        computerparts += 1;
      }
      if (item.contains("Mobile phone")) {
        mobilephone += 1;
      }
      if (item.contains("Other")) {
        other += 1;
      }
    }
    if (plastic100 != 0) {
      resultlist.add("Plastic 100ml plastic bottels : $plastic100");
    }
    if (plastic250 != 0) {
      resultlist.add("Plastic 250ml plastic bottels : $plastic250");
    }
    if (plastic500 != 0) {
      resultlist.add("Plastic 500ml plastic bottels : $plastic500");
    }
    if (plastic750 != 0) {
      resultlist.add("Plastic 750ml plastic bottels : $plastic750");
    }
    if (plastic15 != 0) {
      resultlist.add("Plastic 1.5L plastic bottels : $plastic15");
    }
    if (plastic2 != 0) {
      resultlist.add("Plastic 2L plastic bottels : $plastic2");
    }
    if (papersmall != 0) {
      resultlist.add("Paper Small amount : $papersmall");
    }
    if (papermedium != 0) {
      resultlist.add("Paper medium amount : $papermedium");
    }
    if (paperlarge != 0) {
      resultlist.add("Paper large amout : $paperlarge");
    }
    if (mobilephone != 0) {
      resultlist.add("Mobile phone : $mobilephone");
    }
    if (computerparts != 0) {
      resultlist.add("Computer parts : $computerparts");
    }
    if (other != 0) {
      resultlist.add("Other : $other");
    }

    return List<dynamic>.from(resultlist);
  }
}
