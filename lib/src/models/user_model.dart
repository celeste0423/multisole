class UserModel {
  final String? uid;
  final String? name;
  final String? contact;
  final String? email;
  final int? height;
  final int? weight;
  final String? description;
  final String? body;
  final String? addition;
  final bool? isSubmit;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.uid,
    this.name,
    this.contact,
    this.email,
    this.height,
    this.weight,
    this.description,
    this.body,
    this.addition,
    this.isSubmit,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] == null ? null : json['uid'] as String,
      name: json['name'] == null ? null : json['name'] as String,
      contact: json['contact'] == null ? null : json['contact'] as String,
      email: json['email'] == null ? null : json['email'] as String,
      height: json['height'] == null ? null : json['height'] as int,
      weight: json['weight'] == null ? null : json['weight'] as int,
      description:
          json['description'] == null ? null : json['description'] as String,
      body: json['body'] == null ? null : json['body'] as String,
      addition: json['addition'] == null ? null : json['addition'] as String,
      isSubmit: json['isSubmit'] == null ? null : json['isTimer'] as bool,
      createdAt: json['createdAt'] == null ? null : json["createdAt"].toDate(),
      updatedAt: json['updatedAt'] == null ? null : json["updatedAt"].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'height': height,
      'weight': weight,
      'description': description,
      'body': body,
      'addition': addition,
      'isSubmit': isSubmit,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    int? height,
    int? weight,
    String? description,
    String? body,
    String? addition,
    bool? isSubmit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      description: description ?? this.description,
      body: body ?? this.body,
      addition: addition ?? this.addition,
      isSubmit: isSubmit ?? this.isSubmit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
