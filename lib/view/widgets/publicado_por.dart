import 'package:flutter/material.dart';

class PetPublicadoPorCard extends StatelessWidget {
  final String nome;
  final String email;
  final String? avatarUrl;

  const PetPublicadoPorCard({
    super.key,
    required this.nome,
    required this.email,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final String primeiraLetra = nome.isNotEmpty ? nome[0].toUpperCase() : 'U';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cores.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cores.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Publicado por',
            style: TextStyle(fontSize: 13, color: cores.onSurface),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8622A).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: avatarUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(avatarUrl!, fit: BoxFit.cover),
                      )
                    : Center(
                        child: Text(
                          primeiraLetra,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE8622A),
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: cores.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 12,
                        color: cores.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 12,
                          color: cores.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
