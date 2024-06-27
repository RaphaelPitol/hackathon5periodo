
import 'package:app_flutter/ui/pages/dados_usuario_page.dart';
import 'package:app_flutter/ui/pages/agendar_visita_page.dart';
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
    final PageController _pageController = PageController(
        viewportFraction: 0.8);

    int _currentPage = 0;

    final _listSlide = [
      {
        'id': 0,
        'img': 'assets/img/imagem1.jpg',
        'cor': Colors.brown[100],
        'titulo': '',
        'texto':
        'De acordo com o Ministério da Saúde, apenas 62% dos idosos '
            'tomaram a vacina da gripe neste ano; '
            'enquanto pouco mais de 12 milhões de pessoas '
            'acima de 60 anos tomaram a dose de reforço da '
            'vacina bivalente contra a Covid-19 – para efeito comparativo, '
            '30 milhões de idosos receberam a primeira dose da vacina no '
            'ápice da pandemia.'
      },
      {
        'id': 1,
        'img': 'assets/img/imagem2.jpg',
        'cor': Colors.brown[200],
        'titulo': 'Calendário vacinal do idoso:'
        ,
        'texto': 'vacinas impulsionam a longevidade e o bem-estar da população acima de 60 anos\n'
            'Dupla adulto, Influenza e Covid-19 estão entre os imunizantes recomendados aos mais velhos;\n'
            'Dia Internacional da Pessoa Idosa é oportunidade para reforçar a relevância do produto, '
            'que também impede a evolução de quadros mais graves das doenças.'
      },
      {
        'id': 2,
        'img': 'assets/img/imagem3.jpg',
        'cor': Colors.brown[100],
        'titulo': 'Confira o Calendário de Vacinação para Idosos',
        'texto': 'Idosos (A partir dos 60 anos)\n'
            'Hepatite B - Três doses\n'
            'Febre amarela – Dose única, verificar situação vacinal\n'
            'Tríplice viral – Se nunca vacinado: 2 doses (20 a 29 anos) e 1 dose (30 a 49 anos)\n'
            'Dupla adulto (DT) – Reforço a cada 10 anos\n'
            'Pneumocócica 23 Valente – Dose única\n'
      },
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

    void rotaPagina(BuildContext context, Widget destino) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  destino),
      );
    }


    @override
    Widget build(BuildContext context) {
      List<Map> listaMenu = [

        {"Texto": "Usuário", "Clique": () => rotaPagina(context, const DadosUsuario())},
        {
          "Texto": "Página Inicial",
          "Clique": () => rotaPagina(context, const InicioPage())
        },
        {
          "Texto": "Cadastrar Idoso",
          "Clique": () => rotaPagina(context, const CadastroIdosoPage())
        },
        {
          "Texto": "Histórico Médico",
          "Clique": () => rotaPagina(context, const HistoricoMedicoPage())
        },

        {
          "Texto": "Agendar Visita",
          "Clique": () => rotaPagina(context, const  AgendarVisitaPage())
        },


        {"Texto": "Agendamentos", "Clique": () => rotaPagina(context, const AgendarVisitaPage())},



        {"Texto": "Sair", "Clique": () => _confirmarLogout(context)},
      ];

      return Scaffold(
        appBar: AppBar(
          title:  const BarraTitulo(),
          backgroundColor: Colors.blueAccent.shade700,
          elevation: 5,
          shadowColor: Colors.black45,
        ),
        drawer: MenuLateral(listaItens: listaMenu),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: _listSlide.length,
                    itemBuilder: (_, currentIndex) {
                      bool activePage = currentIndex == _currentPage;
                      return CarroselHome(
                        activePage: activePage,
                        titulo: _listSlide[currentIndex]['titulo'] as String,
                        img: _listSlide[currentIndex]['img'] as String? ?? '',
                        cor: _listSlide[currentIndex]['cor'] as Color,
                        texto: _listSlide[currentIndex]['texto'] as String,
                      );
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
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _listSlide.map((i) {
            return InkWell(
              onTap: () {
                setState(() {
                  _pageController.jumpToPage(i['id'] as int);
                  _currentPage = i['id'] as int;
                });
              },
              child:
              Container(
                margin: const EdgeInsets.all(10),
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
