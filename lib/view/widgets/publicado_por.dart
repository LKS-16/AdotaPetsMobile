import 'package:flutter/material.dart';

class PetPublicadoPorCard extends StatelessWidget {
  final String tipo;
  final String email;
  final String? avatarUrl;

  const PetPublicadoPorCard({
    super.key,
    required this.tipo,
    required this.email,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Publicado por',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF999999),
            ),
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
                    : const Center(
                        child: Text(
                          'M',
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
                    tipo,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.email_outlined, size: 12, color: Color(0xFF999999)),
                      const SizedBox(width: 4),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
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