import 'package:flutter/material.dart';

class DetalhesVacinaPage extends StatelessWidget {
  final Map<String, dynamic> vacina;

  const DetalhesVacinaPage({Key? key, required this.vacina}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vacina['nome'] ?? 'Detalhes da Vacina'),
        backgroundColor: Colors.blueAccent.shade700,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    vacina['nome'] ?? 'Nome da Vacina',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent.shade700,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Divider(),
                _buildDetailRow(Icons.calendar_today, 'Nome', vacina['nome']),
                Divider(),
                _buildDetailRow(Icons.description, 'Marca', vacina['marca']),
                Divider(),
                _buildDetailRow(Icons.local_hospital, 'Descricao', vacina['descricao']),
                Divider(),
                _buildDetailRow(Icons.date_range, "Vencimento", vacina['validade'])
                // Adicione mais campos conforme necessário
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent.shade700),
          SizedBox(width: 16),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 18, color: Colors.black54),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
