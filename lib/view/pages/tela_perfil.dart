import 'package:adota_pets_mobile/view/pages/tela_login.dart';
import 'package:adota_pets_mobile/view/services/auth_user_service.dart';
import 'package:adota_pets_mobile/view/widgets/botao_sair.dart';
import 'package:adota_pets_mobile/view/widgets/perfil_cabe%C3%A7alho.dart';
import 'package:adota_pets_mobile/view/widgets/perfil_estaticas.dart';
import 'package:flutter/material.dart';

class TelaPerfilPessoa extends StatelessWidget {
  const TelaPerfilPessoa({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthUserService authUserService = AuthUserService();
    final usuario = authUserService.usuarioAtual;
    final String nome = usuario?.displayName ?? 'Usuário';
    final String email = usuario?.email ?? 'E-mail não encontrado';
    final String anoCriacao = usuario?.metadata.creationTime != null
        ? "${usuario!.metadata.creationTime!.year}"
        : '2026';

    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cores.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Perfil',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: cores.onSurface,
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cores.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: cores.onSurface.withOpacity(0.08)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PerfilCabecalho(
                      nome: nome,
                      email: email,
                      membroDesde: anoCriacao,
                    ),

                    const PerfilEstatisticas(favoritos: 0, pedidos: 0),

                    const SizedBox(height: 16),

                    Divider(
                      height: 1,
                      color: cores.onSurface.withOpacity(0.08),
                    ),

                    const SizedBox(height: 16),

                    PerfilBotaoSair(
                      onSair: () async {
                        await authUserService.deslogar();
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TelaLogin(),
                            ),
                          );
                        }
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
