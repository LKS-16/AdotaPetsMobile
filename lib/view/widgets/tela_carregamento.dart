import 'package:adota_pets_mobile/view/pages/feed.dart';
import 'package:adota_pets_mobile/view/pages/navega%C3%A7%C3%A3o_carregamento.dart';
import 'package:flutter/material.dart';

class TelaCarregamento extends StatefulWidget {
  const TelaCarregamento({super.key});

  @override
  State<TelaCarregamento> createState() => _TelaCarregamentoState();
}

class _TelaCarregamentoState extends State<TelaCarregamento>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _escalaAnimation;
  late Animation<double> _opacidadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _escalaAnimation = Tween<double>(
      begin: 0.85,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacidadeAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      navegarComCarregamento(context, destino: Feed(), duracaoMs: 1800);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EE),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone animado
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return Transform.scale(
                  scale: _escalaAnimation.value,
                  child: Opacity(
                    opacity: _opacidadeAnimation.value,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8622A),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE8622A).withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.pets,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Texto de carregamento
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return Opacity(
                  opacity: _opacidadeAnimation.value,
                  child: const Text(
                    'Carregando...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF888888),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
