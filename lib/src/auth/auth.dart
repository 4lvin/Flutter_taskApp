import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<FirebaseUser> getSignedInAccount() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user != null ? user : null;
}

Future<void> signOutAccount() async {
  await FirebaseAuth.instance.signOut();
}

Future<FirebaseUser> signIntoFirebase(
    GoogleSignInAccount googleSignInAccount) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
  return await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
}
