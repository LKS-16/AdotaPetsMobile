import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final void Function(String texto) onEnviarTexto;
  final VoidCallback onEnviarImagem;

  const ChatInput({
    super.key,
    required this.onEnviarTexto,
    required this.onEnviarImagem,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  bool _temTexto = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _temTexto = _controller.text.trim().isNotEmpty);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _enviar() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;
    widget.onEnviarTexto(texto);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          // Botão de imagem
          GestureDetector(
            onTap: widget.onEnviarImagem,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.image_outlined,
                color: Color(0xFF888888),
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Campo de texto
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 4,
                minLines: 1,
                textInputAction: TextInputAction.newline,
                style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
                decoration: const InputDecoration(
                  hintText: 'Digite uma mensagem...',
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFFAAAAAA)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Botão enviar
          GestureDetector(
            onTap: _temTexto ? _enviar : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _temTexto
                    ? const Color(0xFFE8622A)
                    : const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.send_rounded,
                color: _temTexto ? Colors.white : const Color(0xFFBBBBBB),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
