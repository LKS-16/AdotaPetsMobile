import 'package:adota_pets_mobile/view/pages/navegacao.dart';
import 'package:adota_pets_mobile/view/pages/tela_cadastro.dart';
import 'package:adota_pets_mobile/view/services/auth_service.dart';
import 'package:adota_pets_mobile/view/widgets/abas_auth.dart';
import 'package:adota_pets_mobile/view/widgets/botao_login.dart';
import 'package:adota_pets_mobile/view/widgets/campo_texto.dart';
import 'package:adota_pets_mobile/view/widgets/logo_adotapets.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  Future<void> efetuarLogin() async {
    if (emailController.text.isEmpty || senhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
      await authService.loginComEmailESenha(
        emailController.text,
        senhaController.text,
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Navegacao()),
      );
    } catch (mensagemErro) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensagemErro.toString()),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final cores = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LogoAdotapets(),
              const SizedBox(height: 32),
              Text(
                "Bem-vindo de volta!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 6),
              Text(
                "Entre para continuar adotando pets!",
                style: TextStyle(fontSize: 14, color: Color(0xFF888888)),
              ),

              const SizedBox(height: 26),
              AbasAuth(
                isLogin: true,
                onRegisterTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TelaCadastro()),
                ),
              ),

              const SizedBox(height: 24),
              CampoTexto(
                hint: "Seu e-mail",
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),

              const SizedBox(height: 14),
              CampoTexto(
                hint: "Sua senha",
                obscureText: true,
                controller: senhaController,
              ),

              const SizedBox(height: 24),
              BotaoLogin(label: "Entrar", onPressed: efetuarLogin),

              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Não tem conta?",
                      style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
                    ),

                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TelaCadastro()),
                      ),
                      child: Text(
                        "Cadastre-se",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFE8622A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
