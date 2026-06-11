import 'package:adota_pets_mobile/models/modelo_conversa.dart';
import 'package:adota_pets_mobile/models/pet_model.dart';
import 'package:adota_pets_mobile/view/tela_chat.dart';
import 'package:adota_pets_mobile/view/widgets/botao_cadastrar_pet.dart';
import 'package:adota_pets_mobile/view/widgets/card_conversa.dart';
import 'package:adota_pets_mobile/view/widgets/conversas_vazio.dart';
import 'package:flutter/material.dart';

class TelaConversas extends StatelessWidget {
  final List<ModeloConversa> conversas;

  const TelaConversas({
    super.key,
    required this.conversas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EE),
      floatingActionButton: const BotaoCadastrarPet(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cabeçalho ──────────────────────────────────
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
                  // Badge com total de não lidas
                  if (conversas.any((c) => c.mensagensNaoLidas > 0))
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8622A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${conversas.fold(0, (soma, c) => soma + c.mensagensNaoLidas)} novas',
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

            // ── Lista ou estado vazio ───────────────────────
            Expanded(
              child: conversas.isEmpty
                  ? const ConversasVazio()
                  : Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(24)),
                        child: ListView.builder(
                          itemCount: conversas.length,
                          itemBuilder: (context, index) {
                            final conversa = conversas[index];
                            return CardConversa(
                              conversa: conversa,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TelaChat(
                                      pet: PetModel(
                                        nome: conversa.petNome,
                                        imageUrl: conversa.petImageUrl,
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
                                        publicadoPorTipo: conversa.contatoNome,
                                        publicadoPorEmail: '',
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
        ),
      ),
    );
  }
}