import 'package:flutter/material.dart';

class PerfilCabecalho extends StatelessWidget {
  final String nome;
  final String email;
  final String membroDesde;
  final String? avatarUrl;

  const PerfilCabecalho({
    super.key,
    required this.nome,
    required this.email,
    required this.membroDesde,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                gradient: LinearGradient(
                  colors: [Color(0xFFFDE8D8), Color(0xFFFFF3EC)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),

            Positioned(
              bottom: -30,
              left: 20,
              child: avatarUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        avatarUrl!,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8622A),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          nome.isNotEmpty ? nome[0].toUpperCase() : '?',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),

        const SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            nome,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),

        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.email_outlined, size: 14, color: Color(0xFF888888)),
              const SizedBox(width: 6),
              Text(
                email,
                style: const TextStyle(fontSize: 13, color: Color(0xFF888888)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 6),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF888888)),
              const SizedBox(width: 6),
              Text(
                'Membro desde $membroDesde',
                style: const TextStyle(fontSize: 13, color: Color(0xFF888888)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}