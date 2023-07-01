// import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:parental_control/services/app_usage_local_service.dart';

class ChildModel {
  ChildModel({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.token,
    this.position,
    this.appsUsageModel,
  });

  final String name;
  final String email;
  final String? image;
  final String id;
  final GeoPoint? position;
  List? appsUsageModel = <AppUsageInfo>[];
  String? token;

  factory ChildModel.fromMap(Map<dynamic, dynamic> data, String documentId) {
    final String name = data['name'];
    final String? image = data['image'];
    final String email = data['email'];
    final String? token = data['token'];
    final List apps = data['appsUsageModel']  is List ? data['appsUsageModel']  : null;
    final GeoPoint? position = data['position'];

    return ChildModel(id: documentId, name: name, image: image, email: email, token: token, position: position, appsUsageModel: apps);
    //appsUsageModel: apps);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'position': position,
      'token': token,
      'appsUsageModel': appsList(appsUsageModel?.cast<AppUsageInfo>()),
      //'appsUsageModel': null,
    };
  }

  @override
  String toString() => 'id: $id , name: $name , latitude:${position?.latitude} , longitude:${position?.longitude} ';
}

List<Map<String, dynamic>> appsList(List<AppUsageInfo>? apps) {
  var appsMap = <Map<String, dynamic>>[];
  apps?.forEach((value) {
    appsMap.add(value.toMap());
  });
  return appsMap;
}

List<AppUsageInfo> _convertModel(List<dynamic> appsMod) {
  var apps = <AppUsageInfo>[];
  appsMod.forEach((value) {
    apps.add(AppUsageInfo.fromMap(value));
  });
  return apps;
}
