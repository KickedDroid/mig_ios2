import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

Future<String> checkMachines() async {
  var box = Hive.box('myBox');
  var docs = await Firestore.instance
      .collection(box.get('companyId'))
      .orderBy('coolant-percent')
      .getDocuments();

  var docsL = await Firestore.instance
      .collection(box.get('companyId'))
      .orderBy('last-updated')
      .getDocuments();
  var doc = docs.documents.first;
  var lastDoc = docsL.documents.first;
  if (double.parse(doc.data['coolant-percent']) < 5) {
    return '${doc.data['name']} Needs Upating';
  } else {
    return '${lastDoc.data['name']} Needs Checking';
  }
}
