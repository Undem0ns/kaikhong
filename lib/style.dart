import 'package:flutter/material.dart';

class Style {
  Color darkColor = Colors.blue[400];
  Color lighColor = Colors.blue[300];
  Color primaryColor = Colors.blue[200];
  Color buttonlighColor = Colors.blue[100];

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
            Style().darkColor,
          ],
        ),
      );
}
