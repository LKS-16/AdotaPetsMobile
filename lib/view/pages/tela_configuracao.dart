import 'package:adota_pets_mobile/view/widgets/configuracao_item.dart';
import 'package:adota_pets_mobile/view/widgets/configuracao_secao.dart';
import 'package:flutter/material.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  bool _notificacoes = false;
  bool _modoEscuro = false;
  bool _localizacao = false;

  bool _visibilidadePerfil = false;

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
                'Configurações',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Gerencie suas preferências',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF888888),
                ),
              ),

              const SizedBox(height: 32),

              ConfiguracaoSecao(
                titulo: 'Preferências',
                itens: [
                  ConfiguracaoItem(
                    icone: Icons.notifications_outlined,
                    titulo: 'Notificações',
                    descricao: 'Seja notificado sobre novos pets',
                    valor: _notificacoes,
                    onChanged: (v) => setState(() => _notificacoes = v),
                  ),
                  ConfiguracaoItem(
                    icone: Icons.dark_mode_outlined,
                    titulo: 'Modo Escuro',
                    descricao: 'Alternar tema escuro',
                    valor: _modoEscuro,
                    onChanged: (v) => setState(() => _modoEscuro = v),
                  ),
                  ConfiguracaoItem(
                    icone: Icons.language_outlined,
                    titulo: 'Localização',
                    descricao: 'Mostrar pets perto de você',
                    valor: _localizacao,
                    onChanged: (v) => setState(() => _localizacao = v),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              
              ConfiguracaoSecao(
                titulo: 'Privacidade',
                itens: [
                  ConfiguracaoItem(
                    icone: Icons.shield_outlined,
                    titulo: 'Visibilidade do Perfil',
                    descricao: 'Permitir que abrigos vejam seu perfil',
                    valor: _visibilidadePerfil,
                    onChanged: (v) =>
                        setState(() => _visibilidadePerfil = v),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}