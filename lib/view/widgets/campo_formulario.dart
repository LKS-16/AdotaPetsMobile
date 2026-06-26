import 'package:flutter/material.dart';

class CampoFormulario extends StatelessWidget {
  final String label;
  final String hint;
  final bool obrigatorio;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;

  const CampoFormulario({
    super.key,
    required this.label,
    required this.hint,
    this.obrigatorio = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final corTextoLabel = cores.onSurface;
    final corFundoInput = isDarkMode
        ? const Color(0xFF2C2621)
        : const Color(0xFFF5F0EB);
    final corTextoHint = isDarkMode
        ? Colors.grey[500]
        : const Color(0xFFAAAAAA);

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
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(fontSize: 13, color: corTextoLabel),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13, color: corTextoHint),
            filled: true,
            fillColor: corFundoInput,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
