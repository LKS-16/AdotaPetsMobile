import 'package:adota_pets_mobile/view/modelo/modelo_pet.dart';
import 'package:flutter/material.dart';

class CardMeuPet extends StatelessWidget {
  final PetModel pet;
  final VoidCallback onTap;
  final VoidCallback? onEditar;
  final VoidCallback? onExcluir;

  const CardMeuPet({
    super.key,
    required this.pet,
    required this.onTap,
    this.onEditar,
    this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  pet.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFF5F0EB),
                    child: const Icon(
                      Icons.pets,
                      color: Color(0xFFBBBBBB),
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pet.nome,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _mostrarOpcoes(context),
                        child: const Icon(
                          Icons.more_horiz,
                          size: 20,
                          color: Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pet.petSubtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF888888),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Chips de espécie e porte
                  Row(
                    children: [
                      _Chip(label: pet.especie),
                      const SizedBox(width: 6),
                      _Chip(label: pet.porte),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarOpcoes(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDDDDDD),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(
                Icons.edit_outlined,
                color: Color(0xFF1A1A1A),
              ),
              title: const Text('Editar pet'),
              onTap: () {
                Navigator.pop(context);
                onEditar?.call();
              },
            ),
            const Divider(height: 1, indent: 16, color: Color(0xFFF0F0F0)),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Color(0xFFE53935),
              ),
              title: const Text(
                'Excluir pet',
                style: TextStyle(color: Color(0xFFE53935)),
              ),
              onTap: () {
                Navigator.pop(context);
                onExcluir?.call();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;

  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F0EB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFFE8622A),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
