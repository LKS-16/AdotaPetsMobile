import 'package:flutter/material.dart';

class PetSaudeCard extends StatelessWidget {
  final bool vacinado;
  final bool castrado;
  final String localizacao;

  const PetSaudeCard({
    super.key,
    required this.vacinado,
    required this.castrado,
    required this.localizacao,
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
          Text(
            'Saúde',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: cores.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          _SaudeItem(
            icon: Icons.circle,
            iconColor: vacinado
                ? const Color(0xFF4CAF50)
                : const Color(0xFFBBBBBB),
            label: 'Vacinado',
          ),
          const SizedBox(height: 8),
          _SaudeItem(
            icon: Icons.cut,
            iconColor: castrado
                ? const Color(0xFF9C27B0)
                : const Color(0xFFBBBBBB),
            label: 'Castrado',
          ),
          const SizedBox(height: 8),
          _SaudeItem(
            icon: Icons.location_on,
            iconColor: const Color(0xFFE8622A),
            label: localizacao,
          ),
        ],
      ),
    );
  }
}

class _SaudeItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const _SaudeItem({
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: cores.onSurfaceVariant),
        ),
      ],
    );
  }
}
