import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/helpers/storagemanager.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/models/user.dart' as usr;

final usersRef = FirebaseFirestore.instance.collection('users').withConverter<usr.User>(  // =========== create Users table in Firestore ===========

fromFirestore: (snapshot, _) => usr.User.fromJson(snapshot.data()!),
  toFirestore: (user, _) => user.toJson(),
);
final FirebaseAuth _auth = FirebaseAuth.instance;

class UserProvider extends ChangeNotifier {
  bool isAuth = false;
  usr.User? currentUser;

  setUser(usr.User? user) {
    currentUser = user?? null;
    notifyListeners();
  }
  isUserAuth(bool val) {
    isAuth = val;
     notifyListeners();
    isAuth;
  }

  Future <void> checkIfUserAuth()async {
    String? res = await StorageManager.readData('userId');
    isAuth = res == null ? false : true;
    notifyListeners();
    getUserById(res);

  }
  // =========== reset User password ===========
  Future<bool?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    return true;

    } catch (e) {
      print(e);
      return false;
    }
  }

  Future <void> getUserById(String? id) async  {
    if(id != null){
      var user = await usersRef.doc(id).get().then((snapshot) => snapshot.data()!);
      currentUser = user;
      notifyListeners();
    }

  }
  Future <void> editUserFavoriteOffers( OfferDetailDto offer, bool add) async  {
    if(add == true){
      currentUser!.yourFavoritesOffers!.add(offer);
    }else{
      currentUser!.yourFavoritesOffers!.removeWhere((element) => element.hashId == offer.hashId);
    }
    await updateUser(currentUser!);
    //  getAllUsers();
  }
  Future <void>updateUser(usr.User user ) async  {
    usersRef.doc(user.id)
        .set(user);
  }
  // ===========  User Login ===========

  Future<String?> userLogin(String email, String password, BuildContext context) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email,
              password: password); // authenticate user with password and email
      if (userCredential.user?.uid != null) {
        if (userCredential.user?.emailVerified == false) {
          return 'user-not-verified';
        } else {
          // only save in shared preferences if user has been verified
          StorageManager.saveData('userId', userCredential.user!.uid);
        }
        await getUserById(userCredential.user!.uid);
        return '';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return S.of(context).userNotfound;
      } else if (e.code == 'wrong-password') {
        return S.of(context).passwordInvalid;
      }else{
        return S.of(context).checkYourData;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  // ===========  add User To Users´s Table in Database ===========

  createUser(usr.User user) {
    usersRef.doc(user.id)
        .set(user);
  }
  // =========== Register User ===========

  Future<String?> registerUser(displayName, email,
  password, BuildContext context) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        await addUserToFirestore(displayName, email, userCredential.user!.uid);
        await userCredential.user?.sendEmailVerification();
        return '';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return S.of(context).min6Passw;
      } else if (e.code == 'email-already-in-use') {
        return S.of(context).emailTaken;
      }else{
        return S.of(context).checkYourData;

      }
    } catch (e) {
     throw Exception(e);
    }
  }
  Future <void> addUserToFirestore(String displayName, String email, String id)async {
    var user = usr.User(
      address: '',
      bio: '',
      dateOfBirth: '',
      valid: false,
      photoUrl: '',
      email: email,
      displayName: displayName,
      notificationToken: "",
      id: id,
      yourResume: "",
      tags: [],
      yourFavoritesOffers: [],
      offersYouAppliedTo: [],
    );
    usersRef.doc(user.id)
        .set(user);
  }

}
