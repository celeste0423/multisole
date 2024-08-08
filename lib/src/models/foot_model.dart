import 'package:cloud_firestore/cloud_firestore.dart';

class FootModel {
  final String? footId;
  final String? uid;
  final String? name;
  final String? contact;
  final String? email;
  final int? height;
  final int? weight;
  final String? description;
  final int? body;
  final String? addition;
  final String? frontImgUrl;
  final String? sideImgUrl;
  final String? fileUrl;
  final bool? isCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FootModel({
    this.footId,
    this.uid,
    this.name,
    this.contact,
    this.email,
    this.height,
    this.weight,
    this.description,
    this.body,
    this.addition,
    this.frontImgUrl,
    this.sideImgUrl,
    this.fileUrl,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  factory FootModel.fromJson(Map<String, dynamic> json) {
    return FootModel(
      footId: json['footId'] == null ? null : json['footId'] as String,
      uid: json['uid'] == null ? null : json['uid'] as String,
      name: json['name'] == null ? null : json['name'] as String,
      contact: json['contact'] == null ? null : json['contact'] as String,
      email: json['email'] == null ? null : json['email'] as String,
      height: json['height'] == null ? null : json['height'] as int,
      weight: json['weight'] == null ? null : json['weight'] as int,
      description:
          json['description'] == null ? null : json['description'] as String,
      body: json['body'] == null ? null : json['body'] as int,
      addition: json['addition'] == null ? null : json['addition'] as String,
      frontImgUrl:
          json['frontImgUrl'] == null ? null : json['frontImgUrl'] as String,
      sideImgUrl:
          json['sideImgUrl'] == null ? null : json['sideImgUrl'] as String,
      fileUrl: json['fileUrl'] == null ? null : json['fileUrl'] as String,
      isCompleted:
          json['isCompleted'] == null ? null : json['isCompleted'] as bool,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: json['updatedAt'] is Timestamp
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'footId': footId,
      'uid': uid,
      'name': name,
      'contact': contact,
      'email': email,
      'height': height,
      'weight': weight,
      'description': description,
      'body': body,
      'addition': addition,
      'frontImgUrl': frontImgUrl,
      'sideImgUrl': sideImgUrl,
      'fileUrl': fileUrl,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  FootModel copyWith({
    String? footId,
    String? uid,
    String? name,
    String? contact,
    String? email,
    int? height,
    int? weight,
    String? description,
    int? body,
    String? addition,
    String? frontImgUrl,
    String? sideImgUrl,
    String? fileUrl,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FootModel(
      footId: footId ?? this.footId,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      description: description ?? this.description,
      body: body ?? this.body,
      addition: addition ?? this.addition,
      frontImgUrl: frontImgUrl ?? this.frontImgUrl,
      sideImgUrl: sideImgUrl ?? this.sideImgUrl,
      fileUrl: fileUrl ?? this.fileUrl,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
