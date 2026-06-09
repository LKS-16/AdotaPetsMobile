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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Porte',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: _opcoes.map((opcao) {
            final selecionado = porteSelecionado == opcao;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: opcao != _opcoes.last ? 8 : 0,
                ),
                child: GestureDetector(
                  onTap: () => onSelecionado(opcao),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: selecionado
                          ? const Color(0xFFE8622A)
                          : const Color(0xFFF5F0EB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        opcao,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: selecionado
                              ? Colors.white
                              : const Color(0xFF444444),
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