import 'package:flutter/material.dart';

class SeletorPorte extends StatelessWidget {
  final String? porteSelecionado;
  final ValueChanged<String> onSelecionado;

  const SeletorPorte({
    super.key,
    required this.porteSelecionado,
    required this.onSelecionado,
  });

  static const _opcoes = ['Pequeno', 'Médio', 'Grande'];

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final corTextoLabel = cores.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Porte',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: corTextoLabel,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: _opcoes.map((opcao) {
            final selecionado = porteSelecionado == opcao;

            final corFundoBotao = selecionado
                ? const Color(0xFFE8622A)
                : (isDarkMode
                      ? const Color(0xFF2C2621)
                      : const Color(0xFFF5F0EB));
            final corTextoBotao = selecionado
                ? Colors.white
                : (isDarkMode ? Colors.grey[300] : const Color(0xFF444444));

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: opcao != _opcoes.last ? 8 : 0),
                child: GestureDetector(
                  onTap: () => onSelecionado(opcao),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: corFundoBotao,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        opcao,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: corTextoBotao,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
