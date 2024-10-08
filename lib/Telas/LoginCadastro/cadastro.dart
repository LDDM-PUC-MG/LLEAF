import 'package:calendario/Telas/LoginCadastro/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para o formato de data
import '../../Estilo/colors.dart'; // Importe o estilo de cores

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // Controlador para o campo de data
  TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  // Método para exibir o DatePicker e selecionar a data de nascimento
  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Caminho da imagem
                    width: 80, // Defina a largura da imagem
                    height: 80, // Defina a altura da imagem
                  ),
                  SizedBox(height: 16), // Espaçamento entre imagem e texto
                  Text(
                    'Faça seu cadastro!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3), // Cor da sombra
                          offset: Offset(2.0, 2.0), // Deslocamento da sombra
                          blurRadius: 4.0, // Desfoque da sombra
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: 'Digite seu melhor email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Digite seu nome de usuário',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Digite sua senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirme sua senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Campo de data de nascimento com DatePicker
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Data de nascimento',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context), // Exibe o seletor de data
                ),
              ),
              readOnly: true, // Define o campo como somente leitura
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Ação do botão acessar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  iconColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10, // Elevação da sombra
                  shadowColor: Colors.black.withOpacity(1), // Cor da sombra
                ),
                child: Text(
                  'Acessar',
                  style: TextStyle(
                    fontSize: 16,  // ou qualquer outro estilo que você queira aplicar
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  // Ação de navegação para a tela de login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()), // Redireciona para a LoginScreen
                  );
                },
                child: Text(
                  'Já possui conta? Faça login',
                  style: TextStyle(color: Colors.blue[900]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
