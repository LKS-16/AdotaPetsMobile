import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:adota_pets_mobile/view/pages/tela_chat.dart';
import 'package:adota_pets_mobile/view/widgets/botao_adotar.dart';
import 'package:adota_pets_mobile/view/widgets/pet_atributos.dart';
import 'package:adota_pets_mobile/view/widgets/pet_imagem_principal.dart';
import 'package:adota_pets_mobile/view/widgets/pet_saude_card.dart';
import 'package:adota_pets_mobile/view/widgets/pet_sobre_card.dart';
import 'package:adota_pets_mobile/view/widgets/publicado_por.dart';
import 'package:flutter/material.dart';

class TelaPerfil extends StatefulWidget {
  final PetModel pet;

  const TelaPerfil({super.key, required this.pet});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
                          color: Color(0xFF1A1A1A),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Voltar',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PetImagemPrincipal(
                      imageUrl: widget.pet.imageUrl,
                      petName: widget.pet.nome,
                      petSubtitle: widget.pet.petSubtitle,
                      isFavorited: _isFavorited,
                      onFavoriteTap: () {
                        setState(() => _isFavorited = !_isFavorited);
                      },
                    ),

                    const SizedBox(height: 16),

                    PetAtributosRow(
                      especie: widget.pet.especie,
                      porte: widget.pet.porte,
                      sexo: widget.pet.sexo,
                      idade: widget.pet.idade,
                    ),

                    const SizedBox(height: 16),

                    PetSobreCard(
                      petName: widget.pet.nome,
                      descricao: widget.pet.descricao,
                    ),

                    const SizedBox(height: 16),

                    PetTemperamentoCard(
                      temperamentos: widget.pet.temperamentos,
                    ),

                    const SizedBox(height: 16),

                    PetSaudeCard(
                      vacinado: widget.pet.vacinado,
                      castrado: widget.pet.castrado,
                      localizacao: widget.pet.localizacao,
                    ),

                    const SizedBox(height: 16),

                    PetPublicadoPorCard(
                      tipo: widget.pet.publicadoPorTipo,
                      email: widget.pet.publicadoPorEmail,
                      avatarUrl: widget.pet.publicadoPorAvatarUrl,
                    ),

                    const SizedBox(height: 24),

                    BotaoAdotar(
                      petName: widget.pet.nome,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaChat(pet: widget.pet),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
