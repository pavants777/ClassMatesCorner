class UserInfo {
  String profilePhoto;
  String collegeName;
  String branch;

  UserInfo(
      {required this.profilePhoto,
      required this.collegeName,
      required this.branch});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        profilePhoto: json['profilePhoto'],
        collegeName: json['collegeName'],
        branch: json['branch']);
  }
  Map<String, dynamic> toJson() {
    return {
      'profilePhoto': profilePhoto,
      'collegeName': collegeName,
      'branch': branch,
    };
  }
}
