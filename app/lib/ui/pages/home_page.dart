import 'package:app_flutter/ui/widgets/barra_titulo.dart';
import 'package:app_flutter/ui/widgets/carrosel_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cadastro_idoso_page.dart';
import 'historico_medico_page.dart';
import 'inicio_page.dart';
import '../widgets/menu_lateral.dart';


  class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
}

  class _HomePageState extends State<HomePage> {
    final PageController _pageController = PageController(viewportFraction: 0.8);

    int _currentPage = 0;

    var _listSlide = [
      {'id': 0, 'cor': Colors.blue},
      {'id': 1, 'cor': Colors.red},
      {'id': 2, 'cor': Colors.green}
    ];

  @override
  void initState() {
    _pageController.addListener(() {
      int next = _pageController.page?.round() ?? 0;
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
    super.initState();
  }

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
          title:  Container(
            child: BarraTitulo(),
          ),
          backgroundColor: Colors.blueAccent.shade700,
          elevation: 5,
          shadowColor: Colors.black45,
        ),
        drawer: MenuLateral(listaItens: listaMenu),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget> [
              Expanded(
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: _listSlide.length,
                    itemBuilder: (_ , currentIndex) {
                      bool activePage = currentIndex == _currentPage;
                      return CarroselHome(
                        activePage: activePage,
                        cor:  _listSlide[currentIndex]['cor'],);
                    }
                ),
              ),
              _buildBullets()
            ],
          ),
        ),
      );
    }

    Widget _buildBullets() {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _listSlide.map((i) {
              return InkWell(
                onTap: (){
                  setState(() {
                    _pageController.jumpToPage(i['id'] as int);
                    _currentPage = i['id'] as int;
                  });
                },
              child:
                Container(
                margin: EdgeInsets.all(10),
                width: 10,
                  height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                          color: _currentPage == i['id'] ? Colors.red : Colors.grey,
                    ),
                ),
              );
            }).toList(),
        ),
      );
      }
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
            content: const Text('Depois disso, você será deslogado'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => _logout(context),
                child: const Text('Sair'),
              ),
            ],
          );
        },
      );
    }

    void _logout(BuildContext context) async {
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
