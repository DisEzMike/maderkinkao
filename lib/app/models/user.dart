// ignore_for_file: must_be_immutable

import 'package:meta/meta.dart';

@immutable
class User {
  String? id;
  String? email;
  String? photoUrl;
  String? displayName;
  List? role;

  User({
    this.id,
    this.email,
    this.photoUrl,
    this.displayName,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    displayName = json['displayName'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['displayName'] = displayName;
    return data;
  }
}
