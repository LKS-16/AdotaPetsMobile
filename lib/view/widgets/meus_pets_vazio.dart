import 'package:flutter/material.dart';

class MeusPetsVazio extends StatelessWidget {
  const MeusPetsVazio({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F0EB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.pets, size: 36, color: Color(0xFFE8622A)),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nenhum pet cadastrado',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Use o botão + para cadastrar seu primeiro pet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF888888),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
