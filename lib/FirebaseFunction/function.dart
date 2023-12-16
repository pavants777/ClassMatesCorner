import 'dart:convert';
import '../Models/UserInfo.dart' as UserData;
import 'package:classmatescorner/Models/GroupModels.dart';
import 'package:classmatescorner/Models/MessageModels.dart';
import 'package:classmatescorner/Models/UserModels.dart';
import 'package:classmatescorner/Screens/HomePage.dart';
import 'package:classmatescorner/Screens/UserSetup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          context, MaterialPageRoute(builder: (context) => UserSetUP()));
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

  static Future<void> addMembers(String groupid, userid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> groupDoc = await FirebaseFirestore
          .instance
          .collection('groups')
          .doc(groupid)
          .get();

      if (groupDoc.exists) {
        String newMemberId = userid;

        List<dynamic> currentMembers = groupDoc.data()?['users'] ?? [];
        if (!currentMembers.contains(newMemberId)) {
          currentMembers.add(newMemberId);

          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupid)
              .update({'users': currentMembers});
        } else {
          print('Member is already in the group.');
        }
      } else {
        print('Group not found.');
      }
    } catch (e) {
      print('Error adding member to group: $e');
    }
  }

  static Future<void> removeMember(String groupUid, String userId) async {
    try {
      DocumentReference groupRef =
          FirebaseFirestore.instance.collection('groups').doc(groupUid);
      await groupRef.update({
        'users': FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      print('Error removing member: $e');
    }
  }

  static Future<void> sendMessagetoGroup(String groupId, message) async {
    String senderId = await FirebaseAuth.instance.currentUser!.uid;

    final Timestamp timestamp = Timestamp.now();

    Message newMessage =
        Message(message: message, senderId: senderId, timestamp: timestamp);

    await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .add(newMessage.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessageFromGroup(
      String groupId) {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  static Future<UserModels?> getCurrentUser(String users) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('uid', isEqualTo: users)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return UserModels.fromJson(snapshot.docs.first.data());
    } else {
      return null;
    }
  }

  static void UpdateUserInfo(
      String uid, profileUrl, collegeName, branch) async {
    UserData.UserInfo user = UserData.UserInfo(
        profilePhoto: profileUrl, collegeName: collegeName, branch: branch);

    Map<String, dynamic> data = user.toJson();

    await FirebaseFirestore.instance.collection('UserInfo').doc(uid).set(data);
  }
}
