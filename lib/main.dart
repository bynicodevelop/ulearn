import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leadee/screens/loading.dart';
import 'package:leadee/share/app_colors.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          primaryColor: AppColors.blue[100]),
      home: LoadingComponent(),
    );
  }
}
