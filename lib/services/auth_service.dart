import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      // Déclencher le flux de connexion Facebook
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Vérifier le statut de la connexion
      if (loginResult.status == LoginStatus.success) {
        // Obtenir les informations de l'utilisateur
        final userData = await FacebookAuth.instance.getUserData();

        // Obtenir le token d'accès
        final accessToken = loginResult.accessToken;

        // Vérifier si le token d'accès est disponible
        if (accessToken == null) {
          print('Facebook access token is null');
          return null;
        }

        // Créer un credential Firebase avec le token Facebook
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        // Connecter l'utilisateur à Firebase avec le credential
        final UserCredential userCredential =
            await _auth.signInWithCredential(facebookAuthCredential);

        return userCredential.user;
      } else {
        print('Facebook login failed with status: ${loginResult.status}');
        return null;
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
      return null;
    }
  }
}
