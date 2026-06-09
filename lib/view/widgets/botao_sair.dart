import 'package:flutter/material.dart';

class PerfilBotaoSair extends StatelessWidget {
  final VoidCallback onSair;

  const PerfilBotaoSair({super.key, required this.onSair});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onSair,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_outlined, size: 18, color: Color(0xFF1A1A1A)),
              SizedBox(width: 8),
              Text(
                'Sair',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}