import 'package:flutter/material.dart';

class PetSobreCard extends StatelessWidget {
  final String petName;
  final String descricao;

  const PetSobreCard({
    super.key,
    required this.petName,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cores.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cores.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Sobre $petName',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: cores.onSurface,
                ),
              ),
              const SizedBox(width: 6),
              const Text('🐾', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            descricao,
            style: TextStyle(
              fontSize: 13,
              color: cores.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class PetTemperamentoCard extends StatelessWidget {
  final List<String> temperamentos;

  const PetTemperamentoCard({super.key, required this.temperamentos});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cores.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cores.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Temperamento',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: cores.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: temperamentos
                .map((t) => _TemperamentoChip(label: t))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _TemperamentoChip extends StatelessWidget {
  final String label;
  const _TemperamentoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final corLaranja = const Color(0xFFD35400);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: corLaranja.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8622A).withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: corLaranja,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
