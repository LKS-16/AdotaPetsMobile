import 'dart:convert'; // Necessário para o base64Encode
import 'dart:typed_data';
import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class PetService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> cadastrarPet({
    required String nome,
    required String especie,
    required String sexo,
    required String descricao,
    required String idade,
    required String localizacao,
    required String porte,
    required String raca,
    required bool castrado,
    required bool vacinado,
    required List<String> temperamentos,
    required XFile? imagemSelecionada,
  }) async {
    try {
      String campoFoto = '';

      if (imagemSelecionada != null) {
        Uint8List bytes = await imagemSelecionada.readAsBytes();
        campoFoto = 'data:image/jpeg;base64,${base64Encode(bytes)}';
      }
      final String usuarioEmail = _auth.currentUser?.email ?? '';
      final String usuarioNome = _auth.currentUser?.displayName ?? 'Usuário';

      await _firestore.collection('pets').add({
        'nome': nome,
        'especie': especie,
        'sexo': sexo,
        'descricao': descricao,
        'idade': idade,
        'localizacao': localizacao,
        'porte': porte,
        'raca': raca,
        'castrado': castrado,
        'vacinado': vacinado,
        'temperamentos': temperamentos,
        'fotoUrl': campoFoto,
        'criadoEm': FieldValue.serverTimestamp(),
        'publicadoPorEmail': usuarioEmail,
        'publicadoPorNome': usuarioNome,
      });
    } catch (e) {
      print("Erro no PetService: $e");
      rethrow;
    }
  }

  Stream<List<PetModel>> buscarMeusPetsStream() {
    final String? meuEmail = _auth.currentUser?.email;

    if (meuEmail == null) return const Stream.empty();

    return _firestore
        .collection('pets')
        .where('publicadoPorEmail', isEqualTo: meuEmail)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return PetModel(
              nome: data['nome'] ?? '',
              especie: data['especie'] ?? '',
              raca: data['raca'] ?? '',
              idade: data['idade'] ?? '',
              localizacao: data['localizacao'] ?? '',
              imageUrl: data['fotoUrl'] ?? data['imageUrl'] ?? '',
              temperamentos: List<String>.from(data['temperamentos'] ?? []),
              porte: data['porte'] ?? '',
              sexo: data['sexo'] ?? '',
              descricao: data['descricao'] ?? '',
              vacinado: data['vacinado'] ?? false,
              castrado: data['castrado'] ?? false,
              publicadoPorTipo:
                  data['publicadoPorNome'] ??
                  data['publicadoPorTipo'] ??
                  "PESSOA",
              publicadoPorEmail: data['publicadoPorEmail'] ?? '',
              publicadoPorAvatarUrl: null,
            );
          }).toList();
        });
  }

  Stream<List<PetModel>> buscarPetsStream() {
    return _firestore
        .collection('pets')
        .orderBy('criadoEm', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();

            return PetModel(
              nome: data['nome'] ?? '',
              especie: data['especie'] ?? '',
              raca: data['raca'] ?? '',
              idade: data['idade'] ?? '',
              localizacao: data['localizacao'] ?? '',
              imageUrl: data['fotoUrl'] ?? '',
              temperamentos: List<String>.from(data['temperamentos'] ?? []),
              porte: data['porte'] ?? '',
              sexo: data['sexo'] ?? '',
              descricao: data['descricao'] ?? '',
              vacinado: data['vacinado'] ?? false,
              castrado: data['castrado'] ?? false,
              publicadoPorTipo: data['publicadoPorNome'] ?? "PESSOA",
              publicadoPorEmail: data['publicadoPorEmail'] ?? '',
              publicadoPorAvatarUrl: null,
            );
          }).toList();
        });
  }
}
