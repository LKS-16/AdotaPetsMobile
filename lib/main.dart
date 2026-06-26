import 'package:adota_pets_mobile/view/modelo/controller/favoritos_controller.dart';
import 'package:adota_pets_mobile/view/modelo/controller/theme_controller.dart';
import 'package:adota_pets_mobile/view/pages/tela_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => FavoritosController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AdotaPets',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD35400),
          primary: const Color(0xFFD35400),
          surface: Colors.white,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xFFD35400),
          surface: const Color(0xFF1E1E1E),
        ),
      ),

      themeMode: themeController.currentThemeMode,
      home: TelaLogin(),
    );
  }
}
