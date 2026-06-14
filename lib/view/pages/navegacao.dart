import 'package:adota_pets_mobile/view/pages/feed.dart';
import 'package:adota_pets_mobile/view/pages/tela_configuracoes.dart';
import 'package:adota_pets_mobile/view/pages/tela_conversas.dart';
import 'package:adota_pets_mobile/view/pages/tela_favoritos.dart';
import 'package:adota_pets_mobile/view/pages/tela_meus_pets.dart';
import 'package:adota_pets_mobile/view/pages/tela_perfil.dart';
import 'package:adota_pets_mobile/view/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class Navegacao extends StatefulWidget {
  const Navegacao({super.key});

  @override
  State<Navegacao> createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Navegacao> {
  int _currentIndex = 0;

  void _navegarPara(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _telas = [
      Feed(),
      const TelaFavoritos(),
      const TelaMeusPets(pets: []),
      const TelaConversas(conversas: []),
      const TelaPerfilPessoa(),
      const TelaConfiguracoes(),
    ];

    final List<String> _titulos = [
      "AdotaPets",
      "Favoritos",
      "Meus Pets",
      "Conversas",
      "Perfil",
      "Configurações",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titulos[_currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: AppDrawer(
        selectedIndex: _currentIndex,
        onItemSelected: _navegarPara,
      ),
      body: _telas[_currentIndex],
    );
  }
}
