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
    final cores = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cores.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cores.onSurface.withOpacity(0.08)),
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
                    color: cores.surfaceContainerHighest,
                    child: Icon(
                      Icons.pets,
                      color: cores.onSurfaceVariant,
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
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: cores.onSurface,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _mostrarOpcoes(context),
                        child: Icon(
                          Icons.more_horiz,
                          size: 20,
                          color: cores.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pet.petSubtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: cores.onSurfaceVariant,
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
    final cores = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: cores.surfaceContainerLow,
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
                color: cores.onSurfaceVariant.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.edit_outlined, color: cores.onSurface),
              title: Text(
                'Editar pet',
                style: TextStyle(color: cores.onSurface),
              ),
              onTap: () {
                Navigator.pop(context);
                onEditar?.call();
              },
            ),
            Divider(
              height: 1,
              indent: 16,
              color: cores.onSurface.withOpacity(0.08),
            ),
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
    final cores = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cores.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: cores.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
