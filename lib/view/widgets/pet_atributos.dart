import 'package:flutter/material.dart';

class PetAtributoCard extends StatelessWidget {
  final String label;
  final String valor;

  const PetAtributoCard({super.key, required this.label, required this.valor});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: cores.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cores.outlineVariant),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 11, color: cores.onSurfaceVariant),
            ),
            const SizedBox(height: 4),
            Text(
              valor,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: cores.onSurface,
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
