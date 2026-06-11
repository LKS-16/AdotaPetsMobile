import 'package:adota_pets_mobile/models/modelo_conversa.dart';
import 'package:flutter/material.dart';

class CardConversa extends StatelessWidget {
  final ModeloConversa conversa;
  final VoidCallback onTap;

  const CardConversa({
    super.key,
    required this.conversa,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final temNaoLidas = conversa.mensagensNaoLidas > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(0xFFF0F0F0)),
          ),
        ),
        child: Row(
          children: [
            // Avatar do pet
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                conversa.petImageUrl,
                width: 54,
                height: 54,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 54,
                  height: 54,
                  color: const Color(0xFFF5F0EB),
                  child: const Icon(Icons.pets,
                      color: Color(0xFFBBBBBB), size: 26),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Informações da conversa
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome do pet + horário
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        conversa.petNome,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: temNaoLidas
                              ? FontWeight.bold
                              : FontWeight.w600,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      Text(
                        conversa.horarioFormatado,
                        style: TextStyle(
                          fontSize: 12,
                          color: temNaoLidas
                              ? const Color(0xFFE8622A)
                              : const Color(0xFF999999),
                          fontWeight: temNaoLidas
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Contato + badge de não lidas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversa.contatoNome,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF888888),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              conversa.ultimaMensagem,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: temNaoLidas
                                    ? const Color(0xFF1A1A1A)
                                    : const Color(0xFF888888),
                                fontWeight: temNaoLidas
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Badge de não lidas
                      if (temNaoLidas)
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8622A),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${conversa.mensagensNaoLidas}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}