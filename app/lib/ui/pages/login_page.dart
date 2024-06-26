import 'dart:convert';

import 'package:app_flutter/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cadastro_usuario_page.dart';
import 'home_page.dart';
import '../widgets/campo_texto_cpf.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLogin();
  }

  void _loadLogin() async {
    var loginData = await getLogin();
    if (loginData['cpf'] != null) {
      setState(() {
        _cpfController.text = loginData['cpf']!;
        _passwordController.text = loginData['password']!;
      });
    }
  }

  Future<void> saveLogin(String cpf, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cpf', cpf);
    await prefs.setString('password', password);
  }

  Future<Map<String, String?>> getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cpf = prefs.getString('cpf');
    String? password = prefs.getString('password');
    return {'cpf': cpf, 'password': password};
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(27),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey,
              Colors.lightBlueAccent,
              Colors.lightBlueAccent,
              Colors.blueGrey,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.vaccines_outlined, color: Colors.white, size: 100),
                  const SizedBox(
                    height: 30,
                    child: Text(
                      'Digite os dados de acesso nos campos abaixo.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),

                    child: CampoCPF(
                      campo: 'CPF',
                      label: 'Digite seu CPF',
                      controller: _cpfController,
                      teclado: TextInputType.text,
                      valor: 'cpf',
                      tipo: false,
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    child: CampoCPF(
                      campo: 'SENHA',
                      label: 'Digite sua senha',
                      controller: _passwordController,
                      teclado: TextInputType.text,
                      valor: 'senha',
                      tipo: true,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (_formKey.currentState!.validate()) {
                          bool success = await login();
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          } else {
                            _passwordController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black45,
                        backgroundColor: Colors.greenAccent,
                      ),
                      child: const Text(
                        'ENTRAR',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastrarUsuarioPage(),
                        ),
                      );
                    },
                    child: Text("Cadastre-se"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final snackBar = const SnackBar(
    content: Text(
      'CPF ou senha incorretos!',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  Future<bool> login() async {
    var url = Uri.parse('$linkApi/login');
    var response = await http.post(
      url,
      body: jsonEncode({
        'cpf': _cpfController.text,
        'password': _passwordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);

      responsavel_nome = userData["responsavel"]["nome"];
      responsavel_id = userData["responsavel"]["id"];
      responsavel_telefone = userData["responsavel"]["telefone"];
      responsavel_cpf = userData["responsavel"]["cpf"];

      // Salvar o token no SharedPreferences
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', userData['token']);

      // Salvar login para reuso futuro
      await saveLogin(_cpfController.text, _passwordController.text);

      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }
}

