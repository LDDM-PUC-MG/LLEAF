import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir links

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Quemsomos(), // Define a tela inicial
    );
  }
}

class Quemsomos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quem Somos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Text(
                  "LEAF",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit
                          .cover, 
                      width: 75,
                      height: 75,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Um aplicativo de organização pessoal e que permite armazenar, colecionar e relembrar memórias de momentos especiais.",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),

              const Text(
                "Quem Somos:",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2, // Duas colunas
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  // Card 1
                  _buildCard('assets/images/Perfil.png', 'Nome 1',
                      'https://www.linkedin.com/feed/', 'https://github.com'),
                  // Card 2
                  _buildCard('assets/images/Perfil.png', 'Nome 2',
                      'https://www.linkedin.com/feed/', 'https://github.com'),
                  // Card 3
                  _buildCard('assets/images/Perfil.png', 'Nome 3',
                      'https://www.linkedin.com/feed/', 'https://github.com'),
                  // Card 4
                  _buildCard('assets/images/Perfil.png', 'Nome 4',
                      'https://www.linkedin.com/feed/', 'https://github.com'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para construir cada card
  Widget _buildCard(String imagePath, String name, String link1, String link2) {
    return Column(
      children: [
        // Foto
        Image.asset(
          imagePath,
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 10),

        // Nome
        Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Botões para links com imagens
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _launchURL(link1);
              },
              child: Image.asset(
                'assets/images/Link1.png', // Imagem do botão 1
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {
                _launchURL(link2);
              },
              child: Image.asset(
                'assets/images/Link2.png', // Imagem do botão 2
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Função para abrir URLs
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
