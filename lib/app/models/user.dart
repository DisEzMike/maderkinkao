// ignore_for_file: must_be_immutable

import 'package:meta/meta.dart';

@immutable
class User {
  String? uid;
  String? email;
  String? photoUrl;
  String? displayName;
  String? role;

  User({
    this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    displayName = json['displayName'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['displayName'] = displayName;
    return data;
  }
}
