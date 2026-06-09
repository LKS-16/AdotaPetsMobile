import 'package:adota_pets_mobile/view/widgets/perfil_botao_sair.dart';
import 'package:adota_pets_mobile/view/widgets/perfil_cabecalho.dart';
import 'package:adota_pets_mobile/view/widgets/perfil_estatisticas.dart';
import 'package:flutter/material.dart';

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Perfil',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PerfilCabecalho(
                      nome: 'Lukas Araujo',
                      email: 'araujolukas093@gmail.com',
                      membroDesde: 'June de 2026',
                    ),

                    PerfilEstatisticas(
                      favoritos: 2,
                      pedidos: 0,
                    ),

                    const SizedBox(height: 16),

                    const Divider(
                      height: 1,
                      color: Color(0xFFF0F0F0),
                    ),

                    const SizedBox(height: 16),

                    PerfilBotaoSair(
                      onSair: () {
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}