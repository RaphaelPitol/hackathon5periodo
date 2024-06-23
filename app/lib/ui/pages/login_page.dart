import 'package:app_flutter/config.dart';
import 'package:app_flutter/ui/pages/home_page.dart';
import 'package:app_flutter/ui/widgets/campo_texto_cpf.dart';
import 'package:flutter/material.dart';
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Center(
            child: Image(
              image: NetworkImage("https://www.alfaumuarama.edu.br/fau/images/logo_novo.png?v=1719030877"),
              width: 400,
            ),
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
                    const SizedBox(height: 30,
                      child: Text('Digite os dados de acesso nos campos abaixo.',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child:
                      CampoCPF(campo: 'CPF', label: 'Digite seu CPF',
                          controller: _cpfController, teclado: TextInputType.text, valor: 'cpf',tipo: false),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child:
                      CampoCPF(campo: 'SENHA', label: 'Digite sua senha',
                          controller: _passwordController, teclado: TextInputType.text, valor: 'senha', tipo: true),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
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
                          foregroundColor: Colors.black45,
                          backgroundColor: Colors.greenAccent,
                        ),
                        child: const Text('ENTRAR', style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  final snackBar = const SnackBar(
    content: Text(
      'cpf ou senha são invaliidos',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );


  login() async {
    var url = Uri.parse('$linkApi/login');
    Map<String, dynamic> body = {
      'cpf': _cpfController.text,
      'password': _passwordController.text
    };
    var response = await http.post(url, body: body);
    if(response.statusCode == 200){

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));

    } else {
      var snackBar = const SnackBar(
        content: Text('Confira seu cpf e senha'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}