import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinteratori/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinteratori/screen/service/database.dart';

class AuthService{ 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<User> get user {
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    final snapShot = await Firestore.instance.collection('user').document(user.uid).get();

    if(snapShot == null || !snapShot.exists){
      await DatabaseService(uid: user.uid).updateUserData(googleSignInAccount.email, user.uid);
    }

    return _userFromFirebaseUser(user);
  }

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Future signOutGoogle() async{
    await googleSignIn.signOut();
    await _auth.signOut();

    print("User Sign Out");
  }
}