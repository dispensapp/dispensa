import 'package:dispensa/provider/user_setup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();

class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  // popu google user account select
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credentials);

    final user = FirebaseAuth.instance.currentUser;

    userSetup(user!.displayName!);
    notifyListeners();
  }
}

Future logout() async {
  await googleSignIn.disconnect();
  FirebaseAuth.instance.signOut();
}
