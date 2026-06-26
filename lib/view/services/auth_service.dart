// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> loginComEmailESenha(String email, String senha) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: senha.trim(),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        throw 'E-mail ou senha incorretos.';
      } else if (e.code == 'invalid-email') {
        throw 'Formato de e-mail inválido.';
      }
      throw 'Ocorreu um erro ao entrar. Tente novamente.';
    }
  }

  Future<User?> cadastrarComEmailESenha(
    String email,
    String senha,
    String nome,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: senha.trim(),
          );

      await userCredential.user?.updateDisplayName(nome.trim());

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'A senha digitada é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        throw 'Este e-mail já está cadastrado em outra conta.';
      }
      throw 'Erro ao criar conta. Tente novamente.';
    }
  }

  Future<void> deslogar() async {
    await _auth.signOut();
  }
}
