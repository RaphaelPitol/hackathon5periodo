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
                children: [
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text('$responsavel_nome', style: TextStyle(fontSize: 20),),
                          leading: Text('Nome:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                        const Divider(color: Colors.black38, height: 1, thickness: 0, endIndent: 20,indent: 20,),
                        ListTile(
                          title: Text('$responsavel_cpf', style: TextStyle(fontSize: 20),),
                          leading: Text('CPF:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                        const Divider(color: Colors.black38,height: 1, thickness: 0,endIndent: 20,indent: 20,),
                        ListTile(
                          title: Text('$responsavel_telefone', style: TextStyle(fontSize: 20),),
                          leading: Text('Telefone:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
        );
    }
  }

