import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/game/game_model.dart';

class GameServices {
  final gameCollection = FirebaseFirestore.instance.collection("games");
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> create(BuildContext context, GameModel model) async {
    try {
      await gameCollection.add(model.toJson()).then((value) => Navigator.of(context).popUntil((route) => route.isFirst));
    } catch (e) {
      throw Exception('Veri oluşturulurken hata oluştu: $e');
    }
  }

  Future<GameModel> get(String id) async {
    try {
      DocumentSnapshot doc = await gameCollection.doc(id).get();
      return GameModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Veri çekilirken hata oluştu: $e');
    }
  }

  Future<List<GameModel>> getAllGame() async {
    QuerySnapshot querySnapshot = await gameCollection.get();

    List<GameModel> gameList = [];

    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot snapshot in querySnapshot.docs) {
        gameList.add(
          GameModel.fromJson(
            snapshot.data() as Map<String, dynamic>,
          ),
        );
      }
    }

    return gameList;
  }
}
