import 'dart:convert';

import 'package:app_flutter/config.dart';
import 'package:app_flutter/ui/widgets/barra_titulo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroIdosoPage extends StatefulWidget {
  const CadastroIdosoPage({super.key});

  @override
  State<CadastroIdosoPage> createState() => _CadastroIdosoPageState();
}

class _CadastroIdosoPageState extends State<CadastroIdosoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cepController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _numeroController = TextEditingController();
  final _comorbidadesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: BarraTitulo(),
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
                const Text("Cadastro de Idoso", style: TextStyle(fontSize: 20),),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite o nome',
                    border: OutlineInputBorder(),
                  ),
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento',
                    hintText: 'DD/MM/AAAA',
                    border: OutlineInputBorder(),
                  ),
                  controller: _dataNascimentoController,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha a data de nascimento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    hintText: 'Digite o telefone',
                    border: OutlineInputBorder(),
                  ),
                  controller: _telefoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o telefone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'CEP',
                    hintText: 'Digite o CEP',
                    border: OutlineInputBorder(),
                  ),
                  controller: _cepController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o CEP';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                    hintText: 'Digite a cidade',
                    border: OutlineInputBorder(),
                  ),
                  controller: _cidadeController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha a cidade';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    hintText: 'Digite o endereço',
                    border: OutlineInputBorder(),
                  ),
                  controller: _enderecoController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o endereço';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Número',
                    hintText: 'Digite o número',
                    border: OutlineInputBorder(),
                  ),
                  controller: _numeroController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o número';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Comorbidades',
                    hintText: 'Digite as comorbidades',
                    border: OutlineInputBorder(),
                  ),
                  controller: _comorbidadesController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha as comorbidades';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool success = await cadastrarIdoso();
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Idoso cadastrado com sucesso!')),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao cadastrar idoso.')),
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

  Future<bool> cadastrarIdoso() async {
    var url = Uri.parse('$linkApi/createidoso');
    var response = await http.post(
      url,
      body: jsonEncode({
        'nome': _nomeController.text,
        'data_nascimento': _dataNascimentoController.text,
        'telefone': _telefoneController.text,
        'cep': _cepController.text,
        'cidade': _cidadeController.text,
        'endereco': _enderecoController.text,
        'numero': _numeroController.text,
        'comorbidade': _comorbidadesController.text,
        'responsavel_id': responsavel_id
      }),
      headers: {'Content-Type': 'application/json'},
    );

    //print("--------------");
   // var data = jsonDecode(response.body);

   // print(data['idoso']);
    return response.statusCode == 200; // Sucesso no cadastro
  }
}
