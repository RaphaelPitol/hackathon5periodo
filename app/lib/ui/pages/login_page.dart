import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                validator: (cpf) {
                  if(cpf == null || cpf.isEmpty){
                    return 'Por favor, digite seu cpf';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                validator: (senha) {
                  if(senha == null || senha.isEmpty) {
                    return 'Por favor, digite sua senha';
                  } else if(senha.length < 6) {
                    return 'Por favor, digite uma senha maior que 6 caracteres';
                  }
                  return null;
                },

              ),
              ElevatedButton(onPressed: (){}, child: Text('ENTRAR'),),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://minhasapis.com.br/login/');
  }
}
