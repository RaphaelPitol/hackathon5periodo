import 'dart:convert';
import 'package:app_flutter/config.dart';
import 'package:app_flutter/ui/pages/idoso_detalhe_page.dart';
import 'package:app_flutter/ui/widgets/barra_titulo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AgendarVisitaPage extends StatefulWidget {
  const AgendarVisitaPage({Key? key}) : super(key: key);

  @override
  _AgendarVisitaPageState createState() => _AgendarVisitaPageState();
}

class _AgendarVisitaPageState extends State<AgendarVisitaPage> {
  List<Map<String, dynamic>> idosos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchIdosoData();
  }

  Future<void> fetchIdosoData() async {
    final response = await http.get(Uri.parse('$linkApi/getidososrespo/$responsavel_id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        idosos = List<Map<String, dynamic>>.from(data['idosos']);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load idoso data');
    }
  }


  Future<void> _navigateToDetails(String id) async {
    List<Map<String, dynamic>> ag = [];
    final response = await http.get(Uri.parse('$linkApi/showagenda/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print("-----------");
     //print(data['agenda'][0]['data_hora']);
      print("-----------");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Detalhes do Agendamento'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Mensagem: ${data['mensagen'] ?? 'Sem mensagem'}'),
                  Text('Agenda: ${data['agenda'] != null ?
                  _formatDate(data['agenda'][0]['data_hora'])
                      :
                  'Sem agenda'}'),

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Não foi possível carregar os detalhes.'),
            actions: <Widget>[
              TextButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  String _formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BarraTitulo(),
        backgroundColor: Colors.blueAccent.shade700,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: idosos.length,
          itemBuilder: (context, index) {
            final idoso = idosos[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.blueAccent.shade700),
                title: Text(
                  idoso['nome'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => _navigateToDetails(idoso['id'].toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}
