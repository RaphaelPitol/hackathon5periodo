import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importar o pacote intl para formatação de data
import 'package:http/http.dart' as http;
import 'dart:convert';

const String linkApi = 'http://10.0.2.2:8000/api';
const idoso_id = 1; // Defina o ID do idoso autenticado conforme necessário

class AgendarVisitaPage extends StatefulWidget {
  const AgendarVisitaPage({super.key});

  @override
  State<AgendarVisitaPage> createState() => _AgendarVisitaPageState();
}

class _AgendarVisitaPageState extends State<AgendarVisitaPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _saveAgendamento() async {
    if (_formKey.currentState!.validate()) {
      String date = dateController.text;
      String time = timeController.text;
      DateTime selectedDateTime = DateFormat('dd/MM/yyyy HH:mm').parse('$date $time');
      String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime);

      var response = await http.post(
        Uri.parse('$linkApi/createagendamento'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'idoso_id': idoso_id,
          'data_hora': formattedDateTime,
          'status': 'a vacinar', // Definindo o status como "a vacinar"
        }),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['success'])),
        );
        Navigator.pop(context); // Voltar à página inicial após sucesso
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Falha ao gravar o agendamento')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Visita'),
        centerTitle: true,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
              padding: const EdgeInsets.all(10), children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text('Agendamento', style: TextStyle(fontSize: 20)),
                      subtitle: Text('Data e hora da visita, conforme disponibilidade'),
                    ),
                    Divider(color: Colors.black),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: dateController,
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Data Prevista',
                  icon: Icon(Icons.today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(), // Data inicial
                    lastDate: DateTime(2100), // Data final
                  );

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                    setState(() {
                      dateController.text = formattedDate;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: timeController,
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Hora Prevista',
                  icon: Icon(Icons.access_time),
                ),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (pickedTime != null) {
                    final now = DateTime.now();
                    final selectedTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
                    String formattedTime = DateFormat('HH:mm').format(selectedTime); // Formato 24 horas
                    setState(() {
                      timeController.text = formattedTime;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _saveAgendamento,
                child: const Text('Salvar Agendamento'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

void main() {
  runApp(
      const MaterialApp(
        home: AgendarVisitaPage(),
  ));
}
