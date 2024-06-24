import 'package:app_flutter/config.dart';
import 'package:app_flutter/ui/pages/cadastro_idoso_page.dart';
import 'package:app_flutter/ui/pages/historico_medico_page.dart';
import 'package:app_flutter/ui/pages/inicio_page.dart';
import 'package:app_flutter/ui/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
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

  void _abrirCadastroIdoso(){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CadastroIdosoPage()));
  }

  @override
  Widget build(BuildContext context) {

    listaMenu = [
      {"Texto": "Página Inicial", "Clique": () { _abrirPaginaInicial();} },
      {"Texto": "Cadastrar Idoso", "Clique": () { _abrirCadastroIdoso();} },
      {"Texto": "Histórico Médico", "Clique": () { _abrirHistoricoMedico();} },
      {"Texto": "Vacinas Pendentes", "Clique": () {} },
      {"Texto": "Sair", "Clique": () { _confirmarLogout();} },

    ];
    return Placeholder(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             const Row(
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
        body: Column(
          children: [
            Text("Nome do Responsavel: "+ responsavel_nome)

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/historico_medico');
              },
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