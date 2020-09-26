import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leadee/services/auth.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
        useCountryCode: false,
        fallbackFile: 'en',
        basePath: 'assets/i18n',
        forcedLocale: Locale('en')),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await flutterI18nDelegate.load(null);

  runApp(App(flutterI18nDelegate));
}

class App extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  App(this.flutterI18nDelegate);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthService().user,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme:
                    GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
                primaryColor: Palette.blue[100]),
            home: Wrapper(),
            localizationsDelegates: [
              flutterI18nDelegate,
            ],
            builder: FlutterI18n.rootAppBuilder()));
  }
}
