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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Text(
              titulo.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF888888),
                letterSpacing: 1.2,
              ),
            ),
          ),

          ...List.generate(itens.length, (index) {
            return Column(
              children: [
                itens[index],
                if (index < itens.length - 1)
                  const Divider(
                    height: 1,
                    indent: 66,
                    endIndent: 16,
                    color: Color(0xFFF0F0F0),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
