import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:adota_pets_mobile/view/pages/tela_petperfil.dart';
import 'package:adota_pets_mobile/view/widgets/card_meu_pet.dart';
import 'package:adota_pets_mobile/view/widgets/meus_pets_vazio.dart';
import 'package:flutter/material.dart';

class TelaMeusPets extends StatelessWidget {
  final List<PetModel> pets;

  const TelaMeusPets({super.key, required this.pets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EE),
      //floatingActionButton: const BotaoCadastrarPet(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 4),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Meus ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    TextSpan(
                      text: 'Pets',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE8622A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 4, 24, 20),
              child: Text(
                'Pets que você cadastrou para adoção',
                style: TextStyle(fontSize: 14, color: Color(0xFF888888)),
              ),
            ),

            Expanded(
              child: pets.isEmpty
                  ? const MeusPetsVazio()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GridView.builder(
                        itemCount: pets.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                        itemBuilder: (context, index) {
                          final pet = pets[index];
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
