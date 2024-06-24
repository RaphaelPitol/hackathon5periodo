import 'package:flutter/material.dart';

class HistoricoMedicoPage extends StatefulWidget {
  const HistoricoMedicoPage({super.key});

  @override
  State<HistoricoMedicoPage> createState() => _HistoricoMedicoState();
}

class _HistoricoMedicoState extends State<HistoricoMedicoPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text('Histórico Médico pai'),
        ),
    );
  }
}