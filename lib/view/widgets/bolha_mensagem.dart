import 'package:adota_pets_mobile/view/modelo/modelo_mensagem.dart';
import 'package:flutter/material.dart';

class BolhaMensagem extends StatelessWidget {
  final ModeloMensagem mensagem;

  const BolhaMensagem({super.key, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    final isMinha = mensagem.isMinha;

    return Align(
      alignment: isMinha ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: isMinha ? 64 : 0,
          right: isMinha ? 0 : 64,
        ),
        decoration: BoxDecoration(
          color: isMinha ? const Color(0xFFE8622A) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMinha ? 16 : 4),
            bottomRight: Radius.circular(isMinha ? 4 : 16),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: mensagem.tipo == TipoMensagem.imagem
            ? _BolhaImagem(mensagem: mensagem, isMinha: isMinha)
            : _BolhaTexto(mensagem: mensagem, isMinha: isMinha),
      ),
    );
  }
}

// Bolha de texto
class _BolhaTexto extends StatelessWidget {
  final ModeloMensagem mensagem;
  final bool isMinha;

  const _BolhaTexto({required this.mensagem, required this.isMinha});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            mensagem.texto,
            style: TextStyle(
              fontSize: 14,
              color: isMinha ? Colors.white : const Color(0xFF1A1A1A),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            mensagem.horarioFormatado,
            style: TextStyle(
              fontSize: 10,
              color: isMinha
                  ? Colors.white.withOpacity(0.7)
                  : const Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}

// Bolha de imagem
class _BolhaImagem extends StatelessWidget {
  final ModeloMensagem mensagem;
  final bool isMinha;

  const _BolhaImagem({required this.mensagem, required this.isMinha});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMinha ? 16 : 4),
            bottomRight: Radius.circular(isMinha ? 4 : 16),
          ),
          child: Image.network(
            mensagem.imagemUrl!,
            width: 220,
            height: 180,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 220,
              height: 180,
              color: const Color(0xFFEEEEEE),
              child: const Icon(
                Icons.broken_image,
                color: Color(0xFFBBBBBB),
                size: 40,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            mensagem.horarioFormatado,
            style: TextStyle(
              fontSize: 10,
              color: isMinha
                  ? Colors.white.withOpacity(0.7)
                  : const Color(0xFF999999),
            ),
          ),
        ),
      ],
    );
  }
}
