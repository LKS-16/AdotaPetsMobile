import 'package:adota_pets_mobile/view/modelo/controller/favoritos_controller.dart';
import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:adota_pets_mobile/view/pages/tela_chat.dart';
import 'package:adota_pets_mobile/view/services/chat_services.dart';
import 'package:adota_pets_mobile/view/widgets/botao_adotar.dart';
import 'package:adota_pets_mobile/view/widgets/pet_atributos.dart';
import 'package:adota_pets_mobile/view/widgets/pet_imagem_principal.dart';
import 'package:adota_pets_mobile/view/widgets/pet_saude_card.dart';
import 'package:adota_pets_mobile/view/widgets/pet_sobre_card.dart';
import 'package:adota_pets_mobile/view/widgets/publicado_por.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaPerfil extends StatefulWidget {
  final PetModel pet;

  const TelaPerfil({super.key, required this.pet});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  @override
  Widget build(BuildContext context) {
    final favoritosController = Provider.of<FavoritosController>(context);
    final cores = Theme.of(context).colorScheme;
    final String? meuEmail = FirebaseAuth.instance.currentUser?.email;
    final bool souODonoDoPet = widget.pet.publicadoPorEmail == meuEmail;

    final String idGerado = ChatService().obterChatId(
      donoEmail: widget.pet.publicadoPorEmail,
      petNome: widget.pet.nome,
    );

    return Scaffold(
      backgroundColor: cores.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
                          color: cores.onSurface,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Voltar',
                          style: TextStyle(
                            fontSize: 14,
                            color: cores.onSurface,
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
                      isFavorited: favoritosController.isFavoritado(widget.pet),
                      onFavoriteTap: () {
                        favoritosController.alternarFavorito(widget.pet);
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
                      nome: widget.pet.nome,
                      email: widget.pet.publicadoPorEmail,
                      avatarUrl: widget.pet.publicadoPorAvatarUrl,
                    ),

                    const SizedBox(height: 24),

                    souODonoDoPet
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cores.surfaceContainerHighest.withOpacity(
                                0.4,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: cores.onSurfaceVariant.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: cores.onSurfaceVariant,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Este pet foi cadastrado por você.',
                                  style: TextStyle(
                                    color: cores.onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : BotaoAdotar(
                            petName: widget.pet.nome,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TelaChat(
                                    pet: widget.pet,
                                    chatId: idGerado,
                                  ),
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
