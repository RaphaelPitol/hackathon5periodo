import 'dart:convert';

import 'package:app_flutter/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IdosoDetailPage extends StatelessWidget {
  final Map<String, dynamic> idoso;

  const IdosoDetailPage({Key? key, required this.idoso}) : super(key: key);

  Future<Map<String, dynamic>> fetchVaccineData(String id) async {
    final naoVacinadoResponse = await http.get(Uri.parse('$linkApi/shownaovacinado/$id'));
    final vacinadoResponse = await http.get(Uri.parse('$linkApi/showvacinado/$id'));

    if (naoVacinadoResponse.statusCode == 200 && vacinadoResponse.statusCode == 200) {
      final naoVacinadoData = jsonDecode(naoVacinadoResponse.body);
      final vacinadoData = jsonDecode(vacinadoResponse.body);

      print(naoVacinadoData);
      print(vacinadoData);

      return {
        'naoVacinado': naoVacinadoData['vacinas_nao_tomadas'] ?? [],
        'vacinado': vacinadoData['vacinado'] ?? [],
      };
    } else {
      throw Exception('Failed to load vaccine data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(idoso['nome']),
        backgroundColor: Colors.blueAccent.shade700,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchVaccineData(idoso['id'].toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final naoVacinado = snapshot.data!['naoVacinado'] ?? [];
            final vacinado = snapshot.data!['vacinado'] ?? [];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const Text(
                    'Vacinas Pendentes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                  const Divider(color: Colors.redAccent, thickness: 1),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: naoVacinado.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: ListTile(
                          leading: Icon(Icons.vaccines, color: Colors.redAccent),
                          title: Text(
                            naoVacinado[index],
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Vacinas Realizadas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const Divider(color: Colors.green, thickness: 1),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vacinado.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: ListTile(
                          leading: Icon(Icons.vaccines, color: Colors.green),
                          title: Text(
                            vacinado[index],
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}