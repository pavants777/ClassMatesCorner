import 'package:classmatescorner/FirebaseFunction/function.dart';
import 'package:classmatescorner/Models/GroupModels.dart';
import 'package:flutter/material.dart';

class GroupDesign extends StatefulWidget {
  final String groupuid;

  GroupDesign({Key? key, required this.groupuid}) : super(key: key);

  @override
  State<GroupDesign> createState() => _GroupDesignState();
}

class _GroupDesignState extends State<GroupDesign> {
  GroupModels? group;

  @override
  void initState() {
    super.initState();
    getGroup();
  }

  void getGroup() async {
    GroupModels demogroup = await FirebaseFunction.getGroup(widget.groupuid);
    setState(() {
      group = demogroup;
      print(group);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {},
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
                          fontSize: 15,
                          color: const Color.fromARGB(255, 43, 55, 43),
                        ),
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
