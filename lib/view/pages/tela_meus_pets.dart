import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:adota_pets_mobile/view/pages/botao_cadastrapet.dart';
import 'package:adota_pets_mobile/view/pages/tela_petperfil.dart';
import 'package:adota_pets_mobile/view/services/pet_service.dart';
import 'package:adota_pets_mobile/view/widgets/card_meu_pet.dart';
import 'package:adota_pets_mobile/view/widgets/meus_pets_vazio.dart';
import 'package:flutter/material.dart';

class TelaMeusPets extends StatelessWidget {
  const TelaMeusPets({super.key});

  @override
  Widget build(BuildContext context) {
    final PetService petService = PetService();
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cores.surface,
      floatingActionButton: const BotaoCadastrarPet(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 4),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Meus ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: cores.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: 'Pets',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD35400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 4, 24, 20),
              child: Text(
                'Pets que você cadastrou para adoção',
                style: TextStyle(fontSize: 14, color: cores.onSurfaceVariant),
              ),
            ),

            Expanded(
              child: StreamBuilder<List<PetModel>>(
                stream: petService.buscarMeusPetsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: cores.primary),
                    );
                  }

                  final listaMeusPets = snapshot.data ?? [];

                  if (listaMeusPets.isEmpty) {
                    return const MeusPetsVazio();
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GridView.builder(
                      itemCount: listaMeusPets.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                      itemBuilder: (context, index) {
                        final pet = listaMeusPets[index];
                        return CardMeuPet(
                          pet: pet,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TelaPerfil(pet: pet),
                              ),
                            );
                          },
                          onEditar: () {},
                          onExcluir: () {},
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
