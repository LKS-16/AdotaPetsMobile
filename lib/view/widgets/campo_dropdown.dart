import 'package:flutter/material.dart';

class CampoDropdown extends StatelessWidget {
  final String label;
  final bool obrigatorio;
  final String? valorSelecionado;
  final List<String> opcoes;
  final ValueChanged<String?> onChanged;

  const CampoDropdown({
    super.key,
    required this.label,
    required this.opcoes,
    required this.onChanged,
    this.obrigatorio = false,
    this.valorSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
            if (obrigatorio)
              const Text(
                ' *',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE8622A),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F0EB),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: valorSelecionado,
              hint: const Text(
                'Selecione',
                style: TextStyle(fontSize: 13, color: Color(0xFFAAAAAA)),
              ),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF888888)),
              style: const TextStyle(fontSize: 13, color: Color(0xFF1A1A1A)),
              items: opcoes
                  .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}