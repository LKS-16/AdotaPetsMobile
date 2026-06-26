import 'package:adota_pets_mobile/view/pages/tela_login.dart';
import 'package:adota_pets_mobile/view/services/auth_service.dart';
import 'package:adota_pets_mobile/view/widgets/abas_auth.dart';
import 'package:adota_pets_mobile/view/widgets/botao_login.dart';
import 'package:adota_pets_mobile/view/widgets/campo_texto.dart';
import 'package:adota_pets_mobile/view/widgets/logo_adotapets.dart';
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  Future<void> efetuarCadastro() async {
    if (emailController.text.isEmpty ||
        senhaController.text.isEmpty ||
        nomeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
      await authService.cadastrarComEmailESenha(
        emailController.text,
        senhaController.text,
        nomeController.text,
      );

      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TelaLogin()),
      );
    } catch (mensagemErro) {
      if (!context.mounted) return;
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
    final cores = Theme.of(context).colorScheme;

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
                "Crie sua conta!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: cores.onSurface,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Cadastre-se e encontre o seu novo pet!",
                style: TextStyle(fontSize: 14, color: cores.onSurfaceVariant),
              ),
              const SizedBox(height: 28),
              AbasAuth(
                isLogin: false,
                onLoginTap: () => Navigator.pop(context),
              ),

              const SizedBox(height: 24),
              CampoTexto(hint: "Seu nome completo", controller: nomeController),

              const SizedBox(height: 14),
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
              BotaoLogin(label: "Criar conta", onPressed: efetuarCadastro),

              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Já tem conta?",
                      style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Entrar",
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
