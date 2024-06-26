import 'package:app_flutter/ui/widgets/barra_titulo.dart';
import 'package:flutter/material.dart';

class HistoricoMedicoPage extends StatefulWidget {
  const HistoricoMedicoPage({Key? key}) : super(key: key);

  @override
  _HistoricoMedicoPageState createState() => _HistoricoMedicoPageState();
}

class _HistoricoMedicoPageState extends State<HistoricoMedicoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: BarraTitulo(),
        ),
        backgroundColor: Colors.blueAccent.shade700,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      body: Center(
        child: Text('Conteúdo do Histórico Médico'),
      ),
    );
  }
}
