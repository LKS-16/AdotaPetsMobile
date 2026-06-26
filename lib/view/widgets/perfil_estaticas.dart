import 'package:flutter/material.dart';

class PerfilEstatisticas extends StatelessWidget {
  final int favoritos;
  final int pedidos;

  const PerfilEstatisticas({
    super.key,
    required this.favoritos,
    required this.pedidos,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _EstatisticaCard(valor: favoritos, label: 'Favoritos'),
          const SizedBox(width: 12),
          _EstatisticaCard(valor: pedidos, label: 'Pedidos'),
        ],
      ),
    );
  }
}

class _EstatisticaCard extends StatelessWidget {
  final int valor;
  final String label;

  const _EstatisticaCard({required this.valor, required this.label});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: cores.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              '$valor',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: cores.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: cores.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
