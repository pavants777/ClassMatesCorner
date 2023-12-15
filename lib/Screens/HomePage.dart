import 'package:flutter/material.dart';
import '../Screens/Group/GroupHomeScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _index = 0;
  Widget page = GroupHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups'),
          BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room), label: 'Meeting'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account')
        ],
        currentIndex: _index,
        onTap: (int tappedIndex) {
          setState(() {
            _index = tappedIndex;
          });
          switch (_index) {
            case 0:
              setState(() {
                page = GroupHome();
              });
              break;
            case 1:
              setState(() {
                // page = GroupHomeScreen();
              });
              break;
            case 2:
              setState(() {
                // page = Account();
              });
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
