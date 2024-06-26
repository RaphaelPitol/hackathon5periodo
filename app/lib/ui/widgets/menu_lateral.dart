import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {

  final List<Map> listaItens;
  const MenuLateral({required this.listaItens,super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          _criarHeader(),
          _criarListaItens(context),
        ],
      ),
    );
  }

  Widget _criarListaItens(BuildContext context) {
    List<Widget> lista = [];
    for (var item in listaItens) {
      lista.add(ListTile(
        title: Text(item["Texto"]),
        onTap: item["Clique"],
      ));
    }
    return Column(children: lista);
  }

  Widget _criarHeader() {
    return DrawerHeader(
      child: Column(
        children: [
          Icon(Icons.vaccines_outlined, color: Colors.blue, size: 60),
          const Text('Menu', style: TextStyle(fontSize: 40),),
        ],
      ),
    );
  }
}