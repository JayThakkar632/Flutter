import 'package:firebase_core/firebase_core.dart';
import 'package:first_flutter_demo_app/presentation/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'firebase_options.dart';
import 'presentation/splash/splash_screen.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    // DevicePreview(
    //   enabled: true,
    //   builder: (context) => const MyApp(),
    // ),
      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(


      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
        FormBuilderLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      home: HomeScreen(),
    );
  }
}

