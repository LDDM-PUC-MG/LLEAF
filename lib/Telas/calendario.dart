import 'package:calendar_slider/calendar_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import para pegar imagens
import 'dart:io'; // Para manipular arquivos de imagem
import 'package:calendario/Estilo/colors.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<Calendario> {
  final CalendarSliderController _firstController = CalendarSliderController();
  late DateTime data_selecionada;
  final Map<DateTime, Map<String, dynamic>> _memoria =
  {}; // Mapa para armazenar anotações e imagens
  List<File> imgs_selecionadas = []; // Armazena as imagens selecionadas

  // Função para exibir o diálogo para anotações
  void _salvarMemoria(BuildContext context) {
    TextEditingController _noteController = TextEditingController(
      text: _memoria[data_selecionada]?['text'] ?? '', // Preenche com a anotação existente se houver
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Memoria do Dia"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  hintText: "Digite aqui",
                ),
              ),
              const SizedBox(height: 10),
              _buildImageGallery(), // Exibe as imagens selecionadas
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _escolherImgs,
                child: const Text("Escolher Imagens"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo sem salvar
              },
            ),
            ElevatedButton(
              child: const Text("Salvar"),
              onPressed: () {
                // Salva a anotação e as imagens na data selecionada
                setState(() {
                  _memoria[data_selecionada] = {
                    'text': _noteController.text,
                    'images': imgs_selecionadas
                  };
                });
                Navigator.of(context).pop(); // Fecha o diálogo após salvar
              },
            ),
          ],
        );
      },
    );
  }

  void _msgPerdeuDia(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Mensagem"),
          content: const Text(
              "Perdeu o dia, mas tá tudo bem!! Amanhã você lembra!!"),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  // Função para escolher múltiplas imagens
  Future<void> _escolherImgs() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        imgs_selecionadas = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  // Widget para exibir as imagens selecionadas
  Widget _buildImageGallery() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: imgs_selecionadas.map((image) {
        return Container(
          width: 100, // Largura da imagem
          height: 100, // Altura da imagem
          child: ClipRRect(
            borderRadius:
            BorderRadius.circular(8.0), // Bordas arredondadas (opcional)
            child: Image.file(
              image,
              fit: BoxFit.cover, // Faz com que a imagem se ajuste ao container sem vazar
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    data_selecionada = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendário"),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          CalendarSlider(
            controller: _firstController,
            selectedDayPosition: SelectedDayPosition.center,
            fullCalendarScroll: FullCalendarScroll.vertical,
            backgroundColor: AppColors.primary,
            fullCalendarWeekDay: WeekDay.short,
            selectedTileBackgroundColor: Colors.white,
            monthYearButtonBackgroundColor: Colors.white,
            monthYearTextColor: Colors.black,
            tileBackgroundColor: AppColors.primary,
            selectedDateColor: Colors.black,
            dateColor: Colors.white,
            tileShadow: BoxShadow(
              color: Colors.black.withOpacity(1),
            ),
            locale: 'pt-br',
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 100)),
            lastDate: DateTime.now().add(const Duration(days: 100)),
            onDateSelected: (date) {
              setState(() {
                data_selecionada = date;
                imgs_selecionadas = _memoria[date]?['images'] ?? []; // Recupera as imagens se já existirem
              });
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0), // Adiciona padding em todos os lados
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _firstController.goToDay(DateTime.now());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 5, // Elevação da sombra
                            shadowColor: Colors.black.withOpacity(1), // Cor da sombra
                          ),
                          child: const Text(
                            "Voltar para hoje",
                            style: TextStyle(
                              color: AppColors.background,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            DateTime hoje = DateTime.now();
                            DateTime ontem = hoje.subtract(const Duration(days: 1));

                            if ((data_selecionada.day == hoje.day &&
                                data_selecionada.month == hoje.month &&
                                data_selecionada.year == hoje.year) ||
                                (data_selecionada.day == ontem.day &&
                                    data_selecionada.month == ontem.month &&
                                    data_selecionada.year == ontem.year)) {
                              _salvarMemoria(context);
                            } else {
                              _msgPerdeuDia(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 5, // Elevação da sombra
                            shadowColor: Colors.black.withOpacity(1), // Cor da sombra
                          ),
                          child: const Text("Adicionar Memoria"),
                        ),
                      ],
                    ),
                  ),
                  // Exibe a anotação e as imagens
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSecondary, // Cor de fundo do contêiner
                      borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Cor da sombra
                          blurRadius: 8.0, // Desfoque da sombra
                          offset: const Offset(0, 4), // Posição da sombra
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _memoria[data_selecionada]?['text'] != null
                              ? 'Memória do dia:\n${_memoria[data_selecionada]?['text']}'
                              : "Sem recordação",
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        _memoria[data_selecionada]?['images'] != null
                            ? _buildImageGallery()
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
