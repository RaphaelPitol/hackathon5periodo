import 'package:flutter/material.dart';

class HistoricoMedico extends StatefulWidget {
  const HistoricoMedico({super.key});

  @override
  State<HistoricoMedico> createState() => _HistoricoMedicoState();
}

class _HistoricoMedicoState extends State<HistoricoMedico> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text('Histórico Médico pai'),
        )
class HistoricoMedicoPage extends StatelessWidget {
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