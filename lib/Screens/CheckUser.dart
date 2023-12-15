import 'package:classmatescorner/Screens/HomePage.dart';
import 'package:classmatescorner/Screens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _checkUserState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot!.data == true) {
            return HomePage();
          } else
            return LoginPage();
        },
      ),
    );
  }

  Future<bool> _checkUserState() async {
    User? user = await FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
