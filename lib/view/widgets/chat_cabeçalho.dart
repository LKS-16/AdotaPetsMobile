import 'package:flutter/material.dart';

class ChatCabecalho extends StatelessWidget implements PreferredSizeWidget {
  final String petNome;
  final String petImageUrl;
  final String contatoNome;
  final VoidCallback? onVoltar;

  const ChatCabecalho({
    super.key,
    required this.petNome,
    required this.petImageUrl,
    required this.contatoNome,
    this.onVoltar,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: GestureDetector(
        onTap: onVoltar ?? () => Navigator.pop(context),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF1A1A1A)),
          ],
        ),
      ),
      title: Row(
        children: [
          // Avatar do pet
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.network(
              petImageUrl,
              width: 42,
              height: 42,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 42,
                height: 42,
                color: const Color(0xFFEEEEEE),
                child: const Icon(
                  Icons.pets,
                  color: Color(0xFFBBBBBB),
                  size: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                petNome,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Text(
                contatoNome,
                style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
              ),
            ],
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: const Color(0xFFEEEEEE), height: 1),
      ),
    );
  }
}
