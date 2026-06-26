import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:adota_pets_mobile/view/pages/botao_cadastrapet.dart';
import 'package:adota_pets_mobile/view/services/pet_service.dart';
import 'package:adota_pets_mobile/view/widgets/filtros.dart';
import 'package:adota_pets_mobile/view/widgets/pet_card.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  Feed({super.key});

  final PetService _petService = PetService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const BotaoCadastrarPet(),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Encontre Seu Novo ",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: "Melhor Amigo",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFD35400),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Conheça pets adoráveis que buscam um lar para sempre",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Buscar...",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const FiltroAnimais(),
              const SizedBox(height: 25),

              StreamBuilder<List<PetModel>>(
                stream: _petService.buscarPetsStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Erro ao carregar os pets.'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final listaDePets = snapshot.data;
                  if (listaDePets == null || listaDePets.isEmpty) {
                    return const Center(
                      child: Text('Nenhum pet cadastrado no momento'),
                    );
                  }
                  return Column(
                    children: listaDePets.map((p) => PetCard(pet: p)).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
