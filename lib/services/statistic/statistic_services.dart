import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/statistic/statistic_model.dart';

class StatisticServices {
  final gameCollection = FirebaseFirestore.instance.collection('statistics');
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> createStatistic(BuildContext context, StatisticModel model) async {
    try {
      await gameCollection.add(model.toJson()).then((value) => Navigator.of(context).pop());
    } catch (e) {
      throw Exception('Veri oluşturulurken hata oluştu: $e');
    }
  }

  Future<List<StatisticModel>> getAllStatistic() async {
    QuerySnapshot querySnapshot = await gameCollection.get();

    List<StatisticModel> statisticList = [];

    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot snapshot in querySnapshot.docs) {
        statisticList.add(
          StatisticModel.fromJson(
            snapshot.data() as Map<String, dynamic>,
          ),
        );
      }
    }

    return statisticList;
  }

  Future<List<StatisticModel>> getStatisticByUserName(String userName) async {
  QuerySnapshot querySnapshot = await gameCollection.where('userName', isEqualTo: userName).get();

  List<StatisticModel> userData = [];

  if (querySnapshot.docs.isNotEmpty) {
    for (DocumentSnapshot snapshot in querySnapshot.docs) {
      userData.add(
        StatisticModel.fromJson(
          snapshot.data() as Map<String, dynamic>,
        ),
      );
    }
  }

  return userData;
}
}
