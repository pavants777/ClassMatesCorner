import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  AppName({this.logofontSize, this.textfontSize});
  double? logofontSize;
  double? textfontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'ClassMates',
            style: TextStyle(
                fontSize: logofontSize ?? 25,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Corner',
            style: TextStyle(
                fontSize: logofontSize ?? 25,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '**************',
            style: TextStyle(
                fontSize: textfontSize ?? 10,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
