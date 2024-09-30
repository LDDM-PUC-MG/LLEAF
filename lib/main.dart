import 'dart:math';
import 'package:calendar_slider/calendar_slider.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'fonts.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const Color primary = Color(0xFF131F89); // Cor primária
  static const Color secondary = Color(0xFF448AFF); // Cor secundária
  static const Color background = Color(0xFFFFFFFF); // Branco
  static const Color textPrimary = Color(0xFF000000); // Preto
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example for Calendar Slider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final CalendarSliderController _firstController = CalendarSliderController();

  late DateTime _selectedDateAppBBar;

  @override
  void initState() {
    super.initState();
    _selectedDateAppBBar = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarSlider(
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
            _selectedDateAppBBar = date;
          });
        },
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _firstController.goToDay(DateTime.now());
              },
              child: const Text("Go to today"),
            )
          ],
        ),
      ),
    );
  }
}
