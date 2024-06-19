import 'dart:convert';

import 'package:app_flutter/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child:
                TextFormField(

                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    hintText: '000.000.000-00',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent), // Borda ao focar
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Borda ao habilitar
                    ),
                  ),

                  controller: _cpfController,
                  keyboardType: TextInputType.text,
                  validator: (cpf) {
                    if(cpf == null || cpf.isEmpty){
                      return 'Preencha seu CPF!';
                    }
                    return null;
                  },
                ),
              ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'SENHA',
                hintText: 'Digite sua senha',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent), // Borda ao focar
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Borda ao habilitar
                ),
              ),

              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              validator: (senha) {
                if(senha == null || senha.isEmpty){
                  return 'Preenche sua senha!';
                } else if(senha.length < 6) {
                  return 'Por favor digite uma senha maior que 6 caracteres';
                }
                return null;
              },
            ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(top: 50.0), // Adiciona margem superior ao botão
                  child: ElevatedButton(
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                    if(_formKey.currentState!.validate()){
                      bool deuCerto = await login();
                    if(!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if(deuCerto) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),
                        ),
                      );
                    } else {
                      _passwordController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                    ),
                    child: const Text('ENTRAR'),

                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
  
  final snackBar = const SnackBar(
      content: Text(
        'cpf ou senha são invaliidos',
        textAlign: TextAlign.center,
      ),
        backgroundColor: Colors.redAccent,
  );

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://minhasapis.com.br/login/');
    var resposta = await http.post(
      url,
    body: {
      'username': _cpfController.text,
      'password': _passwordController.text
    },
    );

    if(resposta.statusCode == 200){
      await sharedPreferences.setString('token', "Token${jsonDecode(resposta.body)['token']}");
      return true;
    } else {
      return false;
    }
  }
}
