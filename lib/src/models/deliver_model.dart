import 'package:cloud_firestore/cloud_firestore.dart';

class DeliverModel {
  final String? footId;
  final String? uid;
  final String? name;
  final String? contact;
  final int? postCode;
  final String? address;
  final String? additionAddress;
  final String? request;
  final bool? isCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DeliverModel({
    this.footId,
    this.uid,
    this.name,
    this.contact,
    this.postCode,
    this.address,
    this.additionAddress,
    this.request,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliverModel.fromJson(Map<String, dynamic> json) {
    return DeliverModel(
      footId: json['footId'] == null ? null : json['footId'] as String,
      uid: json['uid'] == null ? null : json['uid'] as String,
      name: json['name'] == null ? null : json['name'] as String,
      contact: json['contact'] == null ? null : json['contact'] as String,
      postCode: json['postCode'] == null ? null : json['postCode'] as int,
      address: json['address'] == null ? null : json['address'] as String,
      additionAddress: json['additionAddress'] == null
          ? null
          : json['additionAddress'] as String,
      request: json['request'] == null ? null : json['request'] as String,
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
      'postCode': postCode,
      'address': address,
      'additionAddress': additionAddress,
      'request': request,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  DeliverModel copyWith({
    String? footId,
    String? uid,
    String? name,
    String? contact,
    int? postCode,
    String? address,
    String? additionAddress,
    String? request,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DeliverModel(
      footId: footId ?? this.footId,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      postCode: postCode ?? this.postCode,
      address: address ?? this.address,
      additionAddress: additionAddress ?? this.additionAddress,
      request: request ?? this.request,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
