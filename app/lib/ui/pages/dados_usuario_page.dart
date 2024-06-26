import 'package:app_flutter/ui/widgets/barra_titulo.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/config.dart';

class DadosUsuario extends StatelessWidget {
  const DadosUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
            title: Container(
              child: BarraTitulo(),
          ),
        backgroundColor: Colors.blueAccent.shade700,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
        body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Text('DadosUsuario'),
                        Text('$responsavel_nome'),
                          Text('$responsavel_telefone'),
                            Text('$responsavel_cpf'),

                  ],
              ),
            )
        );
    }
  }

