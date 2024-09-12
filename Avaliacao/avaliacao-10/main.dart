import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Validação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _valueController = TextEditingController();

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Data é obrigatória';
    }
    final dateRegExp = RegExp(r'^\d{2}-\d{2}-\d{4}$');
    if (!dateRegExp.hasMatch(value)) {
      return 'Formato inválido. Use dd-mm-aaaa';
    }
    final parts = value.split('-');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    if (month < 1 || month > 12) {
      return 'Mês inválido';
    }
    if (day < 1 || day > 31) {
      return 'Dia inválido';
    }
    // Simplified date validation
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    }
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  String? _validateCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'CPF é obrigatório';
    }
    final cpfRegExp = RegExp(r'^\d{11}$');
    if (!cpfRegExp.hasMatch(value)) {
      return 'CPF inválido';
    }
    return null;
  }

  String? _validateValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Valor é obrigatório';
    }
    final valueRegExp = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!valueRegExp.hasMatch(value)) {
      return 'Valor inválido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          width: 350,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Formulário de Validação',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField('Data (dd-mm-aaaa)', _dateController, _validateDate),
                _buildTextField('Email', _emailController, _validateEmail),
                _buildTextField('CPF', _cpfController, _validateCPF),
                _buildTextField('Valor', _valueController, _validateValue),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Process data
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Formulário enviado com sucesso!')),
                      );
                    }
                  },
                  child: Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        keyboardType: label == 'Valor' ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
        validator: validator,
      ),
    );
  }
}
