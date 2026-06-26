import 'package:adota_pets_mobile/view/modelo/controller/favoritos_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adota_pets_mobile/view/widgets/pet_card.dart'; // Garanta o import correto do seu card

class TelaFavoritos extends StatelessWidget {
  const TelaFavoritos({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritosController = Provider.of<FavoritosController>(context);
    final listaFavoritos = favoritosController.petsFavoritos;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Favoritos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seus Favoritos',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const Text(
                'Pets que você salvou',
                style: TextStyle(fontSize: 14, color: Color(0xFF888888)),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: listaFavoritos.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('💛', style: TextStyle(fontSize: 64)),
                            const SizedBox(height: 16),
                            const Text(
                              'Nenhum favorito ainda',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                'Toque no coração em qualquer pet para salvá-lo aqui',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF888888),
                                ),
                              ),
                            ),
                            const SizedBox(height: 64),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: listaFavoritos.length,
                        itemBuilder: (context, index) {
                          final pet = listaFavoritos[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: PetCard(pet: pet),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
