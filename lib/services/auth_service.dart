import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_proyecto_ft/presentation/widgets/login/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Registrar usuario con correo y contraseña
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'El correo ya está en uso.');
      } else {
        showToast(message: 'Ocurrió un error: ${e.code}');
      }
    }
    return null;
  }

  /// Iniciar sesión con correo y contraseña
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Correo o contraseña incorrectos.');
      } else {
        showToast(message: 'Ocurrió un error: ${e.code}');
      }
    }
    return null;
  }

  /// Iniciar sesión con Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) {
        // El usuario canceló el inicio de sesión
        showToast(message: 'Inicio de sesión con Google cancelado.');
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      showToast(message: 'Ocurrió un error: ${e.message}');
    } catch (e) {
      showToast(message: 'Error inesperado: $e');
    }
    return null;
  }

  /// Cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut(); // Cierra sesión también en Google
  }

  /// Obtener el usuario actual
  User? get currentUser => _auth.currentUser;
}