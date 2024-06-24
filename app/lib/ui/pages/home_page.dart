import 'package:app_flutter/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cadastro_idoso_page.dart';
import 'historico_medico_page.dart';
import 'inicio_page.dart';
import '../widgets/menu_lateral.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _abrirHistoricoMedico(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoricoMedicoPage()),
    );
  }

  void _abrirCadastroIdoso(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadastroIdosoPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map> listaMenu = [
      {"Texto": "Página Inicial", "Clique": () => _abrirPaginaInicial(context)},
      {"Texto": "Cadastrar Idoso", "Clique": () => _abrirCadastroIdoso(context)},
      {"Texto": "Histórico Médico", "Clique": () => _abrirHistoricoMedico(context)},
      {"Texto": "Vacinas Pendentes", "Clique": () {} },
      {"Texto": "Sair", "Clique": () => _confirmarLogout(context)},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.vaccines_outlined, color: Colors.white, size: 40),
                SizedBox(width: 8),
                Text('Saúde Sênior', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ],
            ),
            Text('Bem Vindo, $responsavel_nome', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        backgroundColor: Colors.blueAccent.shade700,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      drawer: MenuLateral(listaItens: listaMenu),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _abrirHistoricoMedico(context),
              child: Text('Histórico Médico'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vacinas_pendentes');
              },
              child: Text('Vacinas Pendentes'),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirPaginaInicial(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false,
    );
  }

  void _confirmarLogout(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Certeza que quer sair?'),
          content: Text('Depois disso, você será deslogado'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => _logout(context),
              child: Text('Sair'),
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => InicioPage()),
    );
  }
}
