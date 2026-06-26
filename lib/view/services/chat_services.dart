import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String obterChatId({required String donoEmail, required String petNome}) {
    final usuarioLogado = _auth.currentUser;
    if (usuarioLogado == null) return '';

    final String adotanteEmail = usuarioLogado.email ?? 'anonimo';
    final String idLimpo = "${adotanteEmail}_${donoEmail}_$petNome"
        .replaceAll('@', '_')
        .replaceAll('.', '_');
    return idLimpo;
  }

  Future<void> criarConversaSeNaoExistir({
    required String chatId,
    required String donoNome,
    required String donoEmail,
    required String petNome,
    required String petImageUrl,
  }) async {
    final usuarioLogado = _auth.currentUser;
    if (usuarioLogado == null) return;

    final chatRef = _firestore.collection('chats').doc(chatId);
    final doc = await chatRef.get();

    if (!doc.exists) {
      await chatRef.set({
        'chatId': chatId,
        'adotanteId': usuarioLogado.uid,
        'adotanteNome': usuarioLogado.displayName ?? 'Usuário',
        'adotanteEmail': usuarioLogado.email,
        'donoNome': donoNome,
        'donoEmail': donoEmail,
        'petNome': petNome,
        'petImageUrl': petImageUrl,
        'ultimaMensagem': 'Interesse em adotar $petNome',
        'atualizadoEm': FieldValue.serverTimestamp(),
        'emailsEnvolvidos': [usuarioLogado.email, donoEmail],
      });
    }
  }

  Future<void> enviarMensagem({
    required String chatId,
    required String texto,
    String? imagemUrl,
    required String tipo,
  }) async {
    final usuarioLogado = _auth.currentUser;
    if (usuarioLogado == null || chatId.isEmpty) return;

    final agora = FieldValue.serverTimestamp();

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('mensagens')
        .add({
          'texto': texto,
          'imagemUrl': imagemUrl,
          'tipo': tipo,
          'enviadoPorEmail': usuarioLogado.email,
          'criadoEm': agora,
        });

    await _firestore.collection('chats').doc(chatId).update({
      'ultimaMensagem': tipo == 'imagem' ? '📷 Imagem enviada' : texto,
      'atualizadoEm': agora,
    });
  }

  Stream<QuerySnapshot> listarMeusChats() {
    final usuarioLogado = _auth.currentUser;
    if (usuarioLogado == null) return const Stream.empty();

    return _firestore
        .collection('chats')
        .where('emailsEnvolvidos', arrayContains: usuarioLogado.email)
        .snapshots();
  }

  Stream<QuerySnapshot> escutarMensagens(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('mensagens')
        .orderBy('criadoEm', descending: true)
        .snapshots();
  }
}
