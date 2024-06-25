import 'package:app_flutter/ui/widgets/barra_titulo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_flutter/config.dart';
class CadastrarUsuarioPage extends StatefulWidget {
  const CadastrarUsuarioPage({super.key});

  @override
  State<CadastrarUsuarioPage> createState() => _CadastrarUsuarioPageState();
}

class _CadastrarUsuarioPageState extends State<CadastrarUsuarioPage> {

  final _formKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(

        ),
        backgroundColor: Colors.blueAccent.shade700,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Cadastro de Responsável", style: TextStyle(fontSize: 20),),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    hintText: '000.000.000-00',
                    border: OutlineInputBorder(),
                  ),
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha seu CPF';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite seu nome',
                    border: OutlineInputBorder(),
                  ),
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha seu nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    hintText: 'Digite seu telefone',
                    border: OutlineInputBorder(),
                  ),
                  controller: _telefoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha seu telefone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Digite sua senha',
                    border: OutlineInputBorder(),
                  ),
                  controller: _senhaController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha sua senha';
                    } else if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool success = await cadastrarUsuario();
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Usuário cadastrado com sucesso!')),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao cadastrar usuário.')),
                        );
                      }
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> cadastrarUsuario() async {
    var url = Uri.parse('$linkApi/create');
    var response = await http.post(
      url,
      body: jsonEncode({
        'cpf': _cpfController.text,
        'nome': _nomeController.text,
        'telefone': _telefoneController.text,
        'password': _senhaController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200; // Sucesso no cadastro
  }
}
