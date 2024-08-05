class UserModel {
  final String? uid;
  final String? nickname;
  final String? email;
  final bool? isSubmit;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.uid,
    this.nickname,
    this.email,
    this.isSubmit,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] == null ? null : json['uid'] as String,
      nickname: json['nickname'] == null ? null : json['nickname'] as String,
      email: json['email'] == null ? null : json['email'] as String,
      isSubmit: json['isSubmit'] == null ? null : json['isTimer'] as bool,
      createdAt: json['createdAt'] == null ? null : json["createdAt"].toDate(),
      updatedAt: json['updatedAt'] == null ? null : json["updatedAt"].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nickname': nickname,
      'email': email,
      'isSubmit': isSubmit,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  UserModel copyWith({
    String? uid,
    String? nickname,
    String? email,
    bool? isSubmit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      isSubmit: isSubmit ?? this.isSubmit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
