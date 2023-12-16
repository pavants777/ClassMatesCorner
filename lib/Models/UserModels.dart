class UserModels {
  final String name;
  final String email;
  final String uid;

  UserModels({required this.name, required this.email, required this.uid});

  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      name: json['userName'] ?? 'UNKOWN',
      email: json['email'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
    };
  }
}
