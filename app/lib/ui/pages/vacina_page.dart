import 'dart:convert';
import 'package:app_flutter/config.dart';
import 'package:app_flutter/ui/pages/detalhes_vacina_page.dart';
import 'package:app_flutter/ui/widgets/barra_titulo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VacinaPage extends StatefulWidget {
  const VacinaPage({Key? key}) : super(key: key);

  @override
  State<VacinaPage> createState() => _VacinaPageState();
}

class _VacinaPageState extends State<VacinaPage> {
  List<Map<String, dynamic>> vacinas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVacinaData();
  }

  Future<void> fetchVacinaData() async {
    final response = await http.get(Uri.parse('$linkApi/index'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print(data);
      setState(() {
        vacinas = (data['vacinas'] as List).map((vacina) {
          return vacina as Map<String, dynamic>;
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

  void _navigateToDetails(Map<String, dynamic> vacina) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesVacinaPage(vacina: vacina),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: BarraTitulo(),
        backgroundColor: Colors.blueAccent.shade700,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: vacinas.length,
          itemBuilder: (context, index) {
            final vacina = vacinas[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Icon(
                  Icons.vaccines,
                  color: Colors.blueAccent.shade700,
                  size: 40,
                ),
                title: Text(
                  vacina['nome'] ?? 'Sem nome',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueAccent.shade700,
                ),
                onTap: () => _navigateToDetails(vacina),
              ),
            );
          },
        ),
      ),
    );
  }
}
