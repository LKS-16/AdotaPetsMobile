import 'package:flutter/material.dart';

class ConfiguracaoSecao extends StatelessWidget {
  final String titulo;
  final List<Widget> itens;

  const ConfiguracaoSecao({
    super.key,
    required this.titulo,
    required this.itens,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cores.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cores.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Text(
              titulo.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: cores.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
          ),

          ...List.generate(itens.length, (index) {
            return Column(
              children: [
                itens[index],
                if (index < itens.length - 1)
                  Divider(
                    height: 1,
                    indent: 66,
                    endIndent: 16,
                    color: cores.outlineVariant,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
