import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/client_model.dart';

class ClientManager with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> _clientsCollection =
      _firebaseFirestore.collection('users');

  String _message = '';
  bool _isLoading = false;
  String get message => _message;
  bool get isLoading => _isLoading;

  setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  setIsLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  //client's info
  Future<Client?> getClientInfo(String userUid) async {
    Client? clientData;
    await _clientsCollection.doc(userUid).get().then((doc) {
      if (doc.exists) {
        //clientData = doc.data() as Client?;
        clientData = Client.fromDocumantSnaphot(doc);
      } else {
        clientData = null;
      }
    });
    return clientData;
  }
}