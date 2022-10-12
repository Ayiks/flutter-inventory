import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_1/models/client_model.dart';
import 'package:inventory_1/services/file_uploads_services.dart';

class AuthManager with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  final FileUploadService _fileUploadService = FileUploadService();

  CollectionReference userCollection = _firebaseFirestore.collection('users');

  String _message = '';
  bool _isloading = false;

  String get message => _message;
  bool get isLoading => _isloading;

  setMesage(String message) {
    _message = message;
    notifyListeners();
  }

  setIsLoading(bool isLoading) {
    _isloading = isLoading;
    notifyListeners();
  }

  Future<bool> ceateNewUser(
      {required Client client, required String password}) async {
    setIsLoading(true);
    bool isCreated = false;
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: client.email, password: password)
        .then((userCredential) async {
      // String? profileImage = await _fileUploadService.uploadFile(file: client.profilePicture, uid: uid)
      userCollection.doc(userCredential.user!.uid).set({
        "name": client.name,
        "email": client.email,
        "phonenumber": client.phone,
        "role": client.role,
        "user_id": userCredential.user!.uid,
        "company": client.company
      });
      isCreated = true;
    }).catchError((onError) {
      setMesage('Failed: $onError');
      isCreated = false;
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      setMesage("Please check your internet connection");
      isCreated = false;
      setIsLoading(false);
    });
    return isCreated;
  }

  Future<bool> loginUser(
      {required String email, required String password}) async {
    bool isSuccessful = false;
    setIsLoading(true);
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      if (userCredential.user != null) {
        isSuccessful = true;
      } else {
        isSuccessful = false;
      }
    }).catchError((onError) {
      setMesage('$onError');
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      setMesage('Please check your connection');
      isSuccessful = false;
      setIsLoading(false);
    });
    return isSuccessful;
  }
}
