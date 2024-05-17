import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/game/outdoor_game_model.dart';


class OutdoorGameServices {
  final gameCollection = FirebaseFirestore.instance.collection('outdoor_games');
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> create(BuildContext context, OutdoorGameModel model) async {
    try {
      await gameCollection.add(model.toJson()).then((value) => Navigator.of(context).popUntil((route) => route.isFirst));
    } catch (e) {
      throw Exception('Veri oluşturulurken hata oluştu: $e');
    }
  }

  Future<OutdoorGameModel> get(String id) async {
    try {
      DocumentSnapshot doc = await gameCollection.doc(id).get();
      return OutdoorGameModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Veri çekilirken hata oluştu: $e');
    }
  }

  Future<List<OutdoorGameModel>> getByOrganizerName(String organizerName) async {
    try {
      QuerySnapshot querySnapshot = await gameCollection.where('organizerName', isEqualTo: organizerName).get();
      List<OutdoorGameModel> games = [];
      querySnapshot.docs.forEach((doc) {
        games.add(OutdoorGameModel.fromJson(doc.data() as Map<String, dynamic>));
      });
      return games;
    } catch (e) {
      throw Exception('Veri çekilirken hata oluştu: $e');
    }
  }


  Future<List<OutdoorGameModel>> getAllGame() async {
    QuerySnapshot querySnapshot = await gameCollection.get();

    List<OutdoorGameModel> gameList = [];

    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot snapshot in querySnapshot.docs) {
        gameList.add(
          OutdoorGameModel.fromJson(
            snapshot.data() as Map<String, dynamic>,
          ),
        );
      }
    }

    return gameList;
  }
}
