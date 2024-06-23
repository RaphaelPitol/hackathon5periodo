import 'package:app_flutter/ui/pages/historico_medico_page.dart';
import 'package:app_flutter/ui/pages/inicio_page.dart';
import 'package:app_flutter/ui/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Map> listaMenu;

  void _abrirPaginaInicial() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomePage()));
  }

  void _abrirHistoricoMedico() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => HistoricoMedico()));
  }

  @override
  Widget build(BuildContext context) {

    listaMenu = [
      {"Texto": "Página Inicial", "Clique": () { _abrirPaginaInicial();} },
      {"Texto": "Histórico Médico", "Clique": () { _abrirHistoricoMedico();} },
      {"Texto": "Vacinas Pendentes", "Clique": () {} },
      {"Texto": "Sair", "Clique": () { _confirmarLogout();} },

    ];
    return Placeholder(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_gas_station_outlined, color: Colors.white, size: 36,),
              SizedBox(width: 8,),
              Text('Página Inicial', style: TextStyle(color: Colors.white),),
            ],
          ),
          backgroundColor: Colors.blueAccent.shade700,
        ),
        drawer: MenuLateral(listaItens: listaMenu),
        body: Column(
          children: [
            Text('TESTEEEEEEEEE')
          ],
        ),
      ),
    );
  }

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context)=>HomePage()),
            (Route<dynamic> route) => false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => InicioPage(),
      ),
    );
  }

  Future<void> _confirmarLogout() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Certeza que quer sair?'),
          content: Text('Depois disso, você será deslogado'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: (){
                logout();
              },
              child: Text('Sair'),),
          ],
        );
      },
    );
  }
}