import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ulearn/screens/loading.dart';

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

class AppColors {
  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  AppColors._();

  static Map<int, Color> blue = <int, Color>{
    50: hexToColor('#006290'),
    100: hexToColor('#00354F')
  };

  static Map<int, Color> orange = <int, Color>{50: hexToColor('#D68910')};
}
