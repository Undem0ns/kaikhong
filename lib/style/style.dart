import 'package:flutter/material.dart';

class Style {
  Color lighColor = Colors.blue[100];
  Color primaryColor = Colors.blue[400];
  Color darkColor = Colors.blue[800];

  Widget textH1(String string, {Color color}) {
    return Text(
      string,
      style: TextStyle(
        color: color == null ? Colors.black : color,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget textH2(String string, {Color color}) {
    return Text(
      string,
      style: TextStyle(
        color: color == null ? Colors.black : color,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget textH3(String string, {Color color}) {
    return Text(
      string,
      style: TextStyle(
        color: color == null ? Colors.black : color,
        fontSize: 16,
      ),
    );
  }

  Decoration decoration() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Style().lighColor,
            Style().primaryColor,
          ],
        ),
      );
      
}
