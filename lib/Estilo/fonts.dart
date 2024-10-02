import 'package:flutter/material.dart';

class AppFonts {
  // Declare a variável para a fonte
  static const String fontFamily = 'Poppins';

  // Define uma função para obter o TextStyle com a fonte padrão
  static TextStyle get defaultStyle => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14, // Tamanho padrão, você pode mudar
    fontWeight: FontWeight.normal, // Peso padrão
  );

  // Outros estilos podem ser definidos aqui
  static TextStyle get headline1 => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w100, // Thin
  );

  static TextStyle get headline2 => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w200, // ExtraLight
  );

  static TextStyle get headline3 => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300, // Light
  );

  static TextStyle get headline4 => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400, // Regular
  );

  static TextStyle get headline5 => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500, // Medium
  );

  static TextStyle get headline6 => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600, // SemiBold
  );

  static TextStyle get bodyText1 => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700, // Bold
  );

  static TextStyle get bodyText2 => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w800, // ExtraBold
  );
}
