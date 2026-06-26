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
    final cores = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final corFundoContainer = isDarkMode
        ? const Color(0xFF2C2621)
        : const Color(0xFFF5F0EB);
    final corTextoLabel = cores.onSurface;
    final corTextoHint = isDarkMode
        ? Colors.grey[500]
        : const Color(0xFFAAAAAA);
    final corIcone = isDarkMode ? Colors.grey[400] : const Color(0xFF888888);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: corTextoLabel,
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
            color: corFundoContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: valorSelecionado,
              dropdownColor: isDarkMode
                  ? const Color(0xFF332C26)
                  : Colors.white,
              hint: Text(
                'Selecione',
                style: TextStyle(fontSize: 13, color: corTextoHint),
              ),
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: corIcone),
              style: TextStyle(fontSize: 13, color: corTextoLabel),
              items: opcoes
                  .map(
                    (o) => DropdownMenuItem(
                      value: o,
                      child: Text(o, style: TextStyle(color: corTextoLabel)),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
