import 'package:flutter/material.dart';
import 'package:app_flutter/ui/pages/home_page.dart';
import 'package:app_flutter/ui/pages/login_page.dart';
import 'package:app_flutter/ui/pages/historico_medico_page.dart';
import 'package:app_flutter/ui/pages/vacinas_pendentes_page.dart';
import 'package:app_flutter/ui/pages/cadastrar_usuario_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Autenticação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/historico_medico': (context) => HistoricoMedicoPage(),
        '/vacinas_pendentes': (context) => VacinasPendentesPage(),
        '/cadastrar_usuario': (context) => CadastrarUsuarioPage(),
      },
    );
  }
}
