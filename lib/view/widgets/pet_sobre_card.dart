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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Sobre $petName',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(width: 6),
              const Text('🐾', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            descricao,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF555555),
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

  const PetTemperamentoCard({
    super.key,
    required this.temperamentos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Temperamento',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0EB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8622A).withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFFE8622A),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}