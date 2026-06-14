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
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F0EB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              '$valor',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE8622A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
            ),
          ],
        ),
      ),
    );
  }
}
