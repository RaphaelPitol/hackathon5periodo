import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class CampoCPF extends StatelessWidget {
  final String campo;
  final TextEditingController controller;
  final TextInputType teclado;
  final String label;
  final String error;
  final valor;
  final tipo;

  const CampoCPF({required this.controller,this.tipo, this.valor, this.campo = '',
    this.label = '', this.error = '', this.teclado = TextInputType.text,super.key});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      style: TextStyle(color: Colors.white70),
      decoration:  InputDecoration(
        labelText: campo,
        labelStyle: TextStyle(color: Colors.white70, fontSize: 14),
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
        suffixStyle: TextStyle(color: Colors.white, fontSize: 14),
        fillColor: Colors.black12,
        filled: true,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7),
            )),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        enabledBorder: const  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),

      controller: controller,
      obscureText: tipo,
      keyboardType: teclado,
      validator: (valor) {
        if(valor == null || valor.isEmpty){
          return "Preencha os Campos!";
        }
        return null;
      },
    );
  }
}