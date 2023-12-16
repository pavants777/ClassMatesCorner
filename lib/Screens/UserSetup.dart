import 'dart:io';
import 'package:classmatescorner/FirebaseFunction/PickImage.dart';
import 'package:classmatescorner/FirebaseFunction/function.dart';
import 'package:classmatescorner/FirebaseFunction/store_in_firebase.dart';
import 'package:classmatescorner/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Utils/Constant.dart';

class UserSetUP extends StatefulWidget {
  const UserSetUP({Key? key}) : super(key: key);

  @override
  State<UserSetUP> createState() => _UserSetUPState();
}

class _UserSetUPState extends State<UserSetUP> {
  TextEditingController _collegeName = TextEditingController();
  TextEditingController _branch = TextEditingController();
  File? image;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> selectImage() async {
    File? _image = await PickImage.pickImageFromGallery(context);
    setState(() {
      image = _image;
    });
  }

  setUserSetUp() async {
    String profileUrl =
        await Store.storeFileToFirebase('profilePhoto$uid', image);
    FirebaseFunction.UpdateUserInfo(
        uid, profileUrl, _collegeName.text, _branch.text);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('User SetUp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: image != null
                        ? FileImage(image!) as ImageProvider<Object>?
                        : NetworkImage(Constant.image),
                    radius: size * 0.25,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 150,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Container(
                width: 300,
                child: TextField(
                  controller: _collegeName,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    prefixIcon: Icon(Icons.school),
                    hintText: 'College Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: 300,
                child: TextField(
                  controller: _branch,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    prefixIcon: Icon(Icons.book),
                    hintText: 'Branch',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  setUserSetUp();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  width: 150,
                  child: Text(
                    'Let\'s Start',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
