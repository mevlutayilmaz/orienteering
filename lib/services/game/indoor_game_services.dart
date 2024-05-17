import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/game/indoor_game_model.dart';


class IndoorGameServices {
  final gameCollection = FirebaseFirestore.instance.collection('indoor_games');
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> create(BuildContext context, IndoorGameModel model) async {
    try {
      await gameCollection.add(model.toJson()).then((value) => Navigator.of(context).popUntil((route) => route.isFirst));
    } catch (e) {
      throw Exception('Veri oluşturulurken hata oluştu: $e');
    }
  }

  Future<IndoorGameModel> get(String id) async {
    try {
      DocumentSnapshot doc = await gameCollection.doc(id).get();
      return IndoorGameModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Veri çekilirken hata oluştu: $e');
    }
  }

  Future<List<IndoorGameModel>> getByOrganizerName(String organizerName) async {
    try {
      QuerySnapshot querySnapshot = await gameCollection.where('organizerName', isEqualTo: organizerName).get();
      List<IndoorGameModel> games = [];
      querySnapshot.docs.forEach((doc) {
        games.add(IndoorGameModel.fromJson(doc.data() as Map<String, dynamic>));
      });
      return games;
    } catch (e) {
      throw Exception('Veri çekilirken hata oluştu: $e');
    }
  }



  Future<List<IndoorGameModel>> getAllGame() async {
    QuerySnapshot querySnapshot = await gameCollection.get();

    List<IndoorGameModel> gameList = [];

    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot snapshot in querySnapshot.docs) {
        gameList.add(
          IndoorGameModel.fromJson(
            snapshot.data() as Map<String, dynamic>,
          ),
        );
      }
    }

    return gameList;
  }
}
