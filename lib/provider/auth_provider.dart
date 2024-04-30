import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AuthProviderApp extends ChangeNotifier {
  late String Uid;
  final _auth = FirebaseAuth.instance;
  var isLoading = false;
  bool saving = false;
  late String? userName = _auth.currentUser?.displayName;
  late String? userEmail = _auth.currentUser?.email;
  late String? userPhone = _auth.currentUser?.phoneNumber;
  var storageReference = FirebaseStorage.instance.ref();
  late String? imageProfileUrl = _auth.currentUser?.photoURL; //image profile url
  bool isAdmin = false;

  //output: getting data from firebase and updating isAdmin
  Future<void> fetchUserData(context) async {
    try {
      await FirebaseFirestore.instance.collection('users').get().then(
        (QuerySnapshot value) {
          value.docs.forEach(
            (result) {
              if (result.id == _auth.currentUser?.uid) {
                isAdmin = result["admin"];
              }
            },
          );
        },
      );
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  //input: email, password, username, isLogin ,ctx
  //output: creating/login to your account
  void submitAuthForm(
    String email,
    String password,
    String username,
    bool admin,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      isLoading = true;
      notifyListeners();
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        userName = authResult.user?.displayName;
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({'username': username, 'email': email, 'admin': admin});
        authResult.user?.updateDisplayName(username);
        userName = username;
        isAdmin = admin;
      }
    } on PlatformException catch (err) {
      String? message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message!),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      isLoading = false;
      notifyListeners();
    } catch (err) {
      print(err);
      isLoading = false;
      notifyListeners();
    }
  }

  //output: uploading image to firebase
  void uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    var image;
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } on PlatformException catch (e) {
      return;
    }

    Reference reference = storage.ref().child("profileImages/${_auth.currentUser?.uid}");

    UploadTask uploadTask = reference.putFile(image);

    uploadTask.then((res) => imageProfileUrl = res.ref.getDownloadURL() as String?);
    _auth.currentUser?.updatePhotoURL(imageProfileUrl);
  }
}
