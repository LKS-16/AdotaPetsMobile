import 'package:adota_pets_mobile/view/modelo/controller/theme_controller.dart';
import 'package:adota_pets_mobile/view/widgets/config_item.dart';
import 'package:adota_pets_mobile/view/widgets/config_secao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  bool _notificacoes = false;
  //bool _modoEscuro = false;
  bool _localizacao = false;

  bool _visibilidadePerfil = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Configurações',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: cores.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Gerencie suas preferências',
                style: TextStyle(fontSize: 14, color: cores.onSurfaceVariant),
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
                    valor: themeController.isDarkMode,
                    onChanged: (v) {
                      themeController.alternarTema(v);
                    },
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
                    onChanged: (v) => setState(() => _visibilidadePerfil = v),
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
