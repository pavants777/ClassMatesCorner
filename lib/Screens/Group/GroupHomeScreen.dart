import 'package:classmatescorner/FirebaseFunction/groupfunction.dart';
import 'package:classmatescorner/Models/GroupModels.dart';
import 'package:classmatescorner/Screens/Group/CreateNewGroup.dart';
import 'package:classmatescorner/Screens/Group/GroupDesign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupHome extends StatefulWidget {
  const GroupHome({Key? key}) : super(key: key);

  @override
  State<GroupHome> createState() => _GroupHomeState();
}

class _GroupHomeState extends State<GroupHome> {
  TextEditingController _searchController = TextEditingController();
  List<GroupModels> allGroups = [];
  List<GroupModels> displayedGroups = [];

  @override
  void initState() {
    super.initState();
    getAllGroups();
  }

  Future<void> getAllGroups() async {
    final groups = await SearchFunction.getAllGroups();

    setState(() {
      allGroups = groups;
      displayedGroups = allGroups;
    });
  }

  void updateDisplayedGroups(String searchValue) {
    setState(() {
      displayedGroups = allGroups
          .where((group) =>
              group.groupName.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GroupChats',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateNewGroup()),
                    );
                  },
                  value: '1',
                  child: Row(
                    children: const [
                      Icon(Icons.add),
                      SizedBox(width: 10),
                      Text('Create New Group'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  },
                  value: '2',
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text('Exit'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.shade100,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: updateDisplayedGroups,
                enableSuggestions: false,
                style: const TextStyle(color: Colors.black, fontSize: 15),
                decoration: const InputDecoration(
                  hintText: 'Search Group......',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  contentPadding: EdgeInsets.all(16),
                  filled: true,
                  fillColor: Colors.transparent,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: displayedGroups.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: displayedGroups.length,
                    itemBuilder: (context, index) {
                      return GroupDesign(
                          groupuid: displayedGroups[index].groupId);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
