class GroupModels {
  String groupId;
  String groupName;
  List<String> users;

  GroupModels(
      {required this.groupId, required this.groupName, required this.users});

  factory GroupModels.fromJson(Map<String, dynamic> json) {
    return GroupModels(
      groupId: json['groupId'] ?? '',
      groupName: json['groupName'] ?? '',
      users: (json['users'] as List<dynamic>?)
              ?.map((user) => user.toString())
              .toList() ??
          [],
    );
  }
}
