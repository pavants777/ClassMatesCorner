import 'package:classmatescorner/Screens/CheckUser.dart';
import 'package:classmatescorner/Utils/AppName.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    void navigatonChange() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CheckUser()));
    }

    Future.delayed(const Duration(seconds: 5), navigatonChange);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        children: [
          AppName(
            logofontSize: 50,
            textfontSize: 15,
          ),
        ],
      ),
    );
  }
}
