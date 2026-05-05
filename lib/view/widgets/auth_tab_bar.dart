

import 'package:adota_pets_mobile/view/widgets/tab.dart';
import 'package:flutter/cupertino.dart';

class AuthTabBar extends StatelessWidget {
  final bool isLogin;
  // final VoidCallback? onLoginTap;
  // final VoidCallback? onRegisterTap;

  const AuthTabBar({
    super.key,
    required this.isLogin,
    // this.onLoginTap,
    // this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFEAE4DD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Tab(label: 'Entrar', isActive: isLogin, onTap: () {}),
          Tab(label: 'Cadastrar', isActive: !isLogin, onTap: () {}),
        ],
      ),
    );
  }
}