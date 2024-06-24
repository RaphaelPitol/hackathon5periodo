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
        title: Text('Histórico Médico'),
      ),
      body: Center(
        child: Text('Conteúdo do Histórico Médico'),
      ),
    );
  }
}
