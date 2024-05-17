import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/user/user_model.dart';
import '../../router/routes.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;
  final String baseImageUrl = "https://firebasestorage.googleapis.com/v0/b/orienteering-firebase.appspot.com/o/images%2F1710539522954?alt=media&token=73b6ccce-47a9-4bbb-9c54-d08f0b4b52a8";

  Future<void> signUp(BuildContext context, {required String name, required String email, required String password}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null )  {
        await _registerUser(name: name, email: email, password: password);
        navigator.pushNamedAndRemoveUntil(Routes.mainHome, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> signIn(BuildContext context, {required String email, required String password}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        navigator.pushNamedAndRemoveUntil(Routes.mainHome, (route) => false);
      }
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await firebaseAuth.signOut().then((value) => Navigator.of(context).pushNamedAndRemoveUntil(Routes.welcome, (route) => false));
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> _registerUser({required String name, required String email, required String password}) async {
    await userCollection.doc().set({
      "email" : email,
      "name": name,
      "password": password,
      "image": baseImageUrl
    });
  }

  Future<UserModel?> getUserByEmail(String email) async {
    QuerySnapshot querySnapshot = await userCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot snapshot = querySnapshot.docs.first;
      return UserModel(documentId: snapshot.id, name: snapshot['name'], email: snapshot['email'], password: snapshot['password'], image: snapshot['image']);
    } else {
      return null;
    }
  }

  Future<void> updateUser({required String documentId, String? password, String? image}) async {
    try {
      Map<String, dynamic> userData = {};

      if (password != null) {
        userData['password'] = password;
      }
      if (image != null) {
        userData['image'] = image;
      }

      await userCollection.doc(documentId).update(userData);
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> deleteImageFromFirebase(String imageUrl) async {
    try {
      if(imageUrl != baseImageUrl){
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl);
        await ref.delete();
      }
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images')
          .child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
      firebase_storage.TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
      return '';
    }
  }
}