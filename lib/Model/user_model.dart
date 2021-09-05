import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel{
  final String fullname;
  final String password;
  final String emailAddress;
  final String userUid;

  UserModel({
    required this.password,
    required this.emailAddress,
    required this.fullname,
    required this.userUid
});

  factory UserModel.fromDocument(DocumentSnapshot doc){
    return UserModel(
        password: doc['password'],
        emailAddress: doc['emailAddress'],
        fullname: doc['Fullname'],
        userUid: doc['userUid']
    );
  }
}