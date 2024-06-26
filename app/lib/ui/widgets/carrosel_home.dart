import 'package:flutter/material.dart';

class CarroselHome extends StatelessWidget {
   CarroselHome({ required this.titulo,required this.img, required this.cor, required this.texto, required this.activePage , super.key});

  final cor;
  final String texto;
  final bool activePage;
  final String img;
  final String titulo;

  @override
  Widget build(BuildContext context) {

    final double top = this.activePage ? 50: 150;
    final double blur = this.activePage ? 30: 0;
    final double offset = this.activePage ? 20 : 0;

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(top: top, bottom: 70, right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow:   [
           BoxShadow(
            color: Colors.black54,
            blurRadius: blur,
            offset: Offset(offset, offset)
          )
        ],
        color: cor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.contain,
              ),
            ),
            height: 180,
          ),
          SizedBox(height: 16),
          Center(
            child: Padding(
            padding: const EdgeInsets.all(16),
              child: Column(
               children: <Widget>[
                 Text(titulo,style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(texto, style: TextStyle(fontSize: 15, letterSpacing: 1.5),),
               ],
              )
            ),
          ),
        ],
      ),
    );
  }
}




