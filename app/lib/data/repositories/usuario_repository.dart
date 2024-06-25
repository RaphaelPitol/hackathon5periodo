import 'package:app_flutter/config.dart'; // Importe o arquivo config.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/usuario.dart';

class UsuarioRepository {
  Future<bool> cadastrarUsuario(Usuario usuario) async {
    var url = Uri.parse('$linkApi/cadastrar_usuario');
    var resposta = await http.post(
      url,
      body: {
        'cpf': usuario.cpf,
        'nome': usuario.nome,
        'telefone': usuario.telefone,
        'email': usuario.email,
        'senha': usuario.senha,
      },
    );
    return resposta.statusCode == 200;
  }

// Implemente métodos para atualizar, excluir e buscar usuários conforme necessário
}
