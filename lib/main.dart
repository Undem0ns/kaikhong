import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kaikhong/style/style.dart';
import 'package:kaikhong/widget/report_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Style().primaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(),
        ),
        home: FutureBuilder(
          future: fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Error ${snapshot.error.toString()}');
              return Text('Something wrong');
            } else if (snapshot.hasData) {
              return ReportDetailPage();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
