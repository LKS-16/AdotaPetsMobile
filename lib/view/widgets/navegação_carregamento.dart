import 'package:adota_pets_mobile/view/tela_carregamento.dart';
import 'package:flutter/material.dart';

Future<void> navegarComCarregamento(
  BuildContext context, {
  required Widget destino,
  int duracaoMs = 800,
}) async {
  // Vai para a tela de carregamento
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => const TelaCarregamento(),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 200),
    ),
  );

  await Future.delayed(Duration(milliseconds: duracaoMs));

  if (!context.mounted) return;

  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => destino,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    ),
  );
}