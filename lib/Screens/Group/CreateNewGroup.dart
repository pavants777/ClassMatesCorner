import 'package:classmatescorner/FirebaseFunction/function.dart';
import 'package:classmatescorner/Utils/AppName.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateNewGroup extends StatefulWidget {
  const CreateNewGroup({super.key});

  @override
  State<CreateNewGroup> createState() => _CreateNewGroupState();
}

class _CreateNewGroupState extends State<CreateNewGroup> {
  TextEditingController _groupName = TextEditingController();

  _createGroup() async {
    String user = FirebaseAuth.instance.currentUser!.uid;
    if (_groupName.text.isNotEmpty && user != null) {
      FirebaseFunction.createGroup(_groupName.text, [user]);
      _groupName.clear();
    } else {
      print('${user}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Create Group',
          style: TextStyle(
              fontSize: 25, letterSpacing: 3.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            AppName(),
            SizedBox(
              height: 30,
            ),
            Container(
                width: 300,
                child: TextField(
                  controller: _groupName,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    prefixIcon: Icon(Icons.group),
                    hintText: 'GroupName',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                _createGroup();
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                width: 100,
                child: Text(
                  ' Create ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ])),
    );
  }
}
