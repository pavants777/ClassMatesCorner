import 'dart:convert';

import 'package:classmatescorner/Models/GroupModels.dart';
import 'package:classmatescorner/Screens/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseFunction {
  static logIn(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (error) {
      final snackBar = SnackBar(content: Text('${error.toString()}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static void signIn(String email, String password, String username,
      BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'userName': username,
        'email': email,
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (error) {
      final snackBar = SnackBar(content: Text('${error.toString()}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static Future<void> createGroup(
      String groupName, List<String> usersIds) async {
    try {
      CollectionReference groups =
          FirebaseFirestore.instance.collection('groups');

      String groupId = groups.doc().id;

      Map<String, dynamic> groupData = {
        'groupId': groupId,
        'groupName': groupName,
        'users': usersIds,
      };

      await groups.doc(groupId).set(groupData);
      print('Group created successfully!');
    } catch (e) {
      print('Error creating group: $e');
    }
  }

  static Future<GroupModels> getGroup(String groupId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('groups')
        .doc(groupId)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();

      if (data != null) {
        dynamic usersData = data['users'];

        List<String> usersList;

        if (usersData is List) {
          usersList = List<String>.from(usersData);
        } else if (usersData is String) {
          usersList = (json.decode(usersData) as List<dynamic>).cast<String>();
        } else {
          throw Exception("Unexpected type for 'users' field");
        }

        return GroupModels(
          groupId: data['groupId'] ?? '',
          groupName: data['groupName'] ?? '',
          users: usersList,
        );
      } else {
        throw Exception("Data is null for group with id $groupId");
      }
    } else {
      throw Exception("Group with id $groupId does not exist");
    }
  }
}
