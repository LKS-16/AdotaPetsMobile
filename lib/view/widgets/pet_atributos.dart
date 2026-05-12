import 'package:flutter/material.dart';

class PetAtributoCard extends StatelessWidget {
  final String label;
  final String valor;

  const PetAtributoCard({
    super.key,
    required this.label,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF999999),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              valor,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PetAtributosRow extends StatelessWidget {
  final String especie;
  final String porte;
  final String sexo;
  final String idade;

  const PetAtributosRow({
    super.key,
    required this.especie,
    required this.porte,
    required this.sexo,
    required this.idade,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PetAtributoCard(label: 'Espécie', valor: especie),
        const SizedBox(width: 8),
        PetAtributoCard(label: 'Porte', valor: porte),
        const SizedBox(width: 8),
        PetAtributoCard(label: 'Sexo', valor: sexo),
        const SizedBox(width: 8),
        PetAtributoCard(label: 'Idade', valor: idade),
      ],
    );
  }
}