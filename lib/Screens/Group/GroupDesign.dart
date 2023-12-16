import 'package:classmatescorner/FirebaseFunction/function.dart';
import 'package:classmatescorner/Models/GroupModels.dart';
import 'package:classmatescorner/Screens/Group/ChatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupDesign extends StatefulWidget {
  final String groupuid;

  GroupDesign({Key? key, required this.groupuid}) : super(key: key);

  @override
  State<GroupDesign> createState() => _GroupDesignState();
}

class _GroupDesignState extends State<GroupDesign> {
  GroupModels? group;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
    getGroup();
  }

  void getGroup() async {
    GroupModels demogroup = await FirebaseFunction.getGroup(widget.groupuid);
    setState(() {
      group = demogroup;
    });
  }

  bool userIsInGroup() {
    List<String>? groupUserIds = group?.users?.map((user) => user).toList();
    return groupUserIds?.contains(currentUserId) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        if (userIsInGroup()) {
          Navigator.push(
              (context),
              MaterialPageRoute(
                  builder: (context) => ChatPage(groupId: widget.groupuid)));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Join the Group'),
                  content: Text("First Join The Group To Access The Content"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          joinGroup();
                          Navigator.pop(context);
                        },
                        child: Text('Join Group')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close')),
                  ],
                );
              });
        }
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.yellow,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5, top: 5, right: 5),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CircleAvatar(
                      maxRadius: screenWidth * 0.08,
                      backgroundColor: Colors.pink,
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.05),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${group?.groupName ?? ''}',
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 3.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        ' ${group?.users?.length ?? 0}+ Joined',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (userIsInGroup()) {
                      showMoreOptions();
                    } else {
                      joinGroup();
                    }
                  },
                  child: userIsInGroup()
                      ? const Text('Exit',
                          style:
                              TextStyle(color: Color.fromARGB(255, 0, 4, 255)))
                      : const Text('Join',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 30, 255))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showMoreOptions() {
    String userid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFunction.removeMember(widget.groupuid, userid);
    setState(() {
      group?.users?.remove(userid);
    });
  }

  void joinGroup() {
    String userid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFunction.addMembers(widget.groupuid, userid);
    setState(() {
      group?.users?.add(userid);
    });
  }
}
