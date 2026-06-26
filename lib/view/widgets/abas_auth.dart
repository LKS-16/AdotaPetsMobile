import 'package:adota_pets_mobile/view/pages/tela_cadastro.dart';
import 'package:adota_pets_mobile/view/pages/tela_login.dart';
import 'package:adota_pets_mobile/view/widgets/aba.dart';
import 'package:flutter/material.dart';

class AbasAuth extends StatelessWidget {
  final bool isLogin;
  final VoidCallback? onLoginTap;
  final VoidCallback? onRegisterTap;

  const AbasAuth({
    super.key,
    required this.isLogin,
    this.onLoginTap,
    this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: cores.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Aba(
            label: 'Entrar',
            isActive: isLogin,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TelaLogin()),
            ),
          ),
          Aba(
            label: 'Cadastrar',
            isActive: !isLogin,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TelaCadastro()),
            ),
          ),
        ],
      ),
    );
  }
}
