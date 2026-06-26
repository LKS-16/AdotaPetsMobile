import 'package:flutter/material.dart';

class PerfilBotaoSair extends StatelessWidget {
  final VoidCallback onSair;

  const PerfilBotaoSair({super.key, required this.onSair});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onSair,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cores.onSurface.withOpacity(0.12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_outlined, size: 18, color: cores.onSurface),
              SizedBox(width: 8),
              Text(
                'Sair',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: cores.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
