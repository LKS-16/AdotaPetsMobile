import 'package:adota_pets_mobile/view/modelo/modelo_conversas.dart';
import 'package:flutter/material.dart';

class CardConversa extends StatelessWidget {
  final ModeloConversa conversa;
  final VoidCallback onTap;

  const CardConversa({super.key, required this.conversa, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final temNaoLidas = conversa.mensagensNaoLidas > 0;
    final cores = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(color: cores.onSurface.withOpacity(0.08)),
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
                  color: cores.primary.withOpacity(0.08),
                  child: Icon(
                    Icons.pets,
                    color: cores.primary.withOpacity(0.5),
                    size: 26,
                  ),
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
                          color: cores.onSurface,
                        ),
                      ),
                      Text(
                        conversa.horarioFormatado,
                        style: TextStyle(
                          fontSize: 12,
                          color: temNaoLidas
                              ? const Color(0xFFE8622A)
                              : cores.onSurfaceVariant.withOpacity(0.7),
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
                              style: TextStyle(
                                fontSize: 12,
                                color: cores.onSurfaceVariant,
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
                                    ? cores.onSurface
                                    : cores.onSurfaceVariant,
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
