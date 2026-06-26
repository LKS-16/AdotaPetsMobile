import 'package:firebase_auth/firebase_auth.dart';

class AuthUserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get usuarioAtual => _auth.currentUser;

  Future<void> deslogar() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Erro ao deslogar: $e");
      rethrow;
    }
  }
}
