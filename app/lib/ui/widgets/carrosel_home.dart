import 'package:flutter/material.dart';

class CarroselHome extends StatelessWidget {
  const CarroselHome({ required this.cor, required this.activePage , super.key});

  final cor;
  final bool activePage;

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
    );
  }
}




