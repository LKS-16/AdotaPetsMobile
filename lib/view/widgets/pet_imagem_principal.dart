import 'package:flutter/material.dart';

class PetImagemPrincipal extends StatelessWidget {
  final String imageUrl;
  final String petName;
  final String petSubtitle;
  final bool isFavorited;
  final VoidCallback? onFavoriteTap;

  const PetImagemPrincipal({
    super.key,
    required this.imageUrl,
    required this.petName,
    required this.petSubtitle,
    this.isFavorited = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          // Imagem principal
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFEEEEEE),
                child: const Icon(
                  Icons.pets,
                  size: 64,
                  color: Color(0xFFBBBBBB),
                ),
              ),
            ),
          ),

          // Gradiente inferior para legibilidade do texto
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xCC000000), Colors.transparent],
                ),
              ),
            ),
          ),

          // Nome e subtítulo
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  petName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  petSubtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ),

          // Botão de favorito
          Positioned(
            bottom: 16,
            right: 16,
            child: GestureDetector(
              onTap: onFavoriteTap,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cores.surfaceContainer,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: const Color(0xFFE8622A),
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
