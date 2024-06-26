import 'package:app_flutter/config.dart';
import 'package:app_flutter/ui/pages/dados_usuario_page.dart';
import 'package:flutter/material.dart';

class BarraTitulo extends StatelessWidget {
  const BarraTitulo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.vaccines_outlined, color: Colors.white, size: 40),
              SizedBox(width: 8),
              Text('Saúde Sênior', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
              ],
          ),
        ],
      ),
    );
  }
}
