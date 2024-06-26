import 'dart:convert';
import 'package:app_flutter/config.dart';
import 'package:app_flutter/ui/pages/idoso_detalhe_page.dart';
import 'package:app_flutter/ui/widgets/barra_titulo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoricoMedicoPage extends StatefulWidget {
  const HistoricoMedicoPage({Key? key}) : super(key: key);

  @override
  _HistoricoMedicoPageState createState() => _HistoricoMedicoPageState();
}

class _HistoricoMedicoPageState extends State<HistoricoMedicoPage> {
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
        idosos = (data['idosos'] as Map<String, dynamic>).values.map((idoso) {
          return idoso as Map<String, dynamic>;
        }).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load idoso data');
    }
  }

  void _navigateToDetails(Map<String, dynamic> idoso) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IdosoDetailPage(idoso: idoso),
      ),
    );
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
                subtitle: Text('Comorbidade: ${idoso['comorbidade']}'),
                onTap: () => _navigateToDetails(idoso),
              ),
            );
          },
        ),
      ),
    );
  }
}

