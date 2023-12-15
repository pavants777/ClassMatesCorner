import 'package:classmatescorner/Models/GroupModels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchFunction {
  static Future<List<GroupModels>> getAllGroups() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('groups').get();

    List<GroupModels> groups = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return GroupModels.fromJson(data);
    }).toList();

    return groups;
  }
}
