import 'package:flutter/material.dart';

class ConfiguracaoItem extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  final bool valor;
  final ValueChanged<bool> onChanged;

  const ConfiguracaoItem({
    super.key,
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.valor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: cores.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icone, size: 18, color: cores.onSurfaceVariant),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: cores.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  descricao,
                  style: TextStyle(fontSize: 12, color: cores.onSurfaceVariant),
                ),
              ],
            ),
          ),

          Switch(
            value: valor,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFFE8622A),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: cores.outlineVariant,
          ),
        ],
      ),
    );
  }
}
