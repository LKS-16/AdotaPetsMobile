import 'package:adota_pets_mobile/view/services/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adota_pets_mobile/view/modelo/modelo_conversas.dart';
import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:adota_pets_mobile/view/pages/tela_chat.dart';
import 'package:adota_pets_mobile/view/widgets/card_conversa.dart';
import 'package:adota_pets_mobile/view/widgets/conversa_vazio.dart';
import 'package:flutter/material.dart';

class TelaConversas extends StatefulWidget {
  const TelaConversas({super.key});

  @override
  State<TelaConversas> createState() => _TelaConversasState();
}

class _TelaConversasState extends State<TelaConversas> {
  // Instancia o serviço e cria a variável que vai guardar o fluxo de dados fixo
  final ChatService _chatService = ChatService();
  late Stream<QuerySnapshot> _conversasStream;
  final String? _meuEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    super.initState();
    // Inicializa o Stream aqui. Ele fica travado na memória e não reseta se a tela atualizar
    _conversasStream = _chatService.listarMeusChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EE),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              _conversasStream, // Passa o fluxo persistente criado no initState
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFE8622A)),
              );
            }

            final docs = snapshot.data?.docs ?? [];

            if (docs.isEmpty) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 32, 24, 20),
                    child: Text(
                      'Conversas',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: ConversasVazio()),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Conversas',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8622A),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${docs.length} ativas',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final dados =
                              docs[index].data() as Map<String, dynamic>;

                          // Descobre quem é a outra pessoa para colocar o nome correto no cabeçalho do card
                          final String nomeExibir =
                              dados['adotanteEmail'] == _meuEmail
                              ? dados['donoNome']
                              : dados['adotanteNome'];

                          final Timestamp? timestamp =
                              dados['atualizadoEm'] as Timestamp?;
                          final DateTime horarioFinal = timestamp != null
                              ? timestamp.toDate()
                              : DateTime.now();

                          final conversaModel = ModeloConversa(
                            id: docs[index].id,
                            contatoNome: nomeExibir,
                            ultimaMensagem: dados['ultimaMensagem'] ?? '',
                            horario: horarioFinal,
                            mensagensNaoLidas: 0,
                            petNome: dados['petNome'] ?? '',
                            petImageUrl: dados['petImageUrl'] ?? '',
                          );

                          return CardConversa(
                            conversa: conversaModel,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TelaChat(
                                    chatId: docs[index].id,
                                    pet: PetModel(
                                      nome: dados['petNome'] ?? '',
                                      imageUrl: dados['petImageUrl'] ?? '',
                                      raca: '',
                                      especie: '',
                                      porte: '',
                                      sexo: '',
                                      idade: '',
                                      descricao: '',
                                      temperamentos: [],
                                      vacinado: false,
                                      castrado: false,
                                      localizacao: '',
                                      publicadoPorTipo: nomeExibir,
                                      publicadoPorEmail:
                                          dados['donoEmail'] ?? '',
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
